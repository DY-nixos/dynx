{ pkgs, ... }:

# Blender 只用官网预编译包, 不锁版本、始终跟最新的稳定版走。(当前: 5.3.0)
#
# 为什么不用 nixpkgs 里的 blender:
# 1. nixpkgs 的 blender 是源码编译的, 改版本号会触发本地编译(几小时), 没法锁版本。
# 2. 更关键: nixpkgs 构建把 OpenImageIO 的 Python 绑定剔掉了, 而 MACHIN3tools
#    之类的插件顶层就 import OpenImageIO, 会导致插件装不上。官方包自带绑定。
#
# 升级版本: 从 https://download.blender.org/release/ 下载 blender-<版本>-linux-x64.tar.xz,
#   放进 modules/apps/files/, 然后改下面 version 一行即可, 无需联网、无需算 hash。
#   首次要把新包 git add 进索引, Nix 才看得见。
#
# 插件不归 Nix 管: 本模块只装 Blender 本体, 所有插件由 Blender 自己管理 ——
#   偏好设置 > 扩展 > 右上角下拉 > Install from Disk, 选 zip 即可
#   (装进 ~/.config/blender/<版本>/extensions/user_default/, 不需要 rebuild)。
# 极少数老式插件需要放进 ~/.config/blender/<版本>/scripts/addons/ 才能加载
#   (例如 MACHIN3tools: 它有 `from . import bl_info`, 被当作 extension 加载会失败)。
let
  inherit (pkgs)
    lib
    stdenv
    stdenvNoCC
    makeWrapper
    patchelf
    addDriverRunpath
    file
    libx11
    libxrender
    libxfixes
    libxi
    libxext
    libxxf86vm
    libxcursor
    libxinerama
    libxrandr
    libxdamage
    libxcomposite
    libsm
    libice
    libGL
    vulkan-loader
    libxkbcommon
    alsa-lib
    pipewire
    pulseaudio
    ;

  version = "5.3.0";

  dynamicLinker = stdenv.cc.bintools.dynamicLinker;

  # 官方包是给通用 Linux 编译的, 依赖的 X11/GL/vulkan 库得手动指过去
  glibc = lib.makeLibraryPath [
    libx11
    libxrender
    libxfixes
    libxi
    libxext
    libxxf86vm
    libxcursor
    libxinerama
    libxrandr
    libxdamage
    libxcomposite
    libsm
    libice
    libGL
    vulkan-loader
    libxkbcommon
    stdenv.cc.cc
    alsa-lib
    pipewire
    pulseaudio
  ];
  blender = stdenvNoCC.mkDerivation {
    pname = "blender";
    inherit version;

    # 直接引用 /home/dy/ 下手动下载的官方包, 不再从 download.blender.org 拉:
    # 省掉每次构建的下载/超时, 版本也完全可控。
    # 升级时: 把新包放到 /home/dy/, 改 version 和下面文件名即可。
    # 注意: 这里必须用绝对路径引用 —— /home/dy 下文件名不含中文, 不会触发
    #       Nix 对非 ASCII 路径的 URL 编码问题 (file:///home/dy/下载/... 会失败)。
    src = /home/dy/blender-${version}-linux-x64.tar.xz;

    sourceRoot = "blender-${version}-linux-x64";
    nativeBuildInputs = [ makeWrapper patchelf addDriverRunpath file ];
    dontBuild = true;

    # 官方包里不止 blender 一个可执行文件: 还有 <版本>/python/bin/python3.x 等。
    # Blender 安装扩展时会去调用它, 解释器不对就会报
    #   "Could not start dynamically linked executable: .../python3.13"
    # 所以把所有 ELF 可执行文件都 patch 一遍, 不能只处理 $out/blender。
    # stdenv 在 install 之后、wrap 之前自动跑 preFixup hook, 此时 $out 已完整。
    preFixup = ''
      patchElf() {
        while read -r f; do
          if file -b "$f" | grep -q '^ELF'; then
            patchelf --set-interpreter ${dynamicLinker} "$f" 2>/dev/null || true
          fi
        done
      }
      find $out -type f -perm -u+x | patchElf
    '';

    installPhase = ''
      runHook preInstall

      # 目录结构必须原样保留: blender 靠 /proc/self/exe 找同级的 lib/ 和 <版本>/ 目录
      mkdir -p $out/bin
      cp -a ./. $out/
      rm -f $out/blender-launcher $out/blender-thumbnailer $out/blender-softwaregl

      install -Dm644 $out/blender.desktop $out/share/applications/blender.desktop
      install -Dm644 $out/blender.svg $out/share/icons/hicolor/scalable/apps/blender.svg
      install -Dm644 $out/blender-symbolic.svg $out/share/icons/hicolor/scalable/apps/blender-symbolic.svg
      rm -f $out/blender.desktop $out/blender.svg $out/blender-symbolic.svg

      # 官方包的 ELF 解释器指向 /lib64/ld-linux-x86-64.so.2, NixOS 上不存在。
      # 逐个 patch 见上面的 patchElvesPhase (含 5.3/python/bin/python3.13)。

      makeWrapper $out/blender $out/bin/blender \
        --prefix LD_LIBRARY_PATH : ${glibc}

      runHook postInstall
    '';

    meta = {
      description = "3D Creation/Animation/Publishing System (官方预编译包, 版本锁定)";
      homepage = "https://www.blender.org";
      license = lib.licenses.gpl2Plus;
      platforms = [ "x86_64-linux" ];
      mainProgram = "blender";
    };
  };
in
{
  environment.systemPackages = [ blender ];
}
