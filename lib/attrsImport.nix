{ 
  flake.lib.attrsImport =
    let inherit (builtins) listToAttrs replaceStrings;
    in paths: args: listToAttrs (map
      (path: {
        name = replaceStrings [".nix"] [""] (baseNameOf path);
        value = if args != null then (import path) args else path;
      })
      paths);
}
