{ lib, pkgs }:

{
  imports = lib.ethy.allExcept [] ./.;

  ethy.doas = true;
}
