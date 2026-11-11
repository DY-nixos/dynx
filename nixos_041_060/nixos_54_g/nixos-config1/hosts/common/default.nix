{ config, pkgs, ... }: {

  # --- Nix 配置 ---
  nix.settings = {
    trusted-users = [ "root" "dy" ];
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    download-buffer-size = 134217728;
  };

  time.timeZone = "Asia/Shanghai";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";

  # --- 引导（UEFI + GPT）---
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.supportedFilesystems = [ "ntfs" "exfat" "vfat" "ext4" ];
  boot.loader.timeout = -1;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";  # 如你的 ESP 不在 /boot，请改成实际挂载点
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";           # UEFI 下 GRUB 不装到磁盘 MBR
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = false;

  #开机启动日志
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];

  boot.loader.grub.configurationLimit = 10;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;


  # --- 蓝牙 ---
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # --- 桌面音频 ---
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- 用户 ---
  users.users.dy = {
    isNormalUser = true;
    description = "dy";
    extraGroups = [
      "networkmanager" "wheel" "libvirtd" "kvm"
      "storage" "disk" "video"
      "docker" "render" "bluetooth"
    ];
  };
}