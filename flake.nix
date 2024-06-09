{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    niri.url = "github:sodiboo/niri-flake";
    home.url = "github:nix-community/home-manager";

    niri.inputs.nixpkgs.follows = "nixpkgs";
    home.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [ inputs.niri.overlays.niri ];
      };
      libs = with builtins; listToAttrs (map
        (path: {
          name = replaceStrings [".nix"] [""] path;
          value = (import (pkgs.lib.path.append ./lib path)) { inherit pkgs; };
        })
        (attrNames (readDir ./lib)));
    in
    {
      nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = libs;
        modules = with inputs; [
          ./common
          ./hardware
          ./system
          catppuccin.nixosModules.catppuccin
          home.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = libs;
            home-manager.useGlobalPkgs = true;
            home-manager.users.kaitlyn.imports = [
              ./common
              ./home
              catppuccin.homeManagerModules.catppuccin
              niri.homeModules.niri
            ];
          }
        ];
      };
    };
}
