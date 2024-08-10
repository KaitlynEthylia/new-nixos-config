{ lib, pkgs, ... }:

{
  imports = lib.ethy.allExcept [] ./.;

  networking.hostName = "nix";
  networking.networkmanager.enable = true;

  boot.loader.grub = {
    enable = true;
    gfxmodeEfi = "1920x1080";
    gfxmodeBios = "1920x1080";
    font = lib.mkForce
      "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/CaskaydiaCoveNerdFontMono-SemiBold.ttf";
    fontSize = 36;
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_9;

  security.doas.enable = true;
  security.doas.extraRules = [ {
    groups = [ "wheel" ];
    persist = true;
    keepEnv = true;
  } ];
  security.sudo.enable = false;
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "sudo" ''exec doas $@'')
    git
    psmisc
    pciutils
    usbutils
    zenith
    alsa-utils
  ];

  programs.zsh.enable = true;

  services.udisks2.enable = true;

  system.stateVersion = "23.05";
}
