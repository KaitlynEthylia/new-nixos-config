{ self, inputs, lib, ... }:
let allExcept = (import ./allExcept.nix { inherit lib; }).flake.lib.allExcept;
in {
  imports = allExcept [] ./.;
  
  options.flake.lib = lib.mkOption {
    type = with lib.types; attrs;
    default = {};
  };

  config.perSystem._module.args.lib =
    let
      lib' = inputs.nixpkgs.lib;
      libethy = lib'.makeExtensible (_: {
        ethy = self.lib;
      });
    in libethy.extend (_: _: lib');
}
