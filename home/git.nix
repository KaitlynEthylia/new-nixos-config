{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Kaitlyn~Ethylia";
    userEmail = "kaitlyyn.ethylia@proton.me";
    extraConfig = {
      init.defaultBranch = "mistress";
      core.autocrlf = false;
      core.eol = "lf";
      pull.rebase = true;
    };
    hooks = {
      pre-commit = lib.getExe (pkgs.writeShellScriptBin "pre-commit" ''
        tmpd=$(mktemp -p /dev/shm -d -t "git-index.XXXX")
        git checkout-index -a --prefix="$tmpd"/

        get_marks() {
          git status --porcelain | cut --bytes 4- | while read file; do
            if [ -e "$tmpd/$file" ]; then
              # use printf so that I can commit this repo without it getting flagged
              grep -n $(printf 'git!%s' 'commit') "$tmpd/$file" |
              sed "s/:/ /" | while read line; do
                echo "$file:$line"
              done
            fi
          done
        }

        marks=$(get_marks)
        if [ -n "$marks" ]; then
          echo -e "\x1b[31mnocommit sigil(s) founds:\x1b[0m"
          echo $marks
          status=1
        else
          status=0
          if [ -e ./.git/hooks/pre-commit ]; then
            ./.git/hooks/pre-commit "$@"
            status=$?
          fi
        fi

        rm -r $tmpd
        exit $status
      '');
    };
    ignores = [
      "TODO*"
    ];
  };
}
