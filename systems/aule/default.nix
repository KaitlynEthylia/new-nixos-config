{ lib, pkgs, ... }:

{
  imports = lib.ethy.allExcept [] ./.;

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

  ethy.doas = true;
  ethy.bluetooth = true;

  environment.systemPackages = with pkgs; [
    git
    psmisc
    pciutils
    usbutils
    zenith
    alsa-utils
  ];

  programs.zsh.enable = true;

  services.udisks2.enable = true;
}
