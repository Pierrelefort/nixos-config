{ pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Git cli tools
    lazygit
  ];
}
