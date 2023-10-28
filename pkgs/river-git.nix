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
, wlroots
, xwayland
, zig_0_11
, withManpages ? true
, xwaylandSupport ? true
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "river-git";
  version = "git";
  outputs = [ "out" ] ++ lib.optionals withManpages [ "man" ];

  src = fetchFromGitHub {
    owner = "riverwm";
    repo = "river";
    rev = "5da4769c2357072771e89f00bdd68098b2ef3660";
    fetchSubmodules = true;
    sha256 = "sha256-TLT3tRrPmWGisPMxiL4Sfu5p9QtBLM9MBlX1N/h3cWc=";
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
    wlroots
  ] ++ lib.optional xwaylandSupport libX11;

  zigBuildFlags = lib.optional withManpages "-Dman-pages" ++ lib.optional xwaylandSupport "-Dxwayland";

  postInstall = ''
    install contrib/river.desktop -Dt $out/share/wayland-sessions
  '';

  passthru.providedSessions = [ "river" ];
})
