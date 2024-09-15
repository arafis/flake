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
    "rofi/config.rasi" = lib.mkForce {
      source = ./dotfiles/rofi;
    };
  };

  # Git Gud
  programs.git = {
    enable = true;
    userName = "foxane";
    userEmail = "65512187+foxane@users.noreply.github.com";
    extraConfig = ''
      # Set the default branch name for new repositories
      [init]
        defaultBranch = main

      # Additional Git configurations
      [core]
        editor = nano
      [alias]
        co = checkout
        br = branch
        ci = commit
        st = status
    '';
  };

  # Enable i3 in Home Manager
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = null;
  };

  # Fuck da unstable
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
