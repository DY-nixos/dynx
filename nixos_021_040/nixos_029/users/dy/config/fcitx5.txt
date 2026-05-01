{ config, pkgs, lib, ... }:

let
  rimeDir = "${config.home.homeDirectory}/.local/share/fcitx5/rime";
in {
  home.activation.removeFcitx5Dir = lib.hm.dag.entryBefore ["writeBoundary"] ''
    rm -rf $HOME/.config/fcitx5
  '';

  home.activation.setupRime = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p "${rimeDir}"
    $DRY_RUN_CMD cat > "${rimeDir}/default.custom.yaml" <<EOF
patch:
  schema_list:
    - schema: double_pinyin_flypy
EOF
    $DRY_RUN_CMD rm -rf "${rimeDir}/build/"
  '';
}
