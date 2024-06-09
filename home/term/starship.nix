{ config, ... }:

{
  programs.starship =
    let
      lang = symbol: {
        symbol = symbol;
        style = "blue";
        format = "[ $symbol ($version) ]($style)";
      };
    in
    {
      enable = true;
      settings = {
        add_newline = false;
        format = "$username[@](bold yellow)$hostname$directory$git_status$git_branch$java$kotlin$rust$haskell$lua$c$character";
        username = {
          show_always = true;
          style_user = "bold bright-purple";
          style_root = "bold red";
          format = "[$user]($style)";
        };
        hostname = {
          style = "bold blue";
          ssh_only = false;
          format = "[$hostname]($style)";
        };
        directory = {
          style = "bold cyan";
          format = "[ $path ]($style)";
          truncation_length = 1;
          truncation_symbol = "…/";
          substitutions = {
            Documents = "󰈙 ";
            Downloads = " ";
            Media = " ";
          };
        };
        git_branch = {
          symbol = "";
          style = "bold yellow";
          format = "[$branch$symbol ]($style)";
        };
        git_status = {
          style = "cyan";
          format = "[(\([$all_status$ahead_behind](bright-red)\))]($style)";
        };
        java = lang " ";
        kotlin = lang " ";
        rust = lang "";
        haskell = lang " ";
        lua = lang "󰢱 ";
        c = lang " ";
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
        };
      };
    };
  home.sessionVariables.STARSHIP_CACHE = config.xdg.cacheHome;
}
