{ ... }:

{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
  home.sessionVariables.NIXOS_OXONE_WL = "1";
}
