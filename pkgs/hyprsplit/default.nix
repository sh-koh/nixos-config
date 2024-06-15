{ stdenv
, fetchFromGitHub
, pkg-config
, meson
, ninja
, hyprland ? hyprland
, pixman
, libdrm
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hyprsplit";
  version = "0.1";
  src = fetchFromGitHub {
    owner = "shezdy";
    repo = "hyprsplit";
    rev = "v0.40.0";
    hash = "sha256-sDzwTFLBPoopt7PvCZm0zUnst7oxJ5BgGaajdJnGHEs=";
  };

  nativeBuildInputs = [
    pkg-config
    meson
    ninja
  ];
  buildInputs = [
    hyprland
    pixman
    libdrm
  ] ++ hyprland.buildInputs;
})
