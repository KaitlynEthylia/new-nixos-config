{ lib, ... }:
with lib;
{
  options.ethy.shells = mkOption {
    type = with types; attrsOf shellPackage;
    default = {};
    description = '''';
  };

  options.ethy.templates = mkOption {
    type = with types; attrsOf submodule {
      options = {
        path = mkOption {
          type = string;
          description = '''';
        };
        description = mkOption {
          type = nullOr string;
          default = null;
          description = '''';
        };
      };
    };
    default = {};
    description = '''';
  };
}
