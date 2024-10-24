{
  stdenv,
  fetchFromGitHub,
  pkg-config,
  meson,
  ninja,
  hyprland,
  pixman,
  libdrm,
}:
let
  version = "v0.44.1";
in
stdenv.mkDerivation (finalAttrs: {
  inherit version;
  pname = "hyprsplit";
  src = fetchFromGitHub {
    owner = "shezdy";
    repo = "hyprsplit";
    rev = version;
    hash = "sha256-l+DQHWPMyUCXbKhbIFVooTKKnCRQ97Ic5smw4VzUcTc=";
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
