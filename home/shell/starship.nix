{ pkgs, config, lib, ... }:
let
  lang = icon: color: {
    symbol = icon;
    format = "[$symbol ](${color})";
  };
  pad = {
    left = "";
    right = "";
  };
in
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = lib.strings.concatStrings [
	"[┌─](bold blue)"
	"$hostname"
	"$localip"
        "$nix_shell"
        "$directory"
        "$container"
        "$git_branch $git_status"
        "$python"
        "$nodejs"
        "$lua"
        "$golang"
        "$cmd_duration"
        "$status"
        "$line_break"
	"[└─](bold blue)"
	"[ ](bold blue)"
        ''''${custom.space}''
      ];
      custom.space = {
        when = ''! test $env'';
        format = "";
      };
      line_break = { disabled = false; };
      status = {
        symbol = "✗";
        not_found_symbol = "󰍉 Not Found";
        not_executable_symbol = " Can't Execute E";
        sigint_symbol = "󰂭 ";
        signal_symbol = "󱑽 ";
        success_symbol = "";
        format = "[$symbol](fg:red)";
        map_symbol = true;
        disabled = false;
      };
      cmd_duration = {
        min_time = 1000;
        format = "[$duration ](fg:yellow)";
      };
      hostname = {
        ssh_only = false;
        format = "[${pad.left}](fg:blue)[$hostname](bg:blue fg:black)[${pad.right}](fg:blue) ";
      };
      localip = {
        disabled = false;
        format = "[${pad.left}](fg:bright-black)[$localipv4](bg:bright-black fg:black)[${pad.right}](fg:bright-black) ";
      };
      nix_shell = {
        disabled = false;
        format = "[${pad.left}](fg:cyan)[ 󱄅 ](bg:cyan fg:black)[${pad.right}](fg:cyan) ";
      };
      container = {
        symbol = " 󰏖";
        format = "[$symbol ](bright-blue dimmed) ";
      };
      directory = {
        format = "[${pad.left}](fg:green)[$path](bg:green fg:black)[${pad.right}](fg:green) ";
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
      lua = lang "󰢱 " "blue";
      golang = lang "" "blue";
    };
  };
}
