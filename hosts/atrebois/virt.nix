{ config
, lib
, pkgs
, inputs
, outputs
, ...
}: {
  boot = {
    kernelModules = [ "kvm-amd" "kvm" "vfio" "vfio_pci" "vfio_iommu_type1" ];
    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
      "kvm.ignore_msrs=1"
      "kvm.allow_unsafe_assigned_interrupts=1"
      "vfio_iommu_type1.allow_unsafe_interrupts=1"
    ];
  };

  environment.systemPackages = with pkgs; [
    win-spice
    win-virtio
    dmidecode
  ];

  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    enableOnBoot = false;
  };

  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = { 
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf.enable = true;
      verbatimConfig = ''
        user = "shakoh"
        group = "users"
        namespaces = []
      '';
    };

    hooks.qemu = {
      "Windows11" = lib.getExe (
        pkgs.writeShellApplication {
          name = "Windows11";
          runtimeInputs = [
            pkgs.libvirt
            pkgs.systemd
            pkgs.kmod
          ];
          text = ''
            GUEST_NAME=$1
            OPERATION=$2
            FOR_HOST="0-3,8-11"
            #FOR_HOST="4-7,12-15"

            if [[ "$GUEST_NAME" != "Windows11" ]]; then
              exit 0
            fi

            case "$OPERATION" in
              "prepare")
                modprobe -i -r nvidia_uvm nvidia_drm nvidia nvidia_modeset
                for i in {0..3}; do
                  echo "vfio-pci" > /sys/bus/pci/devices/0000:26:00."$i"/driver_override
                  virsh nodedev-detach pci_0000_26_00_"$i"
                done
                modprobe -i vfio-pci
                systemctl set-property --runtime -- system.slice AllowedCPUs=$FOR_HOST
                systemctl set-property --runtime -- user.slice AllowedCPUs=$FOR_HOST
                systemctl set-property --runtime -- init.scope AllowedCPUs=$FOR_HOST
              ;;

              "release")
                systemctl set-property --runtime -- system.slice AllowedCPUs=0-15
                systemctl set-property --runtime -- user.slice AllowedCPUs=0-15
                systemctl set-property --runtime -- init.scope AllowedCPUs=0-15
                #modprobe -i -r vfio vfio-pci vfio_iommu_type1
                for i in {0..3}; do
                  virsh nodedev-reattach pci_0000_26_00_"$i"
                  echo "(null)" > /sys/bus/pci/devices/0000:26:00."$i"/driver_override
                done
                modprobe -i nvidia_uvm nvidia_drm nvidia nvidia_modeset
              ;;
            esac
          '';
        }
      );
    };
  };
}
