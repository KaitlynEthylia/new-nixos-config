{ self, lib, ... }:
let
  inherit (self.lib) mkSystem allExcept;
  mkSystems = builtins.foldl'
    (acc: system: lib.recursiveUpdate
      acc
      { ${system.type}.${system.host} = system.config; })
    {};
  systems = (mkSystems
    (map
      mkSystem
      (allExcept [] ./.)));
in {
  # just doing `flake = systems;` causes infinite recursion becaues of
  # the dependency on flake.lib and the fact that nix is fucked
  flake.nixosConfigurations = systems.nixosConfigurations;
  flake.nixOnDroidConfigurations = systems.nixOnDroidConfigurations;
}
