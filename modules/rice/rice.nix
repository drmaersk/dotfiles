{ pkgs, config, ... }:

# NOTE: Change the configuration.nix file to match your system
# ANOTHER NOTE: Conky configuration will not work if you don't have 8 cpus  import ./configuration.nix;
with 
{
  username = "robban";
  # for your own i3 keybindings and other preferences (see i3config-extra-example.nix for an example)
};
let
  # Change this variable to a configurations file with your prefered i3 keymaps.
  # That file must only contain your keymaps and nothing else.
  i3-keys = 
    builtins.readFile i3-keys-path;

  i3-config = 
    import ./i3wm/i3config.nix {
      config-extra = ./keybindings.nix;
      inherit pkgs config;
    };

  i3-config-file =
    pkgs.writeTextFile {
      name = "technomancer-i3.conf";
      text = i3-config;
    };

  gtk2-theme = import ./paper-gtk2-theme.nix pkgs;
  
in
{

  imports = [ 
    gtk2-theme
  ];
  
  fonts.fonts = [
    pkgs.ubuntu_font_family
    pkgs.powerline-fonts
  ];

  # Desktop environment
  
  services = {
    compton = {
      enable = true;
      fade = true;
    };

    xserver = {
      enable = true;
      layout = "se";
      xkbVariant = "dvorak";
      videoDrivers = [ "intel" ];
      # Enable touchpad support. 
      libinput.enable = true;
      # Don't spawn xterm on startup
      desktopManager.xterm.enable = false;

      # Setting up the display manager
      displayManager.lightdm = {
        enable = true;
        background = "/home/robban/.config/wallpaper.jpg";
      };

      # Setup i3
      windowManager.i3 = {
        enable = true;
        configFile = i3-config-file;
      };
      windowManager.default = "i3";
    };
  };

  #Use x11 kb in console
  i18n.consoleUseXkbConfig = true;
  
  environment.systemPackages = [ pkgs.ubuntu_font_family ];
}
