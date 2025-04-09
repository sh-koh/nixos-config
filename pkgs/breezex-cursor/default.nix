{
  stdenvNoCC,
  fetchzip,
  ...
}:
let
  version = "2.0.1";
in
stdenvNoCC.mkDerivation {
  pname = "breezex-cursor";
  inherit version;

  src = fetchzip {
    url = "https://github.com/ful1e5/BreezeX_Cursor/releases/download/v${version}/BreezeX.tar.xz";
    hash = "sha256-kq3Amh40QzLnLBzIC3kVMCtsB1ydUahnuY+Jounay4E=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -rf BreezeX-* $out/share/icons
  '';
}
