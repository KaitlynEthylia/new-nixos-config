{ allExcept, pkgs, ... }:

{
  imports = allExcept [] ./.;

  home.packages = with pkgs; [
    bemenu
    wl-clipboard
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        seperator_colour = "frame";
      };
    };
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
