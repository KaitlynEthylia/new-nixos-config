{ lib, pkgs, ... }:

{
  services.displayManager = {
    defaultSession = "xsession";
    sddm = {
      enable = true;
      theme = lib.mkForce "${ pkgs.callPackage ./sddm-theme.nix {} }";
      extraPackages = with pkgs; [
        catppuccin-cursors.mochaPink
      ];
      package = pkgs.kdePackages.sddm;
    };
  };

  services.xserver = {
    enable = true;
    desktopManager.session = [ {
      name = "xsession";
      start = ''
        ${pkgs.stdenv.shell} $HOME/.config/x/session &
        waitPID=$!
      '';
    } ];
  };

  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
  };
}
