{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (jail (callPackage ./thorium.nix {}))
  ];
  files = [ ./conf ];
}
