{
  default, pkgs, ...
}:
{
  programs.gh.enable = true;
  programs.git = {
    enable = true;
    userName = "Abdel B.";
    userEmail = "abdel.briand.a@gmail.com";
    delta.enable = true;
    lfs.enable = true;
  };

}
