# Install steam system wide so it can enable other necessary settings
{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    package = derivation {
      override = opts: with pkgs; jail.make (steam.override opts) // {
        run = with pkgs; jail.make steam.run;
      };
    };
  };
  programs.gamemode.enable = true;
}
