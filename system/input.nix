{ pkgs, ... }:

{
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-mozc
    fcitx5-table-other
  ];

  services.libinput.mouse = {
    middleEmulation = false;
    accelProfile = "flat";
  };
}
