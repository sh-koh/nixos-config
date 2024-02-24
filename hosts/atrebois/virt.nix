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
      "vfio_iommu_type1.allow_unsafe_interrupts=1"
      "kvm.ignore_msrs=1"
      "kvm.allow_unsafe_assigned_interrupts=1"
    ];
    kernelModules = [
      "kvm-amd"
      "kvm"
    ];
    extraModprobeConfig = "options vfio-pci ids=10de:1f02,10de:10f9,10de:1ada,10de:1adb";
  };

  environment.systemPackages = with pkgs; [
    win-spice
    win-virtio
  ];

  virtualisation.podman = {
    enable = true;
  };

  virtualisation.containers.cdi.dynamic.nvidia.enable = true;

  programs.virt-manager.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    #package = pkgs.master.libvirt;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = { 
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };

  virtualisation.libvirtd.hooks.qemu.Windows11 = pkgs.writeShellScript "Windows11" ''
    GUEST_NAME="$1"
    OPERATION="$2"
    SUB_OPERATION="$3"
    GPU="26:00"

    if [ "$GUEST_NAME" == "Windows11" ]; then
      if [ "$OPERATION" == "prepare" ]; then
        modprobe -r -a nvidia_uvm nvidia_drm nvidia_modeset nvidia i2c_nvidia_gpu 
        modprobe -a vfio vfio_virqfd vfio_iommu_type1 vfio_pci
        sleep 2
        ${pkgs.libvirt}/bin/virsh nodedev-detach pci_0000_26_00_0
        ${pkgs.libvirt}/bin/virsh nodedev-detach pci_0000_26_00_1
        ${pkgs.libvirt}/bin/virsh nodedev-detach pci_0000_26_00_2
        ${pkgs.libvirt}/bin/virsh nodedev-detach pci_0000_26_00_3
        systemctl set-property --runtime -- system.slice AllowedCPUs=4-7,12-15
        systemctl set-property --runtime -- user.slice AllowedCPUs=4-7,12-15
        systemctl set-property --runtime -- init.scope AllowedCPUs=4-7,12-15

      elif [ "$OPERATION" == "release" ]; then
        systemctl set-property --runtime -- system.slice AllowedCPUs=0-15
        systemctl set-property --runtime -- user.slice AllowedCPUs=0-15
        systemctl set-property --runtime -- init.scope AllowedCPUs=0-15
        ${pkgs.libvirt}/bin/virsh nodedev-reattach pci_0000_26_00_3
        ${pkgs.libvirt}/bin/virsh nodedev-reattach pci_0000_26_00_2
        ${pkgs.libvirt}/bin/virsh nodedev-reattach pci_0000_26_00_1
        ${pkgs.libvirt}/bin/virsh nodedev-reattach pci_0000_26_00_0
        sleep 2
        modprobe -a nvidia_uvm nvidia_drm nvidia_modeset nvidia i2c_nvidia_gpu 
        modprobe -r -a vfio vfio_virqfd vfio_iommu_type1 vfio_pci
      fi
    fi
  '';
}
