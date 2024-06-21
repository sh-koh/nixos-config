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
    rev = "v0.41.1";
    hash = "sha256-7R/Q4QRJa2mm+gAU+rJ0XGKMwXPxDq7J/iAq0fjKhKY=";
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
