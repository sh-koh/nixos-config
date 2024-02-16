{ pkgs, ... }: {
  river-bedload = pkgs.callPackage ./river-bedload { };
  river = pkgs.callPackage ./river { };
  rivercarro = pkgs.callPackage ./rivercarro { };
  pogit = pkgs.callPackage ./pogit { };
}
