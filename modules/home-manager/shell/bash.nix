{
  config,
  ...
}:
{
  programs.bash = {
    enable = true;
    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      GOPATH = "${config.home.homeDirectory}/.local/share/go";
      NIXPKGS_ALLOW_UNFREE = if config.nixpkgs.config.allowUnfree then 1 else 0;
      PAGER = "less -FiRSwX";
      MANPAGER = "nvim -n +Man!";
      EDITOR = "nvim";
      DIFFPROG = "nvim -d";
      BROWSER = "xdg-open";
      GNOME_KEYRING_CONTROL = "/run/user/$UID/keyring";
    };
    initExtra = ''
      shopt -s autocd cdspell extglob extquote globstar
    '';
  };
}
