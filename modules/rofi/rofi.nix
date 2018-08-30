{ pkgs}:
let 
  colors = import ../colors.nix;

  rofi-config = import ./rofi-conf.nix {
    inherit colors;
  };

  rofi-config-file = pkgs.writeTextFile {
    name = "technomancer-rofi.config";
    text = rofi-config;
  };

  roficmd = 
    ''
      ${pkgs.coreutils}/bin/env XENVIRONMENT=${rofi-config-file} ${pkgs.rofi}/bin/rofi -display-run λ $@
    '';

in
  pkgs.writeScriptBin "svarog-rofi" roficmd

