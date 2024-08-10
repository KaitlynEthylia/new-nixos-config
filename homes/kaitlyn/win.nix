{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wineWowPackages.waylandFull
    protontricks
    winetricks
  ];

  home.sessionVariables = {
    WINEPREFIX = "${config.xdg.dataHome}/wine";
    STEAM_LIBRARY = "${config.xdg.dataHome}/Steam";
  };
}
