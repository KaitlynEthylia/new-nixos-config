{ config, pkgs, lib, ... }:
with lib;
{
  options.ethy.ftplugin = mkOption {
    type = with types; attrsOf (submodule {
      options = {
        packages = mkOption {
          type = listOf package;
          default = [];
          description = '''';
        };
        plugins = mkOption {
          # TODO: use actual plugin spec
          type = nullOr (listOf anything);
          default = null;
          description = '''';
        };
        null_ls = mkOption {
          type = nullOr (either (listOf str) (submodule {
            options = {
              builtins = mkOption {
                type = listOf str;
                default = [];
                description = '''';
              };
            };
          }));
          default = null;
          description = '''';
        };
        setup = mkOption {
          type = nullOr (either str (submodule {
            options = {
              server = mkOption {
                type = str;
                description = '''';
              };
              settings = mkOption {
                type = nullOr attrs;
                default = null;
                description = '''';
              };
            };
          }));
          default = null;
          description = '''';
        };
        enter = mkOption {
          type = nullOr str;
          default = null;
          description = '''';
        };
        colourscheme = mkOption {
          type = nullOr str;
          default = null;
          description = '''';
        };
        parsers = mkOption {
          type = nullOr (either (listOf str) str);
          default = null;
          description = '''';
        };
        treesitter = mkOption {
          type = bool;
          default = true;
          description = '''';
        };
      };
    });
    default = {};
    description = '''';
  };

  config.files = [ ./conf/nvim ];
  config.home.packages = (with pkgs; [
    neovim
    gcc
    fd
    ripgrep
  ]) ++ (with builtins; concatMap
    (p: p.packages)
    (attrValues config.ethy.ftplugin));
  config.xdg.configFile = with builtins; mapAttrs
    (k: v:
      let
        inherit (ethy) luaValue;
        elv = v: f: if v != null then f v else "";
        wrapFn = str: "function() ${str} end";
        plugins = elv v.plugins (v: "spec = ${luaValue v},");
        null_ls = {
          null = _: "";
          list = v: "null_ls = ${luaValue v},";
          set = v: ''null_ls = function(builtins) return { ${concatStringsSep ", " (map
            (b: "builtins.${b}")
            v.builtins)
          } } end,'';
        }.${typeOf v.null_ls} v.null_ls;
        setup = {
          null = _: "";
          string = v: "setup = ${wrapFn v},";
          set = v: "setup = ${luaValue v},";
        }.${typeOf v.setup} v.setup;
        enter = elv v.enter (v: "enter = ${wrapFn v},");
        colourscheme = elv v.colourscheme (v: "colourscheme = '${v}',");
        parsers = elv v.parsers (v: "parse = ${luaValue v},");
        treesitter = if !v.treesitter then "no_treesitter = true," else "";
      in {
        target = "nvim/lua/lang/${k}.lua";
        text = ''
return require 'lang' '${k}' {
    ${treesitter}
    ${parsers}
    ${colourscheme}

    ${setup}
    ${enter}
    ${plugins}
    ${null_ls}
}
        '';
      })
      config.ethy.ftplugin;
}
