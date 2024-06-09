{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      nerdfonts = prev.nerdfonts.override {
        fonts = [ "CascadiaCode" ];
      };
    })
  ];

  fonts = {
    packages = with pkgs; [
      nerdfonts
      roboto
      roboto-mono
      open-sans
      noto-fonts
      twitter-color-emoji
      (callPackage ./palatino.nix {})
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Palatino" ];
        sansSerif = [ "Roboto" "Noto Sans" "Open Sans" ];
        monospace = [ "CascadiaCode" "Roboto Mono" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
