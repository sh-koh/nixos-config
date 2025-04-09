{ lib, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = lib.strings.concatStrings [
        "$hostname"
        "$directory"

        "$fill"

        "$git_branch"
        "$git_status"

        "$line_break"

        "$direnv"
        "$status"
      ];
      line_break = {
        disabled = false;
      };
      fill = {
        symbol = " ";
      };
      status = {
        disabled = false;
        format = "[$symbol]($style)";
        symbol = "󰅖";
        not_found_symbol = "󰦀";
        not_executable_symbol = "󰂭";
        sigint_symbol = "󱄊";
        signal_symbol = "󰓦";
        success_symbol = ">";
        style = "fg:yellow";
        map_symbol = true;
      };
      hostname = {
        disabled = false;
        format = "[$hostname]($style)> ";
        style = "fg:red";
        ssh_only = true;
      };
      direnv = {
        disabled = false;
        format = "[\\(❄️\\)]($style)";
        style = "fg:cyan";
      };
      directory = {
        disabled = false;
        format = "[$path]($style) [$read_only]($read_only_style)";
        read_only = "";
        style = "fg:blue";
        read_only_style = "fg:red";
        truncation_symbol = "󰇘/";
        truncation_length = 6;
      };
      git_status = {
        disabled = false;
        format = "([\\($all_status$ahead_behind\\)]($style))";
        style = "fg:yellow";
      };
      git_branch = {
        disabled = false;
        format = "[$branch]($style)(:$remote_branch)";
        style = "fg:green";
      };
    };
  };
}
