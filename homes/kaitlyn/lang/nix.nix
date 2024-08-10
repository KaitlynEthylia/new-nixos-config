{ pkgs, ... }:

{
  ethy.ftplugin.nix = {
    packages = with pkgs; [ nil nixpkgs-fmt ];
    setup = {
      server = "nil_ls";
      settings.nil.formatting.command = [ "nixpkgs-fmt" ];
    };
  };
}
