{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    lf
    poppler_utils
    unzip
    file
    jq
  ];
  files = [ ./conf/lf ];

  programs.zsh.shellAliases.lfcd = ''cd $(lf -print-last-dir)'';
  programs.zsh.shellAliases.lfpd = ''pushd $(lf -print-last-dir)'';

  home.sessionVariables.TEMPEDIT_LIST = "${config.xdg.stateHome}/tempedit";
}
