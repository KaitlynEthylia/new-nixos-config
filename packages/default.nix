{ self, inputs, ... }:
let
  inherit (self.lib) allExcept attrsImport;
  derivations = attrsImport (allExcept [] ./.) null; 
in {
  perSystem = { system, lib, ... }:
  let
    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ self.overlays.default ];
      config.allowUnfree = true;
    };
  in {
    packages = builtins.mapAttrs
      (_: path: pkgs.callPackage path {})
      derivations;

    _module.args.pkgs = pkgs;
  };

  flake.overlays.default = _: prev: builtins.mapAttrs
      (_: path: prev.callPackage path {})
      derivations;
}
