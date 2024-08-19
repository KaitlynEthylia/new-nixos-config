{ config, pkgs, ... }:

{
  ethy.games.genshin = true;

  home.packages = with pkgs; [
    protontricks
    winetricks
  ];

  home.sessionVariables = {
    WINEPREFIX = "${config.xdg.dataHome}/wine";
    STEAM_LIBRARY = "${config.xdg.dataHome}/Steam";
  };
}
