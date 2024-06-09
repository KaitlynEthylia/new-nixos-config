{ allExcept, config, ... }:

{
  imports = allExcept [] ./.;

  programs.bat = {
    enable = true;
    config = {
      style = [
        "numbers"
        "grid"
      ];
    };
  };
  home.sessionVariables.BAT_CACHE_PATH =
    "${config.xdg.cacheHome}/bat";

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    extraOptions = [
      "--group-directories-first"
    ];
  };
  programs.zsh.shellAliases = {
    ls = "eza -la --group-directories-first";
    lg = "ls --git";
    tree = "ls --tree";
  };
}
