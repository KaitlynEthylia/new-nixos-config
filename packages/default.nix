{ self, inputs, ... }:
let
  inherit (self.lib) attrsImport allExcept modules;
  derivations = attrsImport (allExcept [] ./.) null; 
in {
  perSystem = { system, lib, ... }:
  let
    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ self.overlays.default ]
        ++ modules "overlays";
      config.allowUnfree = true;
    };
  in {
    packages = builtins.mapAttrs
      (_: path: pkgs.callPackage path {})
      derivations;

    _module.args.pkgs = pkgs;
  };

  flake.overlays.default = final: prev: builtins.mapAttrs
      (_: path: final.lib.callPackageWith prev path {})
      derivations;
}
