{ ... }:

{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
  };

  files = [ ./conf/wezterm ];
}
