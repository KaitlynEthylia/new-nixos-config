{ config, pkgs, lib, ... }:
let
  addons = {
    luafilesystem = pkgs.fetchFromGitHub {
      owner = "LuaCATS";
      repo = "luafilesystem";
      rev = "9b5cfc15be744c829c66519cb11e49669ae7e39b";
      hash = "sha256-j18RCaExXTUSpoCb7eROlSQo0yd7wxj8uFo0UkS8ORI=";
    };
    luasocket = pkgs.fetchFromGitHub {
      owner = "LuaCATS";
      repo = "luasocket";
      rev = "9a26f89986735762e806df2d85cef44a28cc70cc";
      hash = "sha256-orZ8CW7C7SzOBveZ+2UIYDlNAADva0Qj5v+tqgKL5UU=";
    };
    argparse = pkgs.fetchFromGitHub {
      owner = "goldenstein64";
      repo = "argparse-definitions";
      rev = "de6679ca499973a1ea73bae794d82facd0999f9f";
      hash = "sha256-jfMlA8ofxoeb+mHbKM+2Hkl0k/6xMohP60hp04vBqrQ=";
    };
  };
in
{
  xdg.dataFile = builtins.listToAttrs (map (e: {
    name = "luals/addons/${e}";
    value = { source = addons.${e}; };
  }) (builtins.attrNames addons));

  ethy.ftplugin.lua = {
    packages = with pkgs; [
      (lua54Packages.lua.withPackages
        (ps: map (e: ps.${e})
          (builtins.attrNames addons)))
      lua-language-server
      stylua
    ];
    plugins = [ "folke/neodev.nvim" ];
    null_ls.builtins = [ "formatting.stylua" ];
    setup = let
      settings = lib.ethy.luaValue {
        settings.Lua = {
          format.enable = false;
          workspace = {
            checkThirdParty = false;
            library = map
              (a: "${config.xdg.dataHome}/luals/addons/${a}/library")
              (builtins.attrNames addons);
          };
        };
      };
    in ''
      require 'neodev'.setup()
      require 'lspconfig'.lua_ls.setup ${settings}
      vim.cmd 'LspStart'
    '';
  };
}
