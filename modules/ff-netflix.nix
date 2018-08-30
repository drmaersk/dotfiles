{ pkgs}:
let 
  netflixcmd = 
    ''
      ${pkgs.coreutils}/bin/env ${pkgs.firefox}/bin/firefox -p netflix
    '';

in
  pkgs.writeScriptBin "netflix" netflixcmd

