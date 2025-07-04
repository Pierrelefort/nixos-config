# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/boot-loader.nix
    ../../modules/networking.nix
    ../../modules/i18n.nix
    ../../modules/nix-settings-experimental.nix
    ../../modules/printing.nix
    ../../modules/sound.nix
    ../../modules/users.nix
    ../../modules/packages.nix
    ../../modules/docker.nix
    ../../modules/git.nix
    ../../modules/tmux.nix
    ../../modules/chezmoi.nix
    ../../modules/zsh.nix
    ../../modules/fonts.nix
    ../../modules/shells.nix
    ../../modules/nvim.nix
    ../../modules/rust.nix
  ];

  networking.hostName = "framework"; 

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
