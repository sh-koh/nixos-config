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
, wlroots
, xwayland
, zig_0_11
}:
stdenv.mkDerivation {
  pname = "river";
  version = "git";

  outputs = [ "out" "man" ];

  src = fetchgit {
    url = "https://codeberg.org/river/river.git";
    rev = "36d8e90a5423c4da037ca6fb2dd02c70cf6a4f3b";
    sha256 = "sha256-JTto0za9zIw8W3KN3eIPGfpsQU3VH+M3i8Gk6KUNHMQ=";
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
    wlroots
    libX11
  ];

  dontConfigure = true;

  zigBuildFlags = "-Dman-pages -Dxwayland";

  postInstall = ''
    install contrib/river.desktop -Dt $out/share/wayland-sessions
  '';

  passthru.providedSessions = [ "river" ];
}
