{ pkgs, ... }:

{
  ethy.ftplugin.markdown = {
    packages = with pkgs; [ glow marksman ];
    parsers = [ "markdown" "markdown_inline" ];
    setup.server = "marksman";
    plugins = [ {
      "1" = "tadmccorkle/markdown.nvim";
      opts = {};
    } ];
  };
}
