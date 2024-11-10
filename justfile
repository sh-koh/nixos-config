set shell := ["nu", "-c"]
set unstable := true

user := env_var('USER')
hostname := shell('hostname')

default:
  @just --list

re MODE:
  sudo nixos-rebuild --flake .#{{hostname}} {{MODE}}
  home-manager --flake .#"{{user}}@{{hostname}}" {{MODE}}

os:
  sudo nixos-rebuild --fast --flake .#{{hostname}} switch

home:
  home-manager --flake .#"{{user}}@{{hostname}}" switch

clean:
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
