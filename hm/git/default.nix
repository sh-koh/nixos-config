{
  default, pkgs, ...
}:
{

  programs.gh.enable = true;
  programs.git = {
    enable = true;
    userName = "sh-koh";
    userEmail = "abdel.briand.a@gmail.com";
    package = pkgs.gitFull;
    lfs.enable = true;
  };

}
