{ lib
, stdenv
, fetchgit
, libGL
, libX11
, libevdev
, libinput
, libxkbcommon
, pixman
, pkg-config
, scdoc
, udev
, wayland
, wayland-protocols
, wlroots-nvidia
, xwayland
, zig_0_11
}:
stdenv.mkDerivation {
  pname = "river";
  version = "git";

  outputs = [ "out" "man" ];

  src = fetchgit {
    url = "https://codeberg.org/river/river.git";
    rev = "ed99d7bc14d1f77e3e49bb84ddbc7459c5b4182e";
    sha256 = "sha256-ItGssc7roTFBuVj1dpNtwkmy0KSMoPdD6iuDaexlpRc=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    pkg-config
    wayland
    xwayland
    zig_0_11.hook
    scdoc
  ];

  buildInputs = [
    libGL
    libevdev
    libinput
    libxkbcommon
    pixman
    udev
    wayland-protocols
    wlroots-nvidia
    libX11
  ];

  dontConfigure = true;

  zigBuildFlags = "-Dman-pages -Dxwayland";

  postInstall = ''
    install contrib/river.desktop -Dt $out/share/wayland-sessions
  '';

  passthru.providedSessions = [ "river" ];
}
