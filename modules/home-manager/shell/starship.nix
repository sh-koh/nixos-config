{ lib, ... }:
let
  lang = icon: color: {
    symbol = icon;
    format = "[${pad.left}$symbol${pad.right}](${color})";
  };
  pad = {
    left = "\\[";
    right = "\\]";
  };
in
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = lib.strings.concatStrings [
        "$direnv"
        "$directory"
        "$hostname"
        "$localip"

        "$python"
        "$nodejs"
        "$zig"
        "$golang"
        "$terraform"
        "$container"

        "$fill"

        "$git_status"
        "$git_branch"

        "$line_break"

        "$username"
        "$status"
      ];
      custom.space = {
        when = ''! test $env'';
        format = " ";
      };
      line_break.disabled = false;
      fill = {
        symbol = " ";
      };
      status = {
        symbol = "✗";
        not_found_symbol = "󰍉";
        not_executable_symbol = "";
        sigint_symbol = "󰂭";
        signal_symbol = "󱑽";
        success_symbol = ">";
        format = "[$symbol](fg:yellow) ";
        map_symbol = true;
        disabled = false;
      };
      cmd_duration = {
        min_time = 1000;
        format = "[${pad.left}$duration${pad.right}](fg:green)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        format = "[${pad.left}$time${pad.right}](fg:purple)";
      };
      hostname = {
        ssh_only = true;
        format = "[${pad.left}$hostname${pad.right}](fg:blue)";
      };
      localip = {
        disabled = false;
        format = "[${pad.left}$localipv4${pad.right}](fg:yellow)";
      };
      username = {
        show_always = true;
        format = "[${pad.left}$user${pad.right}](fg:red)";
      };
      direnv = {
        disabled = false;
        format = "[${pad.left}direnv${pad.right}](fg:cyan)";
      };
      container = {
        symbol = "box";
        format = "[${pad.left}$symbol${pad.right}](blue)";
      };
      directory = {
        format = "[${pad.left}$path${pad.right}](fg:blue)";
        truncation_length = 6;
        truncation_symbol = "~/󰇘/";
      };
      git_status = {
        format = "([${pad.left}$all_status$ahead_behind${pad.right}](fg:yellow))";
      };
      git_branch = {
        style = "";
        format = "[${pad.left}$branch${pad.right}](fg:green)(:$remote_branch)";
      };
      python = lang "py" "green";
      nodejs = lang "js" "yellow";
      golang = lang "go" "cyan";
      zig = lang "zig" "yellow";
      terraform = lang "tf" "purple";
      rust = lang "rust" "red";
      kubernetes = lang "k8s" "blue";
      c = lang "c" "blue";
    };
  };
}
