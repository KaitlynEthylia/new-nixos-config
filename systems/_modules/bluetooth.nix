{ pkgs, lib, config, ... }:

{
  options.ethy.bluetooth = lib.mkEnableOption "enable bluetooth";

  config = lib.mkIf config.ethy.bluetooth {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General.ControllerMode = "bredr";
      };
    };

    services.blueman.enable = true;
    systemd.user.services.mpris-proxy = {
      description = "Mpris proxy";
      after = [ "network.target" "sound.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
  };
}
