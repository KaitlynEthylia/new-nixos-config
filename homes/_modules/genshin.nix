{ pkgs, lib, config, ... }:

{
  options.ethy.games.genshin = lib.mkEnableOption "enables Genshin Impact.";

  config.home.packages = lib.mkIf config.ethy.games.genshin [
    pkgs.anime-game-launcher
  ];
}
