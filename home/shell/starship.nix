{ pkgs, config, lib, ... }:
let
  lang = icon: color: {
    symbol = icon;
    format = "[$symbol ](${color})";
  };
  pad = {
    left = " ";
    right = " ";
  };
in
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = lib.strings.concatStrings [
	      "$hostname"
        "$nix_shell"
        "$directory"
        "$cmd_duration"
        "$status"
        "$line_break"
        "$time"
        "[󰥭](bold yellow)"
        ''''${custom.space}''
      ];
      right_format = lib.strings.concatStrings [
        "$python"
        "$nodejs"
        "$lua"
        "$golang"
        "$git_branch $git_status"
        "$container"
	      "$localip"
      ];
      custom.space = {
        when = ''! test $env'';
        format = " ";
      };
      line_break = { disabled = false; };
      status = {
        symbol = "✗";
        not_found_symbol = "󰍉 Not Found";
        not_executable_symbol = " Can't Execute E";
        sigint_symbol = "󰂭 ";
        signal_symbol = "󱑽 ";
        success_symbol = "";
        format = "[$symbol](fg:red) ";
        map_symbol = true;
        disabled = false;
      };
      cmd_duration = {
        min_time = 1000;
        format = "[$duration](fg:yellow)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        format = "[${pad.left}](fg:purple)[$time](fg:purple bg:black)[${pad.right}](fg:purple)";
      };
      hostname = {
        ssh_only = true;
        format = "[${pad.left}](fg:blue)[$hostname](fg:blue bg:black)[${pad.right}](fg:blue)";
      };
      localip = {
        disabled = false;
        format = "[${pad.left}](fg:yellow)[$localipv4](fg:yellow bg:black)[${pad.right}](fg:bright-black)";
      };
      nix_shell = {
        disabled = false; 
        format = "[${pad.left}](fg:cyan)[ ](fg:cyan bg:black)[${pad.right}](fg:cyan)";
      };
      container = {
        symbol = " 󰏖";
        format = "[$symbol ](bright-blue dimmed)";
      };
      directory = {
        format = "[${pad.left}](fg:blue)[$path](fg:blue bg:black)[${pad.right}](fg:blue)";
        truncation_length = 6;
        truncation_symbol = "~/󰇘/";
      };
      git_branch = {
        symbol = "";
        style = "";
        format = "[$symbol $branch](fg:purple)(:$remote_branch)";
      };
      git_status = {
        
      };
      python = lang "" "yellow";
      nodejs = lang " " "yellow";
      golang = lang "" "blue";
    };
  };
}
