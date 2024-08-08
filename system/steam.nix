# Install steam system wide so it can enable other necessary settings
{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    package = derivation {
      override = opts: with pkgs; jail (steam.override opts) // {
        run = with pkgs; jail steam.run;
      };
    };
  };
  programs.gamemode.enable = true;
}
