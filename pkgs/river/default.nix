{ lib
, stdenv
, fetchFromGitHub
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

  src = fetchFromGitHub {
    owner = "riverwm";
    repo = "river";
    rev = "ff8365d35002761adae58fb3fb8e430a5e72b1e3";
    sha256 = "sha256-Ux3dhMuQrICUAsyJeHXcS7yamOJIhXEV8+JaOj8k3mQ=";
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
