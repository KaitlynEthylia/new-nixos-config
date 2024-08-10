  # this will need to be changed if I ever use darwin but that's unlikely
{ withSystem, self, inputs, lib, ... }:

{
  flake.lib.mkSystem = path: let
    inherit (lib.lists) singleton concatLists optionals;
    inherit (lib.attrsets) genAttrs;
    inherit (lib.path) append;
    inherit (self.lib) allExcept modules mkUser;
    sysconfig = import (append path "_system.nix");
    system = "${sysconfig.arch}-linux";
    genSystem =
      if sysconfig.target == "android"
      then inputs.nix-on-droid.lib.nixOnDroidConfiguration
      else inputs.nixpkgs.lib.nixosSystem;
    host = builtins.baseNameOf path;
  in {
    inherit host;
    type =
      if sysconfig.target == "android" then "nixOnDroidConfigurations"
      else "nixosConfigurations";
    config = withSystem system ({ pkgs, lib, ... }: genSystem {
      inherit system;

      modules = concatLists [
        (singleton {
          system.stateVersion = "24.05";
          networking.hostName = host;
          nixpkgs.overlays = [ self.overlays.default ];
        })
        (allExcept [] path)
        (allExcept [] ./../systems/_modules)
        (modules "nixosModules")
        (optionals (sysconfig ? users) (
          (map
            (user: mkUser pkgs (import "${self}/homes/${user}/_user.nix"))
            sysconfig.users) ++
          singleton {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = genAttrs sysconfig.users (user: {
                nixpkgs.overlays = [ self.overlays.default ];
                imports = concatLists [
                  (modules "homeManagerModules")
                  (modules "hmModules")
                  (allExcept [] ./../homes/_modules)
                  (singleton (append ./../homes user))
                ];
                home.stateVersion = "24.05";
                dconf.enable = true;
              });
            };
          }))
      ];
    });
  };
}
