{ pkgs, ... }:

{
  ethy.ftplugin.jsonc = {
    packages = with pkgs; [ nodePackages.vscode-json-languageserver ];
    parsers = [ "json" "jsonc" ];
    setup = {
      server = "jsonls";
      settings = {
        cmd = [ "vscode-json-languageserver" "--stdio" ];
        capabilities = ''r!(function()
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true
          return capabilities
        end)()'';
      };
    };
  };

  ethy.ftplugin.json.enter = ''
    vim.bo.filetype = 'jsonc'
  '';
}
