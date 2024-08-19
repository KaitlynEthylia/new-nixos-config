{ lib, pkgs, ... }:

{
  imports = (lib.ethy.allExcept [
    ./lang
  ] ./.) ++ (lib.ethy.allExcept [] ./lang);

  files = [ ./conf/home ];

  home = {
    username = "kaitlyn";
    homeDirectory = "/home/kaitlyn";
  };

  home.packages = with pkgs; [
    jail
    pinta
    blender
    (jail.make vesktop)
    ffmpeg
    yt-dlp
    zenity
    minisign
    flameshot
  ];

  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
    PAGER = "bat";
    MANPAGER = "bat -l man";
    OPENER = "xdg-open";
  };

  programs.home-manager.enable = true;
  programs.nix-index.enable = true;
}
