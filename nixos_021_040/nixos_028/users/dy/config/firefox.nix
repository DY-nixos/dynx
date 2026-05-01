{ config, pkgs, ... }: {

  programs.firefox.profiles.default = {
    id = 0;
    name = "default";
    isDefault = true;
    path = "default";  # 强制对齐 profiles.ini
    settings = {
      "browser.download.useDownloadDir" = false;
      "browser.shell.checkDefaultBrowser" = false;
      "extensions.activeTypesInternal2" = "extension";
      "browser.aboutConfig.showWarning" = false;
    };
  };
}