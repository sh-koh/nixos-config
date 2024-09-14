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

stdenv.mkDerivation (finalAttrs: {
  pname = "hyprsplit";
  version = "v${hyprland.version}";
  src = fetchFromGitHub {
    owner = "shezdy";
    repo = "hyprsplit";
    rev = "v${hyprland.version}";
    hash = "sha256-r533kNIyfgPi/q8ddIYyDK1Pmupt/F3ncHuFo3zjDkU=";
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
