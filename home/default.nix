{ allExcept, pkgs, ... }:

{
  imports = (allExcept [
    ./lang
    ./wine
  ] ./.) ++ (allExcept [] ./lang);

  files = [ ./conf/home ];

  home = {
    username = "kaitlyn";
    homeDirectory = "/home/kaitlyn";
  };

  home.packages = with pkgs; [
    pinta
    blender
    (jail vesktop)
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

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
  programs.nix-index.enable = true;
}
