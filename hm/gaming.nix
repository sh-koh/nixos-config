{ config
, pkgs
, lib
, inputs
, outputs
, ...
}:
{
  
  home.packages = with pkgs; [
    cemu
    citra-canary
    dolphin-emu
    godot_4
    lutris
    prismlauncher
    vkbasalt
    vkbasalt-cli
    steam
    steam-run
    tetrio-desktop
    yuzu-early-access
    osu-lazer-bin
  ];
  
  xdg.dataFile = {
    wine-ge =
      let
        version = "GE-Proton8-17";
        name = "wine-lutris-${version}-x86_64";
      in {
      recursive = false;
      target = "lutris/runners/wine/${name}";
      source = builtins.fetchTarball {
        url = "https://github.com/GloriousEggroll/wine-ge-custom/releases/download/${version}/${name}.tar.xz";
        sha256 = "17hpajnif2kbv359a95zfi2gvn91qmsfs8wc77bdxb9qs0c8x20c";
      };
    };
    proton-ge =
      let
        name = "GE-Proton8-16";
      in {
      recursive = false;
      target = "Steam/compatibilitytools.d/${name}";
      source = builtins.fetchTarball {
        url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${name}/${name}.tar.gz";
        sha256 = "0r11sf7pljw5rqlgbnkl6lkw2cpqyvd16vjp8f64hqjx4ma3947g";
      };
    };
  };
  
}
