{ config, pkgs, ... }: {

  programs.fish = {
    enable = true;
    shellInit = ''
      set -g fish_greeting ""
      # GITHUB_TOKEN_FILE 由 sops.nix 通过 home.sessionVariables 提供
      if test -r "$GITHUB_TOKEN_FILE"
        set -gx GITHUB_TOKEN (cat "$GITHUB_TOKEN_FILE")
      end
    '';
    interactiveShellInit = "fastfetch";
    shellAliases = { ll = "ls -l"; };
  };

}