# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

  nix.nixPath = [
    "/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/home/nixos/nixos-config/nixos/server/configuration.nix"
  ];



# Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

# networking.hostName = "nixos"; # Define your hostname.
# Pick only one of the below networking options.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
# networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

# Set your time zone.
  time.timeZone = "Europe/Paris";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
# i18n.defaultLocale = "en_US.UTF-8";
# console = {
#   font = "Lat2-Terminus16";
#   keyMap = "fr";
#   useXkbConfig = true; # use xkb.options in tty.
# };

# Enable the X11 windowing system.
# services.xserver.enable = true;




# Configure keymap in X11
# services.xserver.xkb.layout = "us";
# services.xserver.xkb.options = "eurosign:e,caps:escape";

# Enable CUPS to print documents.
# services.printing.enable = true;

# Enable sound.
# hardware.pulseaudio.enable = true;
# OR
# services.pipewire = {
#   enable = true;
#   pulse.enable = true;
# };

# Enable touchpad support (enabled default in most desktopManager).
# services.libinput.enable = true;

# Users
  users.defaultUserShell=pkgs.zsh;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixos = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];  # Enable ‘sudo’ for the user.
  };

# Programs

  programs = {
    git = {
      enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        nbuild = "sudo nixos-rebuild switch";
        cd = "z";
      };

      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "history"
          "z"
          "git"
          "chezmoi"
          "zsh-autosuggestions"
          "zsh-syntax-highlighting"
          "zsh-autocomplete"
        ];
      };

      histSize = 10000;
    };

    tmux = {
      enable = true;
      clock24 = true;
    }; 
  };

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
    # Common cli tools
    vim
    fzf
    # Nice to have
    btop
    gdu
    duf
    bat
    eza
    ripgrep
    parallel
    tldr
    # Theme for shell
    oh-my-posh
    # Dotfiles management
    chezmoi
    # Docker cli tools
    lazydocker
    # Git cli tools
    lazygit
    # wireguard libs
    wireguard-tools
  ];
  
  # Completing for system packages
  environment.pathsToLink = [ "/share/zsh" ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = t ;
#   enableSSHSupport = true;
# };

# Docker

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

# List services that you want to enable:
  services.fail2ban = {
    enable = true;
    ignoreIP = [
      # Whitelist some subnets
      "10.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16"
      "1.1.1.1"  # Cloudflare DNS IP
    ];
  };

# Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "no";  # Disable root login for security
      PasswordAuthentication = false;  # Allow password-based login
      PubkeyAuthentication = true;
  };

# Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ 51820 ];
  };
  
  

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
# to actually do that.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}

