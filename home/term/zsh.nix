{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    defaultKeymap = "emacs";
    cdpath = [ "~" ];
    history.path = "${config.xdg.dataHome}/zsh/.zsh_history";
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "cfc3fd9a75d0577aa9d65e35849f2d8c2719b873";
          sha256 = "sha256-QcPNXpTFRI59Oi59WP4XlC+xMyN6aHRPF4UpJ6E1vok=";
        };
      }
    ];
    shellAliases = {
      rb = "reboot";
      sd = "shutdown now";

      "d!" = "doas $(fc -lrn | head -1)";
    };
    initExtra = ''
      set globdots
    '';
    profileExtra = ''
      function nixrb {
        cd ~/KaitlynEthylia
        git add .
        if [ -f $TEMPEDIT_LIST ]; then
          while read line; do
            real=''${line::-7}
            rm $real
            mv $line $real
          done < $TEMPEDIT_LIST
          rm $TEMPEDIT_LIST
        fi
        doas nixos-rebuild switch --flake .#''${1:=$(hostname)}
      }
    '';
  };
}
