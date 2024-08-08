{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      nerdfonts = prev.nerdfonts.override {
        fonts = [ "CascadiaCode" ];
      };
      palatino = final.callPackage ./palatino.nix {};
    })
  ];

  fonts = {
    packages = with pkgs; [
      nerdfonts
      roboto
      roboto-mono
      open-sans
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      twitter-color-emoji
      palatino
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "PalatinoLTStd-Roman" ];
        sansSerif = [ "Roboto" "Open Sans" ];
        monospace = [ "CaskaydiaCove Nerd Font Mono" "Roboto Mono" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };

  environment.sessionVariables = {
    FONTCONFIG_FILE = "/etc/fonts/fonts.conf";
    FONTCONFIG_PATH = "/etc/fonts";
  };
}
