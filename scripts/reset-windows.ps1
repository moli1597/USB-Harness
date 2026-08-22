# =============================================================================
# reset-windows.ps1 — 重置 USB Harness
# 默认（软重置）：只清空用户数据（data/dsh），保留运行环境（.cache 里的便携
#   Node + dsh 依赖 + 离线安装包），重置后无需联网下载，直接重新启动即可。
# -Full（完全重置）：连 .cache 运行环境一起删除（需重新下载，会优先用离线包）。
# 用法：powershell -ExecutionPolicy Bypass -File .\scripts\reset-windows.ps1 [-Full]
# =============================================================================
[CmdletBinding()]
param(
    [string]$Root = (Split-Path -Parent $PSScriptRoot),
    [switch]$Full
)

$ErrorActionPreference = 'Stop'
$DataDir  = Join-Path $Root 'data\dsh'
$CacheDir = Join-Path $Root '.cache'
$ReadyFlag = Join-Path $Root '.ready.flag'

Write-Host ''
Write-Host '============================================' -ForegroundColor Yellow
Write-Host '   USB Harness 重置' -ForegroundColor Yellow
Write-Host '============================================' -ForegroundColor Yellow

if ($Full) {
    Write-Host '完全重置 —— 将删除：'
    Write-Host "  - $CacheDir（便携 Node 与 dsh 依赖，需重新下载；会优先用离线包）"
    Write-Host "  - $DataDir（配置、密钥、会话记录）"
    Write-Host "  - $ReadyFlag"
} else {
    Write-Host '软重置（保留运行环境，无需联网下载）—— 将删除：'
    Write-Host "  - $DataDir（配置、密钥、会话记录）"
    Write-Host "  - $ReadyFlag"
    Write-Host ''
    Write-Host '保留：'
    Write-Host "  - $CacheDir（便携 Node + dsh 运行环境 + 离线安装包）"
    Write-Host '  - brand-patch / config / docs / scripts / launch.bat'
}
Write-Host ''

$ans = Read-Host '确认重置？输入 yes 继续'
if ($ans -ne 'yes') { Write-Host '已取消。'; exit 0 }

if ($Full -and (Test-Path $CacheDir)) {
    Remove-Item -Path $CacheDir -Recurse -Force
    Write-Host "  已删除: $CacheDir"
}
if (Test-Path $DataDir) {
    Remove-Item -Path $DataDir -Recurse -Force
    Write-Host "  已删除: $DataDir"
}
if (Test-Path $ReadyFlag) {
    Remove-Item -Path $ReadyFlag -Force
    Write-Host "  已删除: $ReadyFlag"
}
# 重建空数据目录，便于首次启动
New-Item -ItemType Directory -Force -Path $DataDir | Out-Null

Write-Host ''
if ($Full) {
    Write-Host '完全重置完成。重新启动时将重新安装（优先使用 U 盘离线包）。' -ForegroundColor Green
} else {
    Write-Host '软重置完成。运行环境已保留，直接重新启动即可（无需联网下载）。' -ForegroundColor Green
}
Write-Host ''
