{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-autocomplete
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

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
  };

  
  # Completing for system packages
  environment.pathsToLink = [ "/share/zsh" ];
}
