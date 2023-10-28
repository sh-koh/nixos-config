{ pkgs, ... }: {
  river-git = pkgs.callPackage ./river-git.nix { };
  ristate-git = pkgs.callPackage ./ristate-git.nix { };
  rivercarro-git = pkgs.callPackage ./rivercarro-git.nix { };
}
