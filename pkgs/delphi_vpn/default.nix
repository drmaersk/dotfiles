with import <nixpkgs> { };

stdenv.mkDerivation {
  name = "delphi_vpn";

  src = ./.;

  buildInputs = [ openconnect ];

  buildCommand = ''
    mkdir -p $out/bin
    cat <<EOF >$out/bin/delphi_connect
    #!${bash}/bin/bash
    PATH=${stdenv.lib.makeSearchPath "bin" [openconnect]}:\$PATH
    EOF
    cat $src/delphi_connect >>$out/bin/delphi_connect
    chmod +x $out/bin/delphi_connect
  '';
}
