{ allExcept, ... }:

{
  imports = (allExcept [ ./lang ] ./.) ++ (allExcept [] ./lang);

  home = {
    username = "kaitlyn";
    homeDirectory = "/home/kaitlyn";
  };

  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
    PAGER = "bat";
    MANPAGER = "bat -l man";
    OPENER = "xdg-open";
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
