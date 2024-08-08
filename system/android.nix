{ pkgs, ... }:

{
  users.users.kaitlyn.extraGroups = [
    "plugdev"
    "adbusers"
  ];
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    android-tools
    android-udev-rules
  ];
}
