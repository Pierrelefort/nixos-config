{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc  # Required by Treesitter Nvim
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
