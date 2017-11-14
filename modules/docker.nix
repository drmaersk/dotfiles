{ config, lib, pkgs, ... }:

{
  imports = [ ];

  environment.systemPackages = with pkgs; [
    docker
    (import ./docker-containers/android-env)
  ];

  virtualisation.docker.enable = true;
}
