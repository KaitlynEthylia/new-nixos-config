{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home.url = "github:nix-community/home-manager";
    musnix.url = "github:musnix/musnix";
    nix-index.url = "github:nix-community/nix-index-database";
    lix.url = "git+https://git.lix.systems/lix-project/nixos-module";

    home.inputs.nixpkgs.follows = "nixpkgs";
    musnix.inputs.nixpkgs.follows = "nixpkgs";
    nix-index.inputs.nixpkgs.follows = "nixpkgs";
    lix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            jail = pkg: let
              exe = final.lib.getExe pkg;
            in final.writeShellScriptBin (builtins.baseNameOf exe) ''
              exec jail ${exe} $@
            '';
          })
        ];
      };
      libs = import ./lib/attrsImport.nix { inherit pkgs; } ./lib;
    in
    rec {
      nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = libs;
        modules = with inputs; [
          ./common
          ./hardware
          ./system
          catppuccin.nixosModules.catppuccin
          musnix.nixosModules.musnix
          home.nixosModules.home-manager
          lix.nixosModules.default
          {
            home-manager = {
              extraSpecialArgs = libs;
              useGlobalPkgs = true;
              users.kaitlyn.imports = [
                ./common
                ./home
                catppuccin.homeManagerModules.catppuccin
                nix-index.hmModules.nix-index
              ];
            };
            # otherwise home-manager breaks
            programs.dconf.enable = true;
          }
          {
            nix.registry = {
              self.flake = self;
              nixpkgs.flake = nixpkgs;
            };
          }
        ];
      };
      devShells.${system} = nixosConfigurations.nix.config.ethy.shells;
      templates = nixosConfigurations.nix.config.ethy.templates;
    };
}
