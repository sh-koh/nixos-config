{ config
, lib
, pkgs
, inputs
, outputs
, ...
}: {
  boot = {
    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
    ];
    kernelModules = [
      "kvm-amd"
      "kvm"
      "vfio_pci"
      "vfio"
      "vfio_virqfd"
      "vfio_iommu_type1"
    ];
  };

  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    extraOptions = "--default-runtime=nvidia";
    enableOnBoot = false;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    virt-manager
    win-spice
    win-virtio
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = { 
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  environment.etc = {
    "ovmf/edk2-x86_64-secure-code.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
    };
  };

  # Isolation CPU pour la machine virtuelle 'Windows11' via QEMU et libvirt.
  systemd.services.libvirtd.preStart = let
    qemuHook = pkgs.writeScript "qemu-hook" ''
      #!${pkgs.stdenv.shell}

      GUEST_NAME="$1"
      OPERATION="$2"
      SUB_OPERATION="$3"

      if [ "$GUEST_NAME" == "Windows11" ]; then
        if [ "$OPERATION" == "start" ]; then
          systemctl set-property --runtime -- system.slice AllowedCPUs=0-3,8-11
          systemctl set-property --runtime -- user.slice AllowedCPUs=0-3,8-11
          systemctl set-property --runtime -- init.scope AllowedCPUs=0-3,8-11
        fi

        if [ "$OPERATION" == "stopped" ]; then
          systemctl set-property --runtime -- system.slice AllowedCPUs=0-15
          systemctl set-property --runtime -- user.slice AllowedCPUs=0-15
          systemctl set-property --runtime -- init.scope AllowedCPUs=0-15
        fi
      fi
    '';
  in ''
    mkdir -p /var/lib/libvirt/hooks
    chmod 755 /var/lib/libvirt/hooks

    # Copy hook files
    ln -sf ${qemuHook} /var/lib/libvirt/hooks/qemu
  '';
}
