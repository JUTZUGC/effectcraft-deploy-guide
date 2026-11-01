#!/usr/bin/env bash
set -euo pipefail
# EffectCraft 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/storytold/effectcraft#readme
# 更新日期：2026-11-01
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

curl -fL -o effectcraft.AppImage https://github.com/storytold/effectcraft/releases/download/v0.19.0/effectcraft-0.19.0-linux-x86_64.AppImage
echo "9c8b8c5b33f1f04240deaebc854cc53b997cda48cf29ecd7173b43c98049f0c1  effectcraft.AppImage" | sha256sum -c -
chmod +x effectcraft.AppImage
echo "安装完成：运行 ./effectcraft.AppImage，新建合成加一个特效试渲染"

echo ""

echo "下载与校验完成，安装包在 .download 目录"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/storytold/effectcraft#readme"
