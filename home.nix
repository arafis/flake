{ config, pkgs, lib, ... }:

{
  home.username = "foxane";
  home.homeDirectory = "/home/foxane";

  home.packages = with pkgs; [
    xdg-utils
    vscode-fhs
    brave
    xarchiver
    alacritty
    dmenu
    git
    gitui
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
    fastfetch
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
  home.file.fastfetch = {
    recursive = true;
    source = ./dotfiles/fastfetch;
    target = .config/fasfetch;
  };

  # Git Gud
  programs.git = {
    enable = true;
    userName = "foxane";
    userEmail = "65512187+foxane@users.noreply.github.com";
    config = {
      init.defaultBranch = "main";
      core.editor = "nano";
    };
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
