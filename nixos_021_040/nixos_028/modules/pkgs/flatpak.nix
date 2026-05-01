{ pkgs, ... }:

{
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    flatpak
    gnome-software
  ];

  systemd.services.configure-flatpak-repo = {
    description = "Configure Flatpak Domestic Mirrors";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://mirror.sjtu.edu.cn/flathub/flathub.flatpakrepo
      flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub/
      flatpak update --appstream
    '';
  };

  fonts.fontconfig.enable = true;
}