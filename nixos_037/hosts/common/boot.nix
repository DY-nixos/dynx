{ config, pkgs, ... }: {

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader = {
    grub = {
      enable = true;
      extraEntries = ''
        menuentry "Windows" {
            search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
            chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };

  boot.supportedFilesystems = [ "ntfs" "exfat" "vfat" "ext4" ];
  boot.loader.timeout = -1;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = false;
}