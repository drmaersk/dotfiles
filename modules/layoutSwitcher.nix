{ config, lib, pkgs, ... }:

{
  imports = [ ];

  services.xserver = {
    layout = "dvorak,se";
    xkbVariant = "se,";
    xkbOptions = "grp:caps_toggle";
  };
}
