#!/usr/bin/env python3
"""
Generates recipes/<name>/package.lua for the core X11 + Wayland + toolkit
stack, from a single table of metadata below.

Every source's sha256 is left as a placeholder: PIN_ME. This sandbox can
only reach a short domain allowlist (github, pypi, npm, crates, ubuntu
archives) — not freedesktop.org / x.org / gnome.org / download.kde.org,
where these projects actually live. On a machine with normal internet
access, run:

    ./bloink-pin recipes/<name>/package.lua

(see tools/bloink-pin) to fetch each source and fill in the real digest.
Until then `bloink build` will correctly refuse to fetch these, because an
unpinned source is exactly the kind of unverifiable fetch it's designed
to reject.
"""
import os

R = os.path.join(os.path.dirname(__file__), "recipes")

# (name, version, description, license, homepage, url, deps, build_steps)
# deps entries: "name" (runtime) or ("name", True) for build_only
PKGS = [
    ("libffi", "3.4.6", "Foreign function interface library", "MIT",
     "https://sourceware.org/libffi/",
     "https://github.com/libffi/libffi/releases/download/v3.4.6/libffi-3.4.6.tar.gz",
     [],
     ["./configure --prefix=$out --disable-static", "make -j$(nproc)", "make install"]),

    ("expat", "2.6.2", "Stream-oriented XML parser", "MIT",
     "https://libexpat.github.io/",
     "https://github.com/libexpat/libexpat/releases/download/R_2_6_2/expat-2.6.2.tar.xz",
     [],
     ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("pkgconf", "2.3.0", "pkg-config compatible dependency metadata tool", "ISC",
     "https://github.com/pkgconf/pkgconf",
     "https://distfiles.ariadne.space/pkgconf/pkgconf-2.3.0.tar.gz",
     [],
     ["meson setup build --prefix=$out -Dtests=disabled", "ninja -C build install"]),

    ("zlib", "1.3.1", "Compression library used by nearly everything downstream",
     "Zlib", "https://zlib.net",
     "https://codeload.github.com/madler/zlib/tar.gz/refs/tags/v1.3.1",
     [], None),  # already hand-written and hash-verified; generator skips it

    ("wayland", "1.23.0", "Core Wayland protocol C library and scanner", "MIT",
     "https://wayland.freedesktop.org",
     "https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.23.0/downloads/wayland-1.23.0.tar.xz",
     ["libffi", ("expat", True)],
     ["meson setup build --prefix=$out -Ddocumentation=false -Dtests=false",
      "ninja -C build install"]),

    ("wayland-protocols", "1.36", "Additional Wayland protocol XML definitions", "MIT",
     "https://wayland.freedesktop.org",
     "https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/1.36/downloads/wayland-protocols-1.36.tar.xz",
     [("wayland", True)],
     ["meson setup build --prefix=$out -Dtests=false", "ninja -C build install"]),

    ("libxkbcommon", "1.7.0", "Keymap handling library (XKB) for Wayland and X11", "MIT",
     "https://xkbcommon.org",
     "https://xkbcommon.org/download/libxkbcommon-1.7.0.tar.xz",
     ["wayland", ("wayland-protocols", True)],
     ["meson setup build --prefix=$out -Denable-docs=false -Denable-wayland=true",
      "ninja -C build install"]),

    ("pixman", "0.43.4", "Low-level pixel manipulation library", "MIT",
     "https://pixman.org",
     "https://cairographics.org/releases/pixman-0.43.4.tar.gz",
     [],
     ["meson setup build --prefix=$out", "ninja -C build install"]),

    ("libdrm", "2.4.122", "Userspace interface to kernel DRM (GPU) subsystem", "MIT",
     "https://dri.freedesktop.org",
     "https://dri.freedesktop.org/libdrm/libdrm-2.4.122.tar.xz",
     [],
     ["meson setup build --prefix=$out", "ninja -C build install"]),

    ("mesa", "24.1.0", "OpenGL/Vulkan/EGL implementation (GPU drivers)", "MIT",
     "https://mesa3d.org",
     "https://archive.mesa3d.org/mesa-24.1.0.tar.xz",
     ["libdrm", "wayland", ("wayland-protocols", True), "libxkbcommon",
      "zlib", "libx11", "libxcb", "expat"],
     ["meson setup build --prefix=$out -Dplatforms=x11,wayland "
      "-Dgallium-drivers=swrast,zink -Dvulkan-drivers=",
      "ninja -C build install"]),

    ("freetype", "2.13.2", "Font rendering engine (built without harfbuzz to break the freetype<->harfbuzz cycle)",
     "FTL", "https://freetype.org",
     "https://sourcebloink.net/projects/freetype/files/freetype2/2.13.2/freetype-2.13.2.tar.xz/download",
     ["zlib"],
     ["meson setup build --prefix=$out -Dharfbuzz=disabled -Dbrotli=disabled",
      "ninja -C build install"]),

    ("harfbuzz", "8.5.0", "OpenType text shaping engine", "MIT",
     "https://harfbuzz.github.io",
     "https://github.com/harfbuzz/harfbuzz/releases/download/8.5.0/harfbuzz-8.5.0.tar.xz",
     ["freetype", "glib"],
     ["meson setup build --prefix=$out -Dfreetype=enabled -Dglib=enabled",
      "ninja -C build install"]),

    ("fontconfig", "2.15.0", "Font matching and configuration library", "MIT-like",
     "https://fontconfig.org",
     "https://fontconfig.org/release/fontconfig-2.15.0.tar.xz",
     ["freetype", "expat", "zlib"],
     ["meson setup build --prefix=$out", "ninja -C build install"]),

    ("cairo", "1.18.0", "2D vector graphics library", "LGPL-2.1-or-later OR MPL-1.1",
     "https://cairographics.org",
     "https://cairographics.org/releases/cairo-1.18.0.tar.xz",
     ["pixman", "freetype", "fontconfig", "libx11", "libxext", "libxrender"],
     ["meson setup build --prefix=$out -Dtests=disabled", "ninja -C build install"]),

    ("glib", "2.80.2", "Core low-level application/utility library (GObject, GIO, etc.)",
     "LGPL-2.1-or-later", "https://gitlab.gnome.org/GNOME/glib",
     "https://download.gnome.org/sources/glib/2.80/glib-2.80.2.tar.xz",
     ["libffi", "zlib", ("pkgconf", True)],
     ["meson setup build --prefix=$out -Dtests=false", "ninja -C build install"]),

    ("pango", "1.54.0", "Text layout and internationalization engine", "LGPL-2.1-or-later",
     "https://pango.gnome.org",
     "https://download.gnome.org/sources/pango/1.54/pango-1.54.0.tar.xz",
     ["cairo", "harfbuzz", "freetype", "fontconfig", "glib"],
     ["meson setup build --prefix=$out", "ninja -C build install"]),

    ("gdk-pixbuf", "2.42.12", "Image loading library for GTK", "LGPL-2.1-or-later",
     "https://gitlab.gnome.org/GNOME/gdk-pixbuf",
     "https://download.gnome.org/sources/gdk-pixbuf/2.42/gdk-pixbuf-2.42.12.tar.xz",
     ["glib", ("pkgconf", True)],
     ["meson setup build --prefix=$out -Dman=false -Dgio_sniffing=false",
      "ninja -C build install"]),

    ("xorgproto", "2024.1", "X11 protocol headers (no library, headers only)", "MIT",
     "https://gitlab.freedesktop.org/xorg/proto/xorgproto",
     "https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2024.1.tar.xz",
     [],
     ["meson setup build --prefix=$out", "ninja -C build install"]),

    ("libxau", "1.0.11", "X11 authorization library", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXau-1.0.11.tar.xz",
     [("xorgproto", True)],
     ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxdmcp", "1.1.5", "X Display Manager Control Protocol library", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXdmcp-1.1.5.tar.xz",
     [("xorgproto", True)],
     ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxcb", "1.17.0", "X11 protocol client library (replaces Xlib's core transport)", "MIT",
     "https://xcb.freedesktop.org", "https://xorg.freedesktop.org/archive/individual/lib/libxcb-1.17.0.tar.xz",
     ["libxau", "libxdmcp", ("xorgproto", True)],
     ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libx11", "1.8.9", "Core X11 client library (Xlib)", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libX11-1.8.9.tar.xz",
     ["libxcb", ("xorgproto", True)],
     ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxext", "1.3.6", "Common X11 protocol extensions library", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXext-1.3.6.tar.gz",
     ["libx11"], ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxrender", "0.9.11", "X Rendering Extension client library", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXrender-0.9.11.tar.gz",
     ["libx11"], ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxfixes", "6.0.1", "X Fixes extension client library", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXfixes-6.0.1.tar.gz",
     ["libx11", ("xorgproto", True)], ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxrandr", "1.5.4", "X Resize, Rotate and Reflect extension client library", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXrandr-1.5.4.tar.gz",
     ["libx11", "libxext", "libxrender", ("xorgproto", True)],
     ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxi", "1.8.1", "X Input extension client library", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXi-1.8.1.tar.gz",
     ["libx11", "libxext", ("xorgproto", True)],
     ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxcursor", "1.2.2", "X cursor management library", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXcursor-1.2.2.tar.gz",
     ["libx11", "libxrender", "libxfixes"],
     ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxinerama", "1.1.5", "Xinerama multi-monitor extension client library", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXinerama-1.1.5.tar.gz",
     ["libx11", "libxext"], ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxdamage", "1.1.6", "X Damage extension client library", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXdamage-1.1.6.tar.gz",
     ["libx11", ("xorgproto", True)], ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxcomposite", "0.4.6", "X Composite extension client library", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXcomposite-0.4.6.tar.gz",
     ["libx11", ("xorgproto", True)], ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxtst", "1.2.4", "X Test extension client library (input synthesis)", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libXtst-1.2.4.tar.gz",
     ["libx11", "libxext", ("xorgproto", True)], ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxkbfile", "1.1.3", "XKB file format library (used by X servers/compositors)", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libxkbfile-1.1.3.tar.gz",
     ["libx11"], ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxshmfence", "1.3.2", "Shared memory fences for X11/DRI3 sync", "MIT",
     "https://x.org", "https://xorg.freedesktop.org/archive/individual/lib/libxshmfence-1.3.2.tar.gz",
     [("xorgproto", True)], ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libepoxy", "1.5.10", "GL/GLES/EGL/GLX function pointer dispatch library", "MIT",
     "https://github.com/anholt/libepoxy",
     "https://github.com/anholt/libepoxy/releases/download/1.5.10/libepoxy-1.5.10.tar.xz",
     ["libx11"], ["meson setup build --prefix=$out", "ninja -C build install"]),

    ("graphene", "1.10.8", "Thin layer of graphic data types (used by GTK4)", "MIT",
     "https://ebassi.github.io/graphene/",
     "https://github.com/ebassi/graphene/releases/download/1.10.8/graphene-1.10.8.tar.xz",
     ["glib"], ["meson setup build --prefix=$out -Dtests=false", "ninja -C build install"]),

    ("json-glib", "1.8.0", "JSON parser/generator built on GLib types", "LGPL-2.1-or-later",
     "https://gitlab.gnome.org/GNOME/json-glib",
     "https://download.gnome.org/sources/json-glib/1.8/json-glib-1.8.0.tar.xz",
     ["glib"], ["meson setup build --prefix=$out", "ninja -C build install"]),

    ("libxslt", "1.1.39", "XSLT processing library (libxml2-based)", "MIT",
     "https://gitlab.gnome.org/GNOME/libxslt",
     "https://download.gnome.org/sources/libxslt/1.1/libxslt-1.1.39.tar.xz",
     ["libxml2"], ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("libxml2", "2.12.7", "XML parsing library", "MIT",
     "https://gitlab.gnome.org/GNOME/libxml2",
     "https://download.gnome.org/sources/libxml2/2.12/libxml2-2.12.7.tar.xz",
     ["zlib"], ["./configure --prefix=$out", "make -j$(nproc)", "make install"]),

    ("shared-mime-info", "2.4", "Freedesktop shared MIME-type database", "GPL-2.0-or-later/AFL",
     "https://gitlab.freedesktop.org/xdg/shared-mime-info",
     "https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/2.4/shared-mime-info-2.4.tar.gz",
     ["glib", ("libxml2", True)], ["meson setup build --prefix=$out", "ninja -C build install"]),

    ("at-spi2-core", "2.52.0", "Accessibility bus and core protocol (used by GTK)", "LGPL-2.1-or-later",
     "https://gitlab.gnome.org/GNOME/at-spi2-core",
     "https://download.gnome.org/sources/at-spi2-core/2.52/at-spi2-core-2.52.0.tar.xz",
     ["glib", "dbus", "libx11", "libxtst", "libxi"],
     ["meson setup build --prefix=$out -Dx11=yes", "ninja -C build install"]),

    ("dbus", "1.15.8", "Message bus for inter-process/session communication", "GPL-2.0-or-later/AFL-2.1",
     "https://dbus.freedesktop.org",
     "https://dbus.freedesktop.org/releases/dbus/dbus-1.15.8.tar.xz",
     ["expat"],
     ["meson setup build --prefix=$out -Dsystemd=disabled -Dlaunchd=disabled",
      "ninja -C build install"]),

    ("seatd", "0.9.1", "Minimal seat/session management daemon and library (init-agnostic)",
     "MIT", "https://sr.ht/~kennylevinsen/seatd/",
     "https://git.sr.ht/~kennylevinsen/seatd/archive/0.9.1.tar.gz",
     [],
     ["meson setup build --prefix=$out -Dlibseat-seatd=enabled -Dserver=enabled",
      "ninja -C build install"]),

    ("libinput", "1.26.1", "Input device handling library used by Wayland compositors",
     "MIT", "https://www.freedesktop.org/wiki/Software/libinput/",
     "https://gitlab.freedesktop.org/libinput/libinput/-/archive/1.26.1/libinput-1.26.1.tar.gz",
     ["seatd", "libxkbcommon", ("mtdev", True)],
     ["meson setup build --prefix=$out -Dudev=disabled -Ddebug-gui=false -Dtests=false "
      "-Dlibwacom=false",
      "ninja -C build install"]),

    ("gtk3", "3.24.43", "GTK3 widget toolkit (X11 + Wayland backends)", "LGPL-2.1-or-later",
     "https://www.gtk.org",
     "https://download.gnome.org/sources/gtk+/3.24/gtk+-3.24.43.tar.xz",
     ["glib", "cairo", "pango", "gdk-pixbuf", "libepoxy", "wayland",
      ("wayland-protocols", True), "libxkbcommon", "libx11", "libxext",
      "libxrandr", "libxi", "libxcursor", "libxdamage", "libxfixes",
      "at-spi2-core", "shared-mime-info"],
     ["meson setup build --prefix=$out -Dx11-backend=true -Dwayland-backend=true "
      "-Dbroadway-backend=false -Dintrospection=disabled",
      "ninja -C build install"]),

    ("gtk4", "4.14.4", "GTK4 widget toolkit (X11 + Wayland backends)", "LGPL-2.1-or-later",
     "https://www.gtk.org",
     "https://download.gnome.org/sources/gtk/4.14/gtk-4.14.4.tar.xz",
     ["glib", "cairo", "pango", "gdk-pixbuf", "libepoxy", "graphene",
      "wayland", ("wayland-protocols", True), "libxkbcommon", "libx11",
      "libxext", "libxrandr", "libxi", "libxcursor", "libxdamage",
      "libxfixes", "at-spi2-core"],
     ["meson setup build --prefix=$out -Dx11-backend=true -Dwayland-backend=true "
      "-Dbroadway-backend=false -Dintrospection=disabled -Dmedia-gstreamer=disabled",
      "ninja -C build install"]),

    ("extra-cmake-modules", "6.3.0", "Shared CMake modules used across KDE Frameworks", "BSD-3-Clause",
     "https://api.kde.org/ecm/",
     "https://download.kde.org/stable/frameworks/6.3/extra-cmake-modules-6.3.0.tar.xz",
     [],
     ["cmake -B build -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Release",
      "cmake --build build -j$(nproc)", "cmake --install build"]),

    ("plasma-wayland-protocols", "1.14.0", "KDE Plasma's Wayland protocol XML extensions",
     "BSD-3-Clause", "https://invent.kde.org/libraries/plasma-wayland-protocols",
     "https://download.kde.org/stable/plasma/wayland-protocols/plasma-wayland-protocols-1.14.0.tar.xz",
     [],
     ["cmake -B build -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Release",
      "cmake --build build -j$(nproc)", "cmake --install build"]),

    ("kwayland", "6.3.0", "Qt/KDE wrapper around wayland-client and Wayland protocols",
     "LGPL-2.1-or-later", "https://invent.kde.org/frameworks/kwayland",
     "https://download.kde.org/stable/frameworks/6.3/kwayland-6.3.0.tar.xz",
     ["extra-cmake-modules", "qtbase6", "qtwayland6", "wayland",
      "plasma-wayland-protocols"],
     ["cmake -B build -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Release",
      "cmake --build build -j$(nproc)", "cmake --install build"]),

    ("qtbase6", "6.7.2", "Qt6 core, GUI, and platform-integration modules", "LGPL-3.0-only OR GPL-2.0-only",
     "https://www.qt.io",
     "https://download.qt.io/official_releases/qt/6.7/6.7.2/submodules/qtbase-everywhere-src-6.7.2.tar.xz",
     ["mesa", "wayland", ("wayland-protocols", True), "libxkbcommon",
      "libx11", "libxcb", "libxext", "libxrandr", "libxi", "libxrender",
      "libxfixes", "fontconfig", "freetype", "zlib", "dbus"],
     ["cmake -B build -GNinja -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Release "
      "-DFEATURE_dbus=ON -DFEATURE_xcb=ON",
      "cmake --build build -j$(nproc)", "cmake --install build"]),

    ("qtwayland6", "6.7.2", "Qt6 Wayland platform plugin and compositor API", "LGPL-3.0-only OR GPL-2.0-only",
     "https://www.qt.io",
     "https://download.qt.io/official_releases/qt/6.7/6.7.2/submodules/qtwayland-everywhere-src-6.7.2.tar.xz",
     ["qtbase6", "wayland", ("wayland-protocols", True), "libxkbcommon"],
     ["cmake -B build -GNinja -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Release "
      "-DQt6_DIR=$BLOINK_DEP_QTBASE6/lib/cmake/Qt6",
      "cmake --build build -j$(nproc)", "cmake --install build"]),

    ("librewolf", "128.0-1", "Privacy-hardened Firefox fork (the package nixpkgs support "
     "for is notoriously weak) — recipe stubbed pending real build integration",
     "MPL-2.0", "https://librewolf.net",
     "https://gitlab.com/librewolf-community/browser/source/-/archive/128.0-1/source-128.0-1.tar.gz",
     ["gtk3", "dbus", "pango", "cairo", "fontconfig", "freetype", "libx11",
      "libxext", "libxrandr", "libxi", "libxcomposite", "libxdamage",
      "libxfixes", "libxtst"],
     ["echo 'librewolf vendors its own toolchain (rust, node) and mozconfig; ' "
      "'wire up ./mach build --prefix=\\$out here once bloink supports a build-time ' "
      "'network allowance for the vendored cargo/npm fetches' >&2",
      "false"]),
]


def lua_bool(v):
    return "true" if v else "false"


def gen(name, version, description, license_, homepage, url, deps, build):
    lines = []
    lines.append(f"-- recipes/{name}/package.lua")
    lines.append("-- GENERATED starter recipe. sha256 is a PIN_ME placeholder because")
    lines.append("-- this build environment can't reach the upstream host to fetch and")
    lines.append("-- hash the real tarball (see gen_recipes.py docstring / docs/PHILOSOPHY.md).")
    lines.append("-- Run tools/bloink-pin on this file from a machine with normal internet")
    lines.append("-- access before `bloink build` will accept it.")
    lines.append("return {")
    lines.append(f'  name = "{name}",')
    lines.append(f'  version = "{version}",')
    desc = description.replace('"', '\\"')
    lines.append(f'  description = "{desc}",')
    lines.append(f'  license = "{license_}",')
    lines.append(f'  homepage = "{homepage}",')
    lines.append("")
    lines.append("  sources = {")
    lines.append("    {")
    lines.append(f'      url = "{url}",')
    lines.append('      sha256 = "PIN_ME", -- run tools/bloink-pin to fill this in')
    lines.append("    },")
    lines.append("  },")
    lines.append("")
    lines.append("  deps = {")
    for d in deps:
        if isinstance(d, tuple):
            lines.append(f'    {{ name = "{d[0]}", build_only = true }},')
        else:
            lines.append(f'    {{ name = "{d}" }},')
    lines.append("  },")
    lines.append("")
    lines.append("  build = {")
    for step in build:
        s = step.replace('"', '\\"')
        lines.append(f'    "{s}",')
    lines.append("  },")
    lines.append("}")
    return "\n".join(lines) + "\n"


def main():
    for name, version, desc, lic, home, url, deps, build in PKGS:
        if build is None:
            continue  # hand-written already (zlib)
        d = os.path.join(R, name)
        os.makedirs(d, exist_ok=True)
        with open(os.path.join(d, "package.lua"), "w") as f:
            f.write(gen(name, version, desc, lic, home, url, deps, build))
        print("wrote", name)


if __name__ == "__main__":
    main()
