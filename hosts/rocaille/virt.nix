{ pkgs, ... }:
{
  boot = {
    kernelParams = [
      "intel_iommu=on"
      "vfio_iommu_type1.allow_unsafe_interrupts=1"
      "kvm.ignore_msrs=1"
    ];
    kernelModules = [
      "kvm-intel"
      "kvm"
    ];
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    virt-manager
    win-spice
    win-virtio
  ];

  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    enableOnBoot = false;
  };

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      swtpm.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };
}
