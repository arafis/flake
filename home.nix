{ config, pkgs, lib, ... }:

{
  home.username = "foxane";
  home.homeDirectory = "/home/foxane";

  home.packages = with pkgs; [
    brave
    xarchiver
    alacritty
    dmenu
    git
    nerdfonts
    networkmanagerapplet
    nitrogen
    pasystray
    picom
    rofi
    vim
    unrar
    unzip
    gh
  ];

  # Import your i3 and i3status configurations
  xdg.configFile = {
    "i3/config" = lib.mkForce {
      source = ./dotfiles/i3config;
    };
    "i3status/config" = lib.mkForce {
      source = ./dotfiles/i3statusconfig;
    };
  };

#  home.file = {
#    ".config/i3/config".source = ./dotfiles/i3config;
#    ".config/i3status/config".source = ./dotfiles/i3status;
#  };

  # Enable i3 in Home Manager
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = null; # We're using our own config file
  };

  # You can add more user-specific configurations here

  # Don't forget this line at the end:
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
