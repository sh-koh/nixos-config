{ pkgs, ... }: {
  river-bedload = pkgs.callPackage ./river-bedload { };
  river = pkgs.callPackage ./river { };
}
