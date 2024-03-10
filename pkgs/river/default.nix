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
, withManpages ? true
, xwaylandSupport ? true
}:
stdenv.mkDerivation {
  pname = "river";
  version = "git";

  outputs = [ "out" ] ++ lib.optionals withManpages [ "man" ];

  src = fetchFromGitHub {
    owner = "riverwm";
    repo = "river";
    rev = "ac655593f3113ca1d94d27c5845f0406bf495c9a";
    sha256 = "sha256-hVt7FRJ04Z04406wnsvLhH8fRxzLa2RVFhzOM5pQSQo=";
    #rev = "50ccd4c5b3cd700bed09d26eb75552f08f9af262";
    #sha256 = "sha256-tacwctOL2TFiC8VP6ymoJ5QjQUFrG5H70J3HeOW/7/g=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    pkg-config
    wayland
    xwayland
    zig_0_11.hook
  ] ++ lib.optional withManpages scdoc;

  buildInputs = [
    libGL
    libevdev
    libinput
    libxkbcommon
    pixman
    udev
    wayland-protocols
    wlroots-nvidia
  ] ++ lib.optional xwaylandSupport libX11;

  dontConfigure = true;

  zigBuildFlags = lib.optional withManpages "-Dman-pages" ++ lib.optional xwaylandSupport "-Dxwayland";

  postInstall = ''
    install contrib/river.desktop -Dt $out/share/wayland-sessions
  '';

  passthru.providedSessions = [ "river" ];
}
