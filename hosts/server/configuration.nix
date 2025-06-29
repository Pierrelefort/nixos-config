# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/packages.nix
    ../../modules/docker.nix
    ../../modules/git.nix
    ../../modules/tmux.nix
    ../../modules/chezmoi.nix
    ../../modules/zsh.nix
    ../../modules/fonts.nix
  ];

  nix.nixPath = [
    "/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/home/nixos/nixos-config/nixos/server/configuration.nix"
  ];

  networking.hostName = "server";

# Set your time zone.
  time.timeZone = "Europe/Paris";

# Users
  users.defaultUserShell=pkgs.zsh;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixos = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];  # Enable ‘sudo’ for the user.
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
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}

