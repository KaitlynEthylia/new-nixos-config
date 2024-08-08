{ stdenv, fetchFromGitHub, pkg-config, libev, xorg, ... }:
let version = "1.4";
in stdenv.mkDerivation {
  pname = "xmousepasteblock";
  inherit version;

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    libev
    xorg.libX11
    xorg.libXfixes
    xorg.libXi
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  src = fetchFromGitHub {
    owner = "milaq";
    repo = "XMousePasteBlock";
    rev = version;
    hash = "sha256-uHlHGVnIro6X4kRp79ibtqMmiv2XQT+zgbQagUxdB0c=";
  };
}


