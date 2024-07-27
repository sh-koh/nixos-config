{ stdenv
, fetchFromGitHub
, hyprland ? hyprland
, pixman
, libdrm
, pkg-config
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hyprxprimary";
  version = "git";
  src = fetchFromGitHub {
    owner = "zakk4223";
    repo = "hyprxprimary";
    rev = "69388ceb830ba6c68496f928dec173e578d6fd14";
    hash = "sha256-ltRLHOpgYxtm7EfvikDgLPiG0AiJaAFIHwGdLe9aoNE=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

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
