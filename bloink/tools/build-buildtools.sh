#!/bin/sh
# tools/build-buildtools.sh
#
# Builds/installs ninja, meson, wheel, and setuptools into fs/ — the four
# things most of the recipes under recipes/ need at build time, none of
# which should need a working pip/wheel bootstrap to get in place.
#
# - ninja: actually compiled from source (it's C++).
# - meson, wheel, setuptools: pure-Python. Installed the same way pip
#   would, minus pip: a wheel file is just a zip, so this script unzips
#   each one straight into fs/'s site-packages and hand-writes the
#   console-script wrapper pip would normally generate, read out of the
#   wheel's own dist-info/entry_points.txt (no guessing at entry points —
#   this script parses the real metadata each wheel ships).
#
# Usage:
#   ./tools/build-buildtools.sh [path-to-fs] [python-version]
#   ./tools/build-buildtools.sh ../fs 3.12
#
# Defaults: fs = ./fs (relative to repo root), python version is
# auto-detected from `python3 --version` if not given.
#
# Uses wget --no-check-certificate for the same reason as bloink-pin: no
# ca-certificates bundle on this box yet. The sha256 pins below are the
# real trust boundary — drop the flag once make-ca is bootstrapped.

set -eu

FS="${1:-fs}"
PYVER="${2:-}"

if [ -z "$PYVER" ]; then
    PYVER=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
fi

SITE="$FS/usr/lib/python${PYVER}/site-packages"
BIN="$FS/usr/bin"
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

mkdir -p "$SITE" "$BIN"

fetch_verify() {
    # $1 = url, $2 = expected sha256, $3 = output path
    echo "==> fetching $1" >&2
    wget -q --no-check-certificate --tries=3 -O "$3" "$1"
    got=$(sha256sum "$3" | cut -d' ' -f1)
    if [ "$got" != "$2" ]; then
        echo "!! sha256 mismatch for $1" >&2
        echo "   expected: $2" >&2
        echo "   got:      $got" >&2
        exit 1
    fi
}

# Reads [console_scripts] out of a wheel's *.dist-info/entry_points.txt
# (already unzipped into $SITE) and writes a real wrapper for each one —
# same mechanism pip uses, just done by hand.
install_console_scripts() {
    # $1 = dist-info dir name (e.g. "wheel-0.48.0.dist-info")
    dist_info="$SITE/$1"
    ep="$dist_info/entry_points.txt"
    [ -f "$ep" ] || return 0

    python3 - "$ep" "$BIN" "$PYVER" << 'PYEOF'
import sys, os, configparser, stat

ep_path, bindir, pyver = sys.argv[1], sys.argv[2], sys.argv[3]
cp = configparser.ConfigParser()
cp.read(ep_path)
if "console_scripts" not in cp:
    sys.exit(0)

for name, target in cp["console_scripts"].items():
    module, _, func = target.partition(":")
    script_path = os.path.join(bindir, name)
    with open(script_path, "w") as f:
        f.write("#!/usr/bin/python3\n")
        f.write("import sys\n")
        f.write(f"from {module} import {func or 'main'}\n")
        f.write(f"sys.exit({func or 'main'}())\n")
    st = os.stat(script_path)
    os.chmod(script_path, st.st_mode | stat.S_IEXEC | stat.S_IXGRP | stat.S_IXOTH)
    print(f"  installed console script: {name} -> {module}:{func}", file=sys.stderr)
PYEOF
}

install_wheel() {
    # $1 = name, $2 = url, $3 = sha256
    name="$1"; url="$2"; sha="$3"
    whl="$WORK/$(basename "$url")"
    fetch_verify "$url" "$sha" "$whl"
    echo "==> unpacking $name into $SITE" >&2
    unzip -qo "$whl" -d "$SITE"
    dist_info=$(unzip -l "$whl" | grep -oE '[A-Za-z0-9_.-]+\.dist-info' | head -1)
    if [ -n "$dist_info" ]; then
        install_console_scripts "$dist_info"
    fi
}

echo "### setuptools ###" >&2
install_wheel "setuptools" \
    "https://files.pythonhosted.org/packages/95/9c/c510029fc6ef33a6275cd2c5d3cecd6613dfd6aa401d57c54f1c18852ccf/setuptools-84.0.0-py3-none-any.whl" \
    "51a52592b3b99e102b609654876bd65f19f999935166d1352678931132b0c670"
# setuptools ships no console_scripts of its own — it's a library other
# packages' build backends import, not a CLI. Nothing more to do here.

echo "### wheel ###" >&2
install_wheel "wheel" \
    "https://files.pythonhosted.org/packages/2e/29/69cfbb602cd91690c55d38ba9fe53e6a7e76a6fa647bf38f19c138d25449/wheel-0.48.0-py3-none-any.whl" \
    "3217dcc807155e45db462d7ef2431f5ddda0d7273b700d05a67b271ceb1287ab"

echo "### meson ###" >&2
# meson's source tarball, not its wheel: it ships a self-locating
# meson.py at the top level that finds its own sibling mesonbuild/ dir
# with zero install step (verified — this is meson's own documented
# behavior, not a hack). No entry_points.txt involved, so this one's
# handled separately from install_wheel above.
meson_tar="$WORK/meson-1.12.0.tar.gz"
fetch_verify \
    "https://files.pythonhosted.org/packages/48/91/d58a3eb45ed54bf32b96806dd2f4efd407f7a9675953e15e8ef257840a0d/meson-1.12.0.tar.gz" \
    "88afe0c20e52030218924ac37d0c81c59b4b5f3ae3752c8c6d7470c7d365886c" \
    "$meson_tar"
tar xzf "$meson_tar" -C "$WORK"
mkdir -p "$FS/usr/lib/meson"
cp -r "$WORK/meson-1.12.0/meson.py" "$WORK/meson-1.12.0/mesonbuild" "$FS/usr/lib/meson/"
cat > "$BIN/meson" << 'WRAP'
#!/bin/sh
exec /usr/bin/python3 /usr/lib/meson/meson.py "$@"
WRAP
chmod +x "$BIN/meson"
echo "  installed: meson -> /usr/lib/meson/meson.py" >&2

echo "### ninja ###" >&2
# The only compiled one of the four. Point NINJA_TARBALL at wherever
# ninja-1.13.2.tar.gz already lives if it's not next to this script.
NINJA_TARBALL="${NINJA_TARBALL:-ninja-1.13.2.tar.gz}"
if [ -f "$NINJA_TARBALL" ]; then
    tar xzf "$NINJA_TARBALL" -C "$WORK"
    ninja_src=$(find "$WORK" -maxdepth 1 -name 'ninja-*' -type d | head -1)
    (cd "$ninja_src" && python3 configure.py --bootstrap)
    install -vm755 "$ninja_src/ninja" "$BIN/ninja"
    echo "  installed: ninja -> $BIN/ninja" >&2
else
    echo "  !! $NINJA_TARBALL not found — skipping ninja." >&2
    echo "     set NINJA_TARBALL=/path/to/ninja-1.13.2.tar.gz and rerun," >&2
    echo "     or build it manually (see docs/INSTALL.md)." >&2
fi

echo "" >&2
echo "done. installed under: $FS" >&2
echo "  $SITE/{setuptools,wheel,mesonbuild}" >&2
echo "  $BIN/{meson,wheel,ninja}" >&2
