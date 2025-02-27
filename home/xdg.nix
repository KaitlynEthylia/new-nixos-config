{ config, lib, pkgs, ... }:
with lib;
{
  config.xdg = let
    home = path: /. + "${config.home.homeDirectory}" + path;
  in rec {
    enable = true;
    dataHome = home "/.local/share";
    stateHome = home "/.local/state";
    cacheHome = home "/.local/cache";
    configHome = home "/.config";
    mimeApps.enable = true;
    userDirs = {
      enable = true;
      desktop = "${dataHome}/applications";
      documents = home "/Documents";
      download = home "/Files";
      music = home "/Media";
      pictures = home "/Media";
      videos = home "/Media";
      templates = null;
      publicShare = null;
      createDirectories = true;
    };
  };

  options.files = mkOption {
    type = types.listOf types.path;
    default = [ ];
  };

  config.home.file = with builtins;
    let
      path = pkgs.symlinkJoin {
        name = "home";
        paths = config.files;
      };
    in
    mapAttrs
      (k: _: {
        source = "${path}/${k}";
        recursive = true;
      })
      (readDir path);
}
