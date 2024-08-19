{ lib, pkgs, inputs, ... }:

{
  imports = (lib.ethy.allExcept [] ./.) ++ [
    inputs.hardware.nixosModules.lenovo-legion-15ach6
  ];

  ethy = {
    doas = true;
    bluetooth = true;

    ssh.enable = true;
    fonts.enable = true;

    gaming = {
      steam = true;
      genshin = true;
    };
  };

  networking.networkmanager.enable = true;

  boot.loader.grub = {
    enable = true;
    font = lib.mkForce
      "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/CaskaydiaCoveNerdFontMono-SemiBold.ttf";
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_9;

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
