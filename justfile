set shell := ["bash", "-uc"]
set unstable := true

user := env_var('USER')
hostname := shell('hostname')

default:
  @just --list

deploy-nixos HOST:
  HOSTNAME={{HOST}} nixos-rebuild --flake .#{{HOST}} --target-host {{HOST}} --sudo --ask-sudo-password switch

deploy-home HOST:
  HOSTNAME={{HOST}} nix run 'home-manager#home-manager' -- --flake .#"{{user}}@{{HOST}}" build
  nix copy --to ssh://{{HOST}} ./result
  unlink ./result
  scp -r ./* {{HOST}}:/tmp/nixos-config
  HOSTNAME={{HOST}} ssh {{HOST}} "nix run 'home-manager#home-manager' -- --flake /tmp/nixos-config#{{user}}@{{HOST}} switch -b backup"

deploy HOST: (deploy-nixos HOST) (deploy-home HOST)

nixos MODE:
  sudo nixos-rebuild --flake .#{{hostname}} {{MODE}}

home MODE:
  home-manager --flake .#"{{user}}@{{hostname}}" {{MODE}}

switch: (nixos "switch") (home "switch")

build HOST:
  HOSTNAME={{HOST}} nix build --print-out-paths --no-link .#nixosConfigurations.{{HOST}}.config.system.build.toplevel
  HOSTNAME={{HOST}} home-manager --flake .#"{{user}}@{{HOST}}" --no-out-link --print-build-logs build

clean:
  sudo nix-collect-garbage -d
  nix-collect-garbage -d

renc:
  nix run .#vaultix.app.{{arch()}}-linux.renc

edit NAME:
  nix run .#vaultix.app.{{arch()}}-linux.edit -- ./secrets/{{NAME}}.age
