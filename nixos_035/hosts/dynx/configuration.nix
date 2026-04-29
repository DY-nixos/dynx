{ config, pkgs, ... }:

{
  imports = [
    ../common/base.nix
    ../common/boot.nix
    ../common/desktop.nix
    ../common/users.nix
    ./hardware.nix
  ];

  networking.hostName = "dynx";

}