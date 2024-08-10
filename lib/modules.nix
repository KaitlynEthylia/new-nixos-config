{ inputs, ... }:

{
  flake.lib.modules =
    let inherit (builtins) filter attrValues mapAttrs;
    in modulesAttr: filter
      (v: v != null)
      (attrValues
        (mapAttrs
          (k: v:
            let mods = v.${modulesAttr} or {};
            in mods.default or mods.${k} or null)
          inputs));
}
