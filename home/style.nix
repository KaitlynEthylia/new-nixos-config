{ pkgs, config, ... }:

{
  home.pointerCursor = {
    name = "catppuccin-mocha-pink-cursors";
    package = pkgs.catppuccin-cursors.mochaPink;
    gtk.enable = true;
  };

  home.file.".icons/default/index.theme".enable = false;
  home.file.".icons/${config.home.pointerCursor.name}".enable = false;

  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };
}
