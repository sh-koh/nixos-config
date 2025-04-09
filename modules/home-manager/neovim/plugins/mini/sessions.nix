{
  # Whether to read default session if Neovim opened without file arguments
  autoread = true;

  # Whether to write currently read session before quitting Neovim
  autowrite = true;

  # Directory where global sessions are stored (use `""` to disable)
  #directory = #<"session" subdir of user data directory from |stdpath()|>;

  # File for local session (use `""` to disable)
  file = "Session.vim";

  # Whether to force possibly harmful actions (meaning depends on function)
  force = {
    read = false;
    write = true;
    delete = false;
  };

  # Hook functions for actions. Default `null` means "do nothing".
  hooks = {
    # Before successful action
    pre = {
      read = null;
      write = null;
      delete = null;
    };
    # After successful action
    post = {
      read = null;
      write = null;
      delete = null;
    };
  };

  # Whether to print session path after action
  verbose = {
    read = false;
    write = true;
    delete = true;
  };
}
