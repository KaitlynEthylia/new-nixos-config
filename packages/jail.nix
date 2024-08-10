{ writeShellScriptBin, lib, ... }:

writeShellScriptBin "jail" ''
  HOME=$HOME/.local/jail/$(basename $1)
  if [ ! -e $HOME ]; then
    mkdir -pm 1700 $HOME
    ln -s $XDG_CONFIG_HOME $HOME/.config
    mkdir $HOME/.local
    ln -s $XDG_STATE_HOME $HOME/.local/state
    ln -s $XDG_DATA_HOME $HOME/.local/share
  fi
  exec $@
'' // {
  make = pkg:
    let exe = lib.getExe pkg;
    in writeShellScriptBin (builtins.baseNameOf exe) ''
      exec jail ${exe} $@
    '';
}
