set shell := ["bash", "-uc"]
set unstable := true

user := env_var('USER')
hostname := shell('hostname')

default:
    @just --list

update:
    nix flake update --commit-lock-file

deploy-nixos HOST:
    HOSTNAME={{ HOST }} nixos-rebuild --flake .?submodules=1#{{ HOST }} --target-host {{ HOST }} --sudo --ask-sudo-password switch

deploy-home HOST:
    HOSTNAME={{ HOST }} nix run 'home-manager#home-manager' -- --flake .?submodules=1#"{{ user }}@{{ HOST }}" build
    nix copy --to ssh://{{ HOST }} ./result
    unlink ./result
    scp -r ./* {{ HOST }}:/tmp/nixos-config
    HOSTNAME={{ HOST }} ssh {{ HOST }} "nix run 'home-manager#home-manager' -- --flake /tmp/nixos-config?submodules=1#{{ user }}@{{ HOST }} switch -b backup"

deploy HOST: (deploy-nixos HOST) (deploy-home HOST)

nixos MODE:
    sudo nixos-rebuild --flake .?submodules=1#{{ hostname }} {{ MODE }}

home MODE:
    home-manager --flake .?submodules=1#"{{ user }}@{{ hostname }}" {{ MODE }}

switch: (nixos "switch") (home "switch")

build HOST:
    HOSTNAME={{ HOST }} nix build --print-out-paths --no-link .?submodules=1#nixosConfigurations.{{ HOST }}.config.system.build.toplevel
    HOSTNAME={{ HOST }} home-manager --flake .?submodules=1#"{{ user }}@{{ HOST }}" --no-out-link --print-build-logs build

clean:
    sudo nix-collect-garbage -d
    nix-collect-garbage -d

sec-renc:
    nix run .?submodules=1#vaultix.app.{{ arch() }}-{{ os() }}.renc
    pushd secrets
    git add secrets
    git commit -m "[🔒] vaultix: renc secrets"
    popd

sec-edit NAME:
    nix run .?submodules=1#vaultix.app.{{ arch() }}-linux.edit -- ./secrets/{{ NAME }}.age
