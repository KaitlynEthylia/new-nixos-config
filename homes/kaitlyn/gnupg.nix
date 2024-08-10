{ config, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    publicKeys = [ { source = ./conf/keyring.pub.gpg; trust = "full"; } ];
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
  };
}
