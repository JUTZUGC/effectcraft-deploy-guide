# EffectCraft 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/storytold/effectcraft#readme
# 更新日期：2026-11-01
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -fL -o effectcraft.msi https://github.com/storytold/effectcraft/releases/download/v0.19.0/effectcraft-0.19.0-windows-x64.msi
$h=(Get-FileHash .\effectcraft.msi -Algorithm SHA256).Hash.ToLower()
if ($h -ne "d6cff47ec0df9731343b9c749537e87425921034259fd91a74f3ad976b10c910") { throw "SHA256 校验失败" }
Start-Process msiexec.exe -ArgumentList '/i', "$PWD\effectcraft.msi" -Wait
Write-Host "安装完成：从开始菜单打开 EffectCraft，新建合成试渲染"

Write-Host ''

Write-Host '下载与校验完成，安装包在 .download 目录'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/storytold/effectcraft#readme'
