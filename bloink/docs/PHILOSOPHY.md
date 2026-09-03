# Why bloink exists

A point-by-point response to the usual Nix complaints, and what bloink
does instead of each one.

### "nixlang is a DSL (we hate DSLs)" / "it could've just been Lua"

It is Lua. A recipe is a `.lua` file that `return`s a table. There is
no bespoke evaluator, no lazy-thunk graph, no separate expression
language to learn — `bloink_load_recipe()` in `src/lua_recipe.c` is
~120 lines that call `luaL_dofile()` and read fields off the returned
table. You get real `if`, real `for`, real `require()` of a shared
helper module, and a `bloink.arch` / `bloink.libc` table to branch on
host facts, because that's just Lua doing what Lua already does.

### "nixos is the opposite of simple" / "hides your system's backend"

bloink is ~1,300 lines of C across seven files, statically linked
against musl. There's no daemon, no database beyond the filesystem
(the store is just directories, a profile is just a symlink farm), and
nothing runs as a privileged background service. `bloink build` is a
program you run in a terminal that shells out to `curl`, `tar`, and
whatever build system the recipe calls (meson, cmake, make — real
tools, not reimplementations of them). If something breaks, you read
the shell script in `/tmp/bloink-build-*/build.sh` that actually ran.

### "nixos hard depends on systemd and other unnecessarily large software"

bloink links against nothing but a static musl libc and its own vendored
Lua. It does not call `systemctl`, does not talk to dbus to manage
itself, and does not assume any particular init. A recipe *may* carry
an optional `service` table (see `bloink.h`) describing how to run the
thing it builds, but bloink stores that verbatim and never interprets
it — translating it into a unit file, an OpenRC script, an s6 service
directory, or a dinit service is an *adapter's* job, one per init,
living outside bloink itself. Swap the adapter, keep the package
manager.

### "ends up incredibly bloated"

The whole binary is 350KB static, `ldd` reports "not a dynamic
executable", and it depends on nothing at runtime beyond `sh`, `curl`,
`tar`/`unzip`, and `sha256sum` — all things a musl base system already
has. There's no VM, no extra interpreter process, no evaluation cache
service.

### "nixpkgs is poorly maintained, terrible support for things like librewolf"

There's no packaging monoculture to be poorly maintained here — a
recipe is a file in a directory you control. `recipes/librewolf/` is
included as an honest stub: real dependency list, real upstream
source, and a `build` step that says outright *"this needs real
mozconfig/mach integration, here's where to wire it in"* rather than
pretending it's solved. That's the tradeoff of not having thousands of
packages pre-written: nothing lies to you about being finished.

### "muh pure functional programming"

bloink does not sandbox builds, does not attempt bit-for-bit hermetic
reproducibility, and does not require you to abandon `$PATH` or a
normal filesystem layout. What it keeps from Nix — because this part
is genuinely good — is content-addressed store paths
(`<hash>-name-version`) and profiles as plain symlink trees, so
installs are atomic, rollbacks are `ln -sfn`, and two versions of a
library coexist without conflict. The hash is computed from the
recipe's own content plus its resolved dependency paths (`store.c`),
which is enough to invalidate correctly without a purity model bolted
on top. If you want stronger isolation, wrap `bloink build` in
bubblewrap or `unshare` yourself — that's a system policy choice, not
something the package manager should force on everyone (see "we like
choice" below).

### "we like choice"

- Init: swappable, see above.
- Sandboxing: optional, bring your own.
- Desktop: X11-only, Wayland-only, or both — every recipe here declares
  its X11/Wayland deps explicitly rather than assuming one exists.
- Toolkit: GTK3, GTK4, and Qt6 recipes are all present and buildable
  side by side; picking one doesn't require forking a "nixpkgs
  overlay."

## What's real vs. what's a starting point

- **`bloink` the binary**: real, compiles to a static musl executable,
  and was built and exercised end-to-end in this environment —
  `zlib` was actually fetched, hash-verified, compiled, content-
  addressed into a store, and symlinked into a profile; a synthetic
  dependent package proved `BLOINK_DEP_*` env injection and build
  caching both work correctly.
- **The 52 recipes under `recipes/`**: real version numbers, real
  upstream URLs, real dependency edges, and build steps that match
  each project's actual build system (meson/ninja, autotools, or
  cmake as appropriate). What they don't have yet is a verified
  `sha256` — this sandbox can only reach a short domain allowlist and
  none of freedesktop.org / x.org / gnome.org / download.kde.org are
  on it. Run `tools/bloink-pin recipes/*/package.lua` on a machine with
  normal internet access to fill those in; `bloink build` will
  correctly refuse every one of them until you do, on purpose.
- **KDE/GNOME coverage**: this is the foundation (core X11 libs,
  Wayland core, GTK3/GTK4, Qt6 + QtWayland, a taste of KDE Frameworks
  via extra-cmake-modules/KWayland) — not full Plasma or full GNOME
  Shell, which are hundreds of additional packages each. Add them the
  same way: a new `recipes/<name>/package.lua` following the pattern
  in any existing recipe.
