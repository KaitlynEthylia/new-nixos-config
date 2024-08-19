{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.loader.grub = {
    efiSupport = true;
    devices = [ "nodev" ];
  };
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9f234cd0-041c-41a5-abad-bdc94c60f7d5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/A971-1AE3";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/27515899-6a87-4c21-ac4d-a16ffa9e32eb";
      fsType = "ext4";
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/38e8003c-b5e7-426e-aa31-90fa7c888b9f";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/6bd71cbd-f73f-4aec-91b3-8fb914598c24"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
