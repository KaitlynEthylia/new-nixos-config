{ pkgs, ... }:
with builtins;
cwd: listToAttrs (map
  (path: {
    name = replaceStrings [".nix"] [""] path;
    value = (import (pkgs.lib.path.append cwd path)) { inherit pkgs; };
  })
  (attrNames (readDir cwd)))
