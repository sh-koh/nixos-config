{ pkgs, config, lib, ... }: {

  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./ripgrep.nix
    ./starship.nix
    ./tmux.nix
    ./zellij.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
