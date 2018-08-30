# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, nixpkgs, ... }:

let
  pidgin = pkgs.pidgin-with-plugins.override {
    plugins = [ pkgs.pidginsipe ];
  };
  spotify = pkgs.spotify.overrideDerivation (oldAttrs: rec {
    name = "spotify-${version}";
    version = "1.0.70.399.g5ffabd56-26";
  
    src = pkgs.fetchurl {
      url = "https://repository-origin.spotify.com/pool/non-free/s/spotify-client/spotify-client_${version}_amd64.deb";
      sha256 = "0kpakz11xkyqqjvln4jkhc3z5my8zgpw8m6jx954cjdbc6vkxd29";
     };
});



in
{
  imports =
    [ # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
#    ./modules/proxy_no_proxy.nix
    ./modules/proxy.nix
    ./modules/docker.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    zeroconf.discovery.enable = true;
    package = pkgs.pulseaudioFull;
  };


  #Workaround instructions if a2dp does not work.
  #  Try 1-2 times
  #  systemctl restart bluetooth
  #  bluetoothctl
  #  connect <MAC>
  #  pacmd set-card-profile "$(pactl list cards short | egrep -o bluez_card[[:alnum:]._]+)" a2dp_sink
  hardware.bluetooth.extraConfig = "
  [General]
  Enable=Source,Sink,Media,Socket
";


  nixpkgs.config.pulseaudio = true;
 

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";
  services.ntp.enable = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  environment.systemPackages = with pkgs; [
    wget
    vim
    emacs
    firefox
    gitRepo
    git
    pidgin
    chromium
    keepassx-community
    global
    kdiff3
    minicom
    thunderbird
    virtualbox
    terminator
    exfat
    exfat-utils
    fuse_exfat
    discount
    autocutsel
    guake
    gnome3.gconf
    gptfdisk
    davmail
    libreoffice
    dosfstools
    notepadqq
    gdb
    fzf
    cmake
    gcc7
    gnumake42
    clang_6
    llvm_6
    libcxx
    unzip
    zlib
    openssl
    rtags
    ntfs3g
    pavucontrol
    lsof
    ag
    spotify
    parcellite
    jre
    graphviz
    doxygen
    tomcat8
    opengrok
    lm_sensors
    bluez
    bluez-tools
    blueman
    python
    python3
    gdb
    cpulimit
    file
    libcgroup
    lcov
    ctags
    openjdk10
    tmux
    sshfs
    nixnote2
    pinta
  ];
#    cquery-2018-05-01

  
  #     linuxPackages.virtualbox
  virtualisation.virtualbox.host.enable = true;
  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;

  programs.bash.interactiveShellInit = ''
    title() { printf '\033]2;'$1'\a'; }
    start_rdm() { rdm -j 1 -B -a 19 &> /dev/null & disown; }
  '';
  
  programs.bash.shellAliases = {
    "ll" = "ls -al";
    "ec" = "emacsclient --no-wait";
    "vbmeta"="/home/robban/ihu/external/avb/avbtool make_vbmeta_image --flag 2 --output vbmeta.img;echo 'done'";
    "sync"="adb root;adb remount;adb sync;adb shell sync";
    "build_server_connect"="ssh robban@10.239.124.56";
    "copy_build_server_ihu"="scp -r robban@10.239.124.56:/home/robban/ihu/out/target/product/ihu_abl_car/ihu_kraken-flashfiles-eng.robban.zip .";
    "copy_build_server_sem"="scp -r robban@10.239.124.56:/home/robban/sem/out/target/product/gtt_abl_car/fast_flashfiles/ .";
    "connect_serial0"="sudo minicom -b 115200 -D /dev/ttyUSB0";
    "connect_serial1"="sudo minicom -b 115200 -D /dev/ttyUSB1";
    "mount_bs"="sshfs -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 robban@10.239.124.56:/ /home/robban/buildserver/";
    "unmount_bs"="fusermount3 -u /home/robban/buildserver/";
  };

  environment.etc."inputrc".text = lib.mkForce (
    builtins.readFile <nixpkgs/nixos/modules/programs/bash/inputrc>
    + ''
      #  alternate mappings for "page up" and "page down" to search the history
      "\e[5~": history-search-backward
      "\e[6~": history-search-forward
    ''
  );
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.layout = "se";
   services.xserver.xkbVariant = "dvorak";
   services.xserver.videoDrivers = [ "intel" ];

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
   services.xserver.displayManager.gdm.enable = true;
   services.xserver.desktopManager.gnome3.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.robban = {
     isNormalUser = true;
     extraGroups = ["wheel" "docker" "sound" "pulse" "audio" ];
     uid = 1000;
  };

  nixpkgs.config.allowUnfree = true;
    
#    firefox.enableAdobeFlash = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

  services.udev.extraRules = ''
    # IHU
    SUBSYSTEM=="usb", ATTR{idVendor}=="8087", MODE="0666", GROUP="plugdev"
    '';

}
