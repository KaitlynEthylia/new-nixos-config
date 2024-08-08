{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "catppuccin-sddm";
  src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "sddm";
    rev = "7fc67d1027cdb7f4d833c5d23a8c34a0029b0661";
    sha256 = "SjYwyUvvx/ageqVH5MmYmHNRKNvvnF3DYMJ/f2/L+Go=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./src/catppuccin-mocha/* $out/
    sed \
      -e '2cFont="CaskaydiaCove Nerd Font Mono"' \
      -e '3cFontSize=16' \
      -e '7aCursorTheme=catppuccin-mocha-pink-cursors' \
      -i $out/theme.conf
  '';
}
