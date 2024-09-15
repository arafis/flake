{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];

  # paste your boot config here...

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    hostName = "niksos";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Jakarta";
  i18n = {
    defaultLocale = "en_ID";
    extraLocaleSettings = {
      LC_ADDRESS = "en_ID";
      LC_IDENTIFICATION = "en_ID";
      LC_MEASUREMENT = "en_ID";
      LC_MONETARY = "en_ID";
      LC_NAME = "en_ID";
      LC_NUMERIC = "en_ID";
      LC_PAPER = "en_ID";
      LC_TELEPHONE = "en_ID";
      LC_TIME = "en_ID";
      LC_CTYPE="en_US.utf8";
    };
  };

  sound.enable = true;

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
      enable = true;
      windowManager.i3.enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      displayManager = {
        lightdm.enable = true;
        defaultSession = "xfce+i3";
      };
    };
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };

  users.users.foxane = {
    isNormalUser = true;
    initialPassword = "123456";
    description = "foxane";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-keyring
    polkit_gnome
    pulseaudioFull
  ];

  programs = {
    thunar.enable = true;
    dconf.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  
  hardware = {
    bluetooth.enable = true;
  };

  system.stateVersion = "24.05";
}