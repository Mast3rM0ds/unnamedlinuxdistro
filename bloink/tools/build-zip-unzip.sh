#!/bin/sh
# tools/build-zip-unzip.sh
#
# Builds unzip and zip into fs/ from upstream Info-ZIP sources (unzip 6.0,
# zip 3.0) plus the Debian/Ubuntu patch set on top of them — ~30 patches
# for unzip (CVE fixes going back to 2014, big-file/UTF-8 fixes) and 13
# for zip (two real buffer-overflow fixes, hardening). Info-ZIP hasn't
# cut a new release since 2009; the distro patch sets are the actual
# maintained version of this code at this point.
#
# This exists to break the chicken-and-egg problem: build-buildtools.sh
# (meson/ninja/wheel/setuptools) needs `unzip` to unpack wheel files, so
# unzip has to come from somewhere that isn't "already have unzip."
#
# Both builds were verified end to end while writing this script: patches
# applied cleanly against the real unpacked upstream sources, and both
# resulting binaries were compiled with musl-gcc and actually run
# (`unzip` printed its usage banner, `zip -h` printed its real version
# banner) — not just assumed to compile.
#
# Usage:
#   ./tools/build-zip-unzip.sh [path-to-fs]
#
# Uses wget --no-check-certificate, same rationale as bloink-pin and
# build-buildtools.sh: the sha256 pins below are the actual trust
# boundary here, not the TLS handshake.

set -eu

FS="${1:-fs}"
BIN="$FS/usr/bin"
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

mkdir -p "$BIN"

# Pick a compiler. On a glibc dev host cross-targeting musl, musl-gcc is
# the wrapper that does that. On a *native* musl system (Alpine and
# friends), there's no such wrapper — the system's own cc/gcc already
# targets musl directly, so use that instead.
if command -v musl-gcc >/dev/null 2>&1; then
    BUILD_CC=musl-gcc
elif command -v cc >/dev/null 2>&1; then
    BUILD_CC=cc
else
    BUILD_CC=gcc
fi

# Force C17 semantics regardless of the host compiler's own default.
# This 2008-2009-era code relies on old-style "unspecified arguments"
# empty-parens declarations (e.g. `struct tm *gmtime(), *localtime();`
# in unzip's unix/unxcfg.h) that were valid through C17 but became a
# hard "conflicting types" error once a compiler's default standard
# moved to C23, where empty parens instead mean "takes zero arguments".
# Reproduced and confirmed on the actual unzip source: fails under
# -std=gnu2x, compiles clean under -std=gnu17. Embedded into $CC itself
# (not CFLAGS) because zip's Makefile does `CFLAGS = ...` — a plain
# assignment, not `?=` — so overriding CFLAGS on the make command line
# would silently drop required flags like -DUNIX instead of adding to
# them.
BUILD_CC="$BUILD_CC -std=gnu17"
echo "==> using CC='$BUILD_CC'" >&2

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

apply_patches() {
    # $1 = source dir, $2 = patches dir (with a series file)
    srcdir="$1"; patchdir="$2"
    while IFS= read -r p; do
        [ -n "$p" ] || continue
        echo "  applying $p" >&2
        patch -d "$srcdir" -p1 --forward -s < "$patchdir/$p"
    done < "$patchdir/series"
}

# ---------------------------------------------------------------- unzip --
echo "### unzip ###" >&2

orig="$WORK/unzip_6.0.orig.tar.gz"
deb="$WORK/unzip_6.0-28ubuntu4.1.debian.tar.xz"
fetch_verify \
    "http://archive.ubuntu.com/ubuntu/pool/main/u/unzip/unzip_6.0.orig.tar.gz" \
    "036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37" \
    "$orig"
fetch_verify \
    "http://archive.ubuntu.com/ubuntu/pool/main/u/unzip/unzip_6.0-28ubuntu4.1.debian.tar.xz" \
    "d123c8e6972dbdd17ba1a4920fb57ed2ede9237dbae149dcbf55df829c77baf3" \
    "$deb"

tar xzf "$orig" -C "$WORK"
tar xJf "$deb" -C "$WORK"
apply_patches "$WORK/unzip60" "$WORK/debian/patches"

echo "  building..." >&2
make -C "$WORK/unzip60" -f unix/Makefile generic CC="$BUILD_CC" >/dev/null

install -vm755 "$WORK/unzip60/unzip"    "$BIN/unzip"
install -vm755 "$WORK/unzip60/funzip"   "$BIN/funzip"
install -vm755 "$WORK/unzip60/unzipsfx" "$BIN/unzipsfx"
echo "  installed: unzip, funzip, unzipsfx -> $BIN" >&2

rm -rf "$WORK/unzip60" "$WORK/debian"

# ------------------------------------------------------------------ zip --
echo "### zip ###" >&2

orig="$WORK/zip_3.0.orig.tar.gz"
deb="$WORK/zip_3.0-13ubuntu0.2.debian.tar.xz"
fetch_verify \
    "http://archive.ubuntu.com/ubuntu/pool/main/z/zip/zip_3.0.orig.tar.gz" \
    "f0e8bb1f9b7eb0b01285495a2699df3a4b766784c1765a8f1aeedf63c0806369" \
    "$orig"
fetch_verify \
    "http://archive.ubuntu.com/ubuntu/pool/main/z/zip/zip_3.0-13ubuntu0.2.debian.tar.xz" \
    "efb0b43598952a2e029c0ce4793b99d91119609ef14d615449642817f38d9df6" \
    "$deb"

tar xzf "$orig" -C "$WORK"
tar xJf "$deb" -C "$WORK"
apply_patches "$WORK/zip30" "$WORK/debian/patches"

echo "  building..." >&2
make -C "$WORK/zip30" -f unix/Makefile generic CC="$BUILD_CC" >/dev/null

install -vm755 "$WORK/zip30/zip"       "$BIN/zip"
install -vm755 "$WORK/zip30/zipcloak"  "$BIN/zipcloak"
install -vm755 "$WORK/zip30/zipnote"   "$BIN/zipnote"
install -vm755 "$WORK/zip30/zipsplit"  "$BIN/zipsplit"
echo "  installed: zip, zipcloak, zipnote, zipsplit -> $BIN" >&2

echo "" >&2
echo "done. installed under: $FS" >&2
echo "  $BIN/{unzip,funzip,unzipsfx,zip,zipcloak,zipnote,zipsplit}" >&2
