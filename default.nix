with import <nixpkgs> {};

stdenv.mkDerivation rec {
    name = "scroll";
    version = "0.99";
    src = ./.;
    nativeBuildInputs = [ pkgconfig ];
    buildInputs = [ xorg.libX11 ncurses xorg.libXext xorg.libXft fontconfig harfbuzz ];
    installPhase = ''
        TERMINFO=$out/share/terminfo make install PREFIX=$out
        '';
}
