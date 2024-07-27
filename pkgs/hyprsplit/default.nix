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
    rev = "fcf00b770e3b89fd93de2de1bb5e68721090f5fe";
    hash = "sha256-AMK4/87EdBcl8ukTdHMll+zbU76TySqpgwgi6J/jyks=";
    # rev = "3051541ebc7f24dd5325cdfa458f29b4ff9648de";
    # hash = "sha256-PxGDMJaCAm+DzbcAvw9X4RmlVOT1ApmiSc6isqWd6Oo=";
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
