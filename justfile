set shell := ["bash", "-c"]
set unstable := true

user := env_var('USER')
hostname := shell('hostname')

default:
  @just --list

rebuild MODE:
  sudo nixos-rebuild --flake .#{{hostname}} {{MODE}}
  home-manager --flake .#"{{user}}@{{hostname}}" {{MODE}}

clean:
  sudo nix store gc -v
  nix store gc -v

hard-clean:
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
