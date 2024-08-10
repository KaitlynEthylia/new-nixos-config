# https://github.com/jeslie0/fonts/blob/main/flake.nix
{ stdenvNoCC, fetchzip, ... }:

stdenvNoCC.mkDerivation {
  name = "palatino";
  dontConfigure = true;
  src = fetchzip {
    url =
      "https://www.dfonts.org/wp-content/uploads/fonts/Palatino.zip";
    sha256 = "sha256-FBA8Lj2yJzrBQnazylwUwsFGbCBp1MJ1mdgifaYches=";
    stripRoot = false;
  };
  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src/Palatino $out/share/fonts/truetype/
  '';
  meta = { description = "The Palatino Font Family derivation."; };
}
