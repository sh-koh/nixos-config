{ pkgs, ... }: {
  # example = pkgs.callPackage ./example { };
  ristate-git = pkgs.callPackage ./ristate-git.nix { };
}
