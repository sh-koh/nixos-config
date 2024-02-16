{ lib
, stdenv
, fetchFromSourcehut
, pkg-config
, wayland
, wayland-protocols
, zig_0_11
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "river-bedload";
  version = "git";

  src = fetchFromSourcehut {
    owner = "~novakane";
    repo = "river-bedload";
    rev = "9cdc0e0f7a2b39dd10675fb7cdaed6dac401ba39";
    fetchSubmodules = true;
    sha256 = "sha256-K3CXJjOW/oXKlVFBahTNtCTYMps0TnygRkp60lnDPlo=";
  };

  nativeBuildInputs = [
    pkg-config
    wayland
    wayland-protocols
    zig_0_11.hook
  ];
})
