{ pkgs, ... }:
{
  boot = {
    kernelModules = [
      "kvm-amd"
      "kvm"
      "vfio"
      "vfio-pci"
      "vfio-iommu-type1"
    ];
    kernelParams = [
      "iommu=pt"
      "amd_iommu=on"
      "vfio_iommu_type1.allow_unsafe_interrupts=1"
      "kvm.ignore_msrs=1"
      "kvm.allow_unsafe_assigned_interrupts=1"
    ];
  };

  programs.virt-manager.enable = true;

  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        package = pkgs.qemu_kvm;
        vhostUserPackages = with pkgs; [ virtiofsd ];
        swtpm = {
          enable = true;
          package = pkgs.swtpm;
        };
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
        runAsRoot = true;
        verbatimConfig = ''
          user = "shakoh"
          group = "users"
          namespaces = []
          mode = "legacy"
        '';
      };
    };
  };
}
