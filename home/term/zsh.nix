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
          rev = "6d059a3634c4880e8c9bb30ae565465601fb5bd2";
          sha256 = "0NW0TI//qFpUA2Hdx6NaYdQIIUpRSd0Y4NhwBbdssCs=";
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
        pushd ~/KaitlynEthylia
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
        popd
      }
    '';
  };
}
