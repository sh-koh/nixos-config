{ pkgs
, lib
, config
, ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = {
      "window.menuBarVisibility" = "compact";
      "window.titleBarStyle" = "custom";
      "redhat.telemetry.enabled" = false;
    };
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      ms-vscode.cpptools
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-azuretools.vscode-docker
      vscodevim.vim
    ];
  };
}
