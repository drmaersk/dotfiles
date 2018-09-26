{ pkgs }:
let 
  python_rename_cmd = 
    ''
      /home/robban/Dev/dotfiles_laptop/python/i3-set-wsname.py
    '';

in
  pkgs.writeScriptBin "renamews" python_rename_cmd

