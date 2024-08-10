{ config, pkgs, ... }:
# let awesome = (pkgs.awesome.overrideAttrs (_: _: {
#   version = "git-";
#   src = pkgs.fetchFromGitHub {
#     owner = "awesomewm";
#     repo = "awesome";
#     rev = 
#   }
# }).override { lua = pkgs.luajit; });
# in
{
  home.packages = with pkgs; [
    brightnessctl
    playerctl
    xclip
    xorg.xinit
    bemenu
    (callPackage ./xmousepasteblock.nix {})
  ];

  files = [ ./conf/awesome ];

  xsession = {
    enable = true;
    windowManager.awesome = {
      enable = true;
#     package = awesome;
    };
    initExtra = ''
      # nix tries to be clever and solve a bug that was resolved in 2009, but in the
      # process hardcodes the paths to xsession and xprofile and ends up being really
      # fucking stupid.
      rm -rf ~/.compose-cache

      # stupid fucking dconf
      rm -rf ~/.cache

      xmousepasteblock &
    '';
    profilePath = ".config/x/profile";
    scriptPath = ".config/x/session";
  };
  home.sessionVariables = {
    XCOMPOSECACHE = "${config.xdg.cacheHome}/x/compose";
    XINITRC = "${config.xdg.configHome}/x/init";
  };
  home.file.".local/cache/x/.keep".text = '''';

  # TODO, xinit doesn't work, I blame nix
  xdg.configFile."x/init" = {
    executable = true;
    text = ''
      xsessionddir="/etc/X11/Xsession.d"
      if [ -d "$xsessionddir" ]; then
          for i in `ls $xsessionddir`; do
              script="$xsessionddir/$i"
              echo "Loading X session script $script"
              if [ -r "$script"  -a -f "$script" ]
              && expr "$i" : '^[[:alnum:]_-]\{1,\}$' > /dev/null; then
                  . "$script"
              fi
          done
      fi

      if [ -d /etc/X11/Xresources ]; then
        for i in /etc/X11/Xresources/*; do
          [ -f $i ] && xrdb -merge $i
        done
      elif [ -f /etc/X11/Xresources ]; then
        xrdb -merge /etc/X11/Xresources
      fi
      exec "$HOME/${config.xsession.scriptPath}"
    '';
  };
}
