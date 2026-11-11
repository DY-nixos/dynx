{ config, pkgs, ... }:

{
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
    ];
  };

  programs.xfconf.enable = true;

  environment.systemPackages = with pkgs; [
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    xfce4-terminal   # 或换成你用的终端
  ];

  # 系统级 Thunar 自定义动作：右键“Open Terminal Here”
  environment.etc."xdg/Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
      <action>
        <icon>utilities-terminal</icon>
        <name>Open Terminal Here</name>
        <unique-id>open-terminal-here-1</unique-id>
        <command>xfce4-terminal --working-directory=%f</command>
        <description>Open Terminal Here</description>
        <range></range>
        <patterns>*</patterns>
        <startup-notify/>
        <directories/>
      </action>
    </actions>
  '';
}