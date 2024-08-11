{ lib, ... }:
with builtins;
let
  luaValue = value: {
    int = toString;
    float = toString;
    path = toString;
    null = _: "nil";
    bool = val: if val then "true" else "false";
    string = val: if substring 0 2 val == "r!"
      then substring 2 (-1) val
      else "[[${val}]]";
    list = val: "{ ${concatStringsSep ", " (map luaValue val)} }";
    set = val: "{ ${concatStringsSep ", "
      (attrValues (mapAttrs (k: v: let
        maybe = tryEval (lib.strings.toIntBase10 k);
        key = if maybe.success then toString maybe.value else "'${k}'";
      in ''[${key}] = ${luaValue v}'') val))
    } }";
    lambda = _: throw "Cannot serialise lambda values";
  }.${typeOf value} value;
in luaValue
