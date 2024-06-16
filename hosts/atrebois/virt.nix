{ lib, pkgs, ... }:
{
  boot = {
    kernelParams = [
      "iommu=pt"
      "amd_iommu=on"
      "vfio_iommu_type1.allow_unsafe_interrupts=1"
      "kvm.ignore_msrs=1"
      "kvm.allow_unsafe_assigned_interrupts=1"
    ];
    kernelModules = [
      "kvm-amd"
      "kvm"
      "vfio"
      "vfio-pci"
      "vfio-iommu-type1"
    ];
  };

  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.podman = {
    enable = true;
  };
  virtualisation.docker = {
    enable = true;
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
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
      runAsRoot = true;
      verbatimConfig = ''
        user = "shakoh"
        group = "users"
        namespaces = []
      '';
    };
  };

  virtualisation.libvirtd = {
    hooks.qemu = {
      Windows11 = lib.getExe (pkgs.writeShellApplication {
        name = "Windows11";
        runtimeInputs = with pkgs; [
          libvirt
          systemd
          kmod
        ];
        text = ''
          GUEST_NAME="$1"
          OPERATION="$2"

          if [[ "$GUEST_NAME" != "Windows11" ]]; then
            exit 0;
          fi

          case "$OPERATION" in
            "prepare")
              modprobe -r -a nvidia_uvm nvidia_drm nvidia_modeset nvidia i2c_nvidia_gpu 
              modprobe -a vfio vfio_iommu_type1 vfio_pci
              virsh nodedev-detach pci_0000_26_00_0
              virsh nodedev-detach pci_0000_26_00_1
              virsh nodedev-detach pci_0000_26_00_2
              virsh nodedev-detach pci_0000_26_00_3
              systemctl set-property --runtime -- system.slice AllowedCPUs=0-3,8-11
              systemctl set-property --runtime -- user.slice AllowedCPUs=0-3,8-11
              systemctl set-property --runtime -- init.scope AllowedCPUs=0-3,8-11
            ;;
            "release")
              systemctl set-property --runtime -- system.slice AllowedCPUs=0-15
              systemctl set-property --runtime -- user.slice AllowedCPUs=0-15
              systemctl set-property --runtime -- init.scope AllowedCPUs=0-15
              virsh nodedev-reattach pci_0000_26_00_3
              virsh nodedev-reattach pci_0000_26_00_2
              virsh nodedev-reattach pci_0000_26_00_1
              virsh nodedev-reattach pci_0000_26_00_0
              modprobe -a nvidia_uvm nvidia_drm nvidia_modeset nvidia i2c_nvidia_gpu 
              modprobe -r -a vfio vfio_iommu_type1 vfio_pci
            ;;
          esac
        '';
      });
    };
  };
}
