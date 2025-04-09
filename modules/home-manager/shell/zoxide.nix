{
  programs.zoxide = {
    enable = true;
    options = [ "--no-cmd" ]; # this disable preconfigured aliases (z = __zoxide_z, zi = __zoxide_zi)
  };
}
