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
stdenv.mkDerivation (finalAttrs: {
  pname = "river";
  version = "git";

  outputs = [ "out" ] ++ lib.optionals withManpages [ "man" ];

  src = fetchFromGitHub {
    owner = "riverwm";
    repo = "river";
    rev = "50ccd4c5b3cd700bed09d26eb75552f08f9af262";
    fetchSubmodules = true;
    sha256 = "sha256-tacwctOL2TFiC8VP6ymoJ5QjQUFrG5H70J3HeOW/7/g=";
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
})
