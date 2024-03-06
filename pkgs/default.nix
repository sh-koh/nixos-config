{ pkgs, ... }: {
  river-bedload = pkgs.callPackage ./river-bedload { };
  river = pkgs.callPackage ./river { };
  pogit = pkgs.callPackage ./pogit { };
}
