{ pkgs, ... }:

{
# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
    # Common cli tools
    vim
    fzf
    # Nice to have
    htop
    gdu
    duf
    bat
    eza
    ripgrep
    parallel
    tldr
    # Theme for shell
    oh-my-posh
    # wireguard libs
    wireguard-tools
  ];
}
