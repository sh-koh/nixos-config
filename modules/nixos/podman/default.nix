{
  virtualisation = {
    podman = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [
          "--all"
          "--force"
        ];
      };
    };
    oci-containers = {
      backend = "podman";
    };
  };
}
