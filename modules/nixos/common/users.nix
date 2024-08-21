{ pkgs, config, inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.secrets
  ];

  security.sudo.execWheelOnly = true;
  programs = {
    command-not-found.enable = false;
    zsh.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
  };

  environment.systemPackages = with pkgs; [
    coreutils
    curl
    jq
    grex
    lm_sensors
    lshw
    pciutils
    psmisc
    usbutils
    wget
  ];

  users.users.root = {
    uid = 0;
    home = "/root";
    hashedPassword = "!"; # Disable root password authentication
  };

  users.users.shakoh = {
    uid = 1000;
    isNormalUser = true;
    useDefaultShell = true;
    hashedPasswordFile = config.age.secrets.shakoh-pwd.path;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "input"
      "kvm"
      "libvirtd"
      "qemu-libvirtd"
      "docker"
      "adbusers"
      "networkmanager"
      "wireshark"
    ];
  };


  time.timeZone = "Europe/Paris";
  console.keyMap = "us-acentos";
}
