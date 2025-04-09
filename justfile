set shell := ["nu", "-c"]
set unstable := true

user := env_var('USER')
hostname := shell('hostname')

default:
  @just --list

switch:
  sudo nixos-rebuild --flake .#{{hostname}} switch
  home-manager --flake .#"{{user}}@{{hostname}}" switch

build HOST:
  HOSTNAME={{HOST}} nix build --print-out-paths --no-link .#nixosConfigurations.{{HOST}}.config.system.build.toplevel
  HOSTNAME={{HOST}} home-manager --flake .#"{{user}}@{{HOST}}" --no-out-link --print-build-logs build

deploy HOST:
  HOSTNAME={{HOST}} nixos-rebuild --flake .#{{HOST}} --target-host {{HOST}} --use-remote-sudo switch
  HOSTNAME={{HOST}} home-manager --flake .#"{{user}}@{{HOST}}" build
  nix copy --to ssh://{{HOST}} ./result
  unlink ./result
  (ls).name | par-each {|x| (pwd) + / + $x } | scp -r ...$in {{HOST}}:/tmp/nixos-config
  HOSTNAME={{HOST}} ssh {{HOST}} "home-manager --flake /tmp/nixos-config#{{user}}@{{HOST}} switch -b backup"

nixos MODE:
  sudo nixos-rebuild --flake .#{{hostname}} {{MODE}}

home MODE:
  home-manager --flake .#"{{user}}@{{hostname}}" {{MODE}}

clean:
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
