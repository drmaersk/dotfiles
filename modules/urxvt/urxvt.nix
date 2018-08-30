{ pkgs }:
let 
  colors = import ../colors.nix;
  
  urxvt-config = 
    import ./urxvt-conf.nix{ inherit colors; };

  urxvt-config-file =
    pkgs.writeTextFile {
      name="urxvt-xresources"; 
      text=urxvt-config;
    };

in

  pkgs.writeScriptBin
  "svarog-urxvt"
  ''${pkgs.coreutils}/bin/env XENVIRONMENT=${urxvt-config-file} ${pkgs.rxvt_unicode-with-plugins}/bin/urxvt $@''
