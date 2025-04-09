{ pkgs, ... }:
{
  virtualisation.oci-containers.containers = {
    notre-minecraft = {
      autoStart = true;
      extraOptions = [ "--network=host" ];
      environment = {
        MEMORYSIZE = "12G";
        #JAVAFLAGS = "";
        #PAPERMC_FLAGS = "";
      };
      image = "ghcr.io/mtoensing/docker-minecraft-papermc-server";
      imageFile = pkgs.dockerTools.pullImage {
        imageName = "ghcr.io/mtoensing/docker-minecraft-papermc-server";
        imageDigest = "sha256:6b4c8c6a29f92fdbb66499bc52f40f77118a4c6651d16c0adcbdcfa595c07129";
        sha256 = "1wn9aa5hxqclzxa2bvxq5afc16jdxladnlff6l0p0ssd1n53jshp";
        finalImageName = "ghcr.io/mtoensing/docker-minecraft-papermc-server";
        finalImageTag = "latest";
        os = "linux";
        arch = "arm64";
      };
      volumes = [ "/var/notre-minecraft:/data:rw" ];
      ports = [
        "25565:25565/tcp"
        "25565:25565/udp"
      ];
    };
  };
}
