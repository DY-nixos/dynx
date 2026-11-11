{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    nodejs_24
  ];
  programs.dsh = {
    enable = true;
    desktop.enable = true;
  };

  nix.settings = {
    extra-substituters = [ "https://deepseek-harness-nix.cachix.org" ];
    trusted-public-keys = [
      "deepseek-harness-nix.cachix.org-1:5NrkwLN9veNMhiINtU5ZeV4isXFhFsOwn6Ms7J1M+TA="
    ];
  };
}
