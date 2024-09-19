{ config, pkgs, ... }:

{
  # Boot loader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


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
  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = true;

  services = {
    xserver = {
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
        defaultSession = "xfce+i3";
        lightdm = {
          enable = true;
          autoLogin.timeout = 0;
          greeter.enable = false;
        };
        autoLogin = {
          enable = "true";
          user = "foxane";
        };
      };
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    spice-vdagentd.enable = true; # Qemu vm clipboard share
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
    homoMode = "775";
    description = "foxane";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "scanner"
      "lp"
      "video" 
      "input" 
      "audio"
    ];
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-keyring
    polkit_gnome
    pulseaudioFull
    spice-vdagent
  ];

  programs = {
    dconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xcfe; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    zsh = {
    	enable = true;
	  	enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = ["git"];
        theme = "xiong-chiamiov-plus"; 
      	};
      
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
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

  # Virtualization / Containers
  virtualisation.libvirtd.enable = false;
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };

  # OpenGL
  hardware.graphics = {
    enable = true;
  };

  # For Electron apps to use wayland
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  console.keyMap = "us";

  system.stateVersion = "24.05";
}
