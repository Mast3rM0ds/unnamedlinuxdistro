-- This one has a real, independently-verified sha256 (fetched and
-- hashed directly, matches json-c's own published wiki checksum too).
-- Use it alongside recipes/zlib/package.lua as a template.
return {
  name = "json-c",
  version = "0.19",
  description = "JSON parsing/generation library in C (sway config and IPC)",
  license = "MIT",
  homepage = "https://github.com/json-c/json-c",

  sources = {
    {
      url = "https://github.com/json-c/json-c/releases/download/json-c-0.19-20260627/json-c-0.19.tar.gz",
      sha256 = "37ad0249902e301bd9052bf712e511fcc6acff4ecaad4b5900aad9ce564e26de",
    },
  },

  deps = {},

  build = {
    "cmake -B build -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON",
    "cmake --build build -j$(nproc)",
    "cmake --install build",
  },
}
