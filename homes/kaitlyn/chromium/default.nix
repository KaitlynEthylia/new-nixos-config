{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (jail.make thorium)
  ];
  files = [ ./conf ];
}
