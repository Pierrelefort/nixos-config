{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Dotfiles management
    chezmoi
  ];
}

