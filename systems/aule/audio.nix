{ ... }:

{
  musnix = {
    enable = true;
    soundcardPciId = "00:1b.0";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;

    extraConfig.pipewire."100-low-latency".context.properties.default.clock = {
      quantum = 8;
      min-quantum = 8;
    };
  };
}
