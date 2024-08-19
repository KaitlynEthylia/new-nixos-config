{ pkgs, config, lib, inputs, ... }:

{
  options.ethy.gaming = {
    steam = lib.mkEnableOption "enables Steam";
    genshin = lib.mkEnableOption "enables Genshin";
  };

  config = {
    programs.steam = lib.mkIf config.ethy.gaming.steam {
      enable = true;
      package = derivation {
        override = opts: with pkgs; jail.make (steam.override opts) // {
          run = with pkgs; jail.make steam.run;
        };
      };
    };

    programs.gamemode.enable = lib.mkIf config.ethy.gaming.steam true;

    networking.mihoyo-telemetry.block = config.ethy.gaming.genshin;
    programs.anime-game-launcher.enable = config.ethy.gaming.genshin;
    nix.settings = lib.mkIf config.ethy.gaming.genshin inputs.aagl.nixConfig;
  };
}
