{ self, withSystem, inputs, lib, ... }:
let
  allExcept = (import ./allExcept.nix { inherit (inputs.nixpkgs) lib; });
  attrsImport = (import ./attrsImport.nix {});
  ethy' = (lib: {
    ethy = attrsImport (allExcept [] ./.) { inherit self lib inputs withSystem; };
  });
in {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "TODO";
  };

  config.flake.lib = (ethy' lib).ethy;

  config.perSystem._module.args.lib =
    let
      lib' = inputs.nixpkgs.lib;
      libethy = lib'.fixedPoints.composeManyExtensions [
        (_: ethy')
        (_: _: inputs.home-manager.lib)
      ];
    in lib'.extend libethy;
}
