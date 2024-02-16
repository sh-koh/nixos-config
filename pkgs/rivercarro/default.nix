{ lib
, stdenv
, fetchFromSourcehut
, pkg-config
, river
, wayland
, wayland-protocols
, zig_0_11
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "rivercarro";
  version = "git";

  src = fetchFromSourcehut {
    owner = "~novakane";
    repo = "rivercarro";
    rev = "9f6df9fe697632dff78a87c7be4e21504c712bb5";
    fetchSubmodules = true;
    sha256 = "sha256-lucwn9MmyVd4pynuG/ZAXnZ384wdS0gi7JN44vNQA1I=";
  };

  nativeBuildInputs = [
    pkg-config
    river
    wayland
    wayland-protocols
    zig_0_11.hook
  ];
})
