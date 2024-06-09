{ pkgs, ... }:

{
  ethy.ftplugin.jsonc = {
    packages = with pkgs; [ nodePackages.vscode-json-languageserver ];
    parsers = [ "json" "jsonc" ];
    setup = {
      server = "jsonls";
      settings.cmd = [ "vscode-json-languageserver" "--stdio" ];
    };
  };

  ethy.ftplugin.json.enter = ''
    vim.bo.filetype = 'jsonc'
  '';
}
