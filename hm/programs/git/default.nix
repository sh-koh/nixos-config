{
  default, pkgs, ...
}:
{

  programs.gh.enable = true;
  programs.git = {
    enable = true;
    userName = "Shakoh";
    userEmail = "70974710+Shakohh@users.noreply.github.com";
    package = pkgs.gitFull;
    delta.enable = true;
    lfs.enable = true;
  };

}