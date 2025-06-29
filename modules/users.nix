{ pkgs, ... }:

{
  users.defaultUserShell=pkgs.zsh;

  users.users.plefort = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Pierre Lefort";
    extraGroups = [ "networkmanager" "wheel" ];
    # packages = with pkgs; [
    #   qutebrowser
    #   bitwarden
    # ];
  };
}
