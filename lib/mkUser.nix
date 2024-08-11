{ lib, ... }:

pkgs:
  { name
  , shell ? null
  , admin ? false
  , system ? false
  , groups ? []
  , description ? name
  }:
  let
    inherit (lib.lists) optionals;
    inherit (lib.attrsets) optionalAttrs;
    shell' = pkgs.${shell} or null;
  in {
    programs = optionalAttrs (shell != null) {
      ${shell}.enable = true;
    };

    nix.settings.trusted-users = optionals admin [ name ];

    users.users.${name} = {
      inherit description;
      shell = shell';
      isNormalUser = !system;
      isSystemUser = system;
      extraGroups = builtins.concatLists [
        (optionals admin [ "wheel" "networkmanager" ])
        groups
      ];
    };
  }
