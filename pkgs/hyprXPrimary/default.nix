{
  stdenv,
  fetchFromGitHub,
  hyprland,
  pixman,
  libdrm,
  pkg-config,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hyprxprimary";
  version = "git";
  src = fetchFromGitHub {
    owner = "zakk4223";
    repo = "hyprxprimary";
    rev = "7b781613900cac7ebc3058ff5b4b43d6cded07a6";
    hash = "sha256-5im4uZbcxXK62+VswOhtFgHQ+4tZ7yDq7RnuSkV+t64=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    pixman
    libdrm
    hyprland
  ] ++ hyprland.buildInputs;

  installPhase = ''
    mkdir -p $out/lib 
    cp hyprXPrimary.so $out/lib/libhyprxprimary.so
  '';
})
