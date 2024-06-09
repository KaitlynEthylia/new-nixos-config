{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.loader.grub.device = "/dev/sdc";
  boot.initrd.availableKernelModules = [ "ata_generic" "ehci_pci" "ahci" "xhci_pci" "firewire_ohci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6b6c7918-dc04-48c8-a67e-b992cead28d9";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/45d4aa8d-551d-4f8b-988b-a34eb35cb263";
    fsType = "ext4";
  };

  fileSystems."/nix/store" = {
    device = "/dev/disk/by-uuid/162d801f-c47b-4678-90b9-004be32ca890";
    fsType = "ext4";
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
