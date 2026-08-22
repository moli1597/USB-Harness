#!/usr/bin/env bash
# =============================================================================
# reset-unix.sh — 重置 USB Harness
# 默认（软重置）：只清空用户数据（data/dsh），保留运行环境（.cache 里的便携
#   Node + dsh 依赖 + 离线安装包），重置后无需联网下载，直接重新启动即可。
# --full（完全重置）：连 .cache 运行环境一起删除（需重新下载，会优先用离线包）。
# 用法：bash scripts/reset-unix.sh [--full]
# =============================================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FULL=0
[ "${1:-}" = "--full" ] && FULL=1

DATA_DIR="$ROOT/data/dsh"
CACHE_DIR="$ROOT/.cache"
READY_FLAG="$ROOT/.ready.flag"

echo ""
echo "============================================"
echo "   USB Harness 重置"
echo "============================================"

if [ "$FULL" = "1" ]; then
  echo "完全重置 —— 将删除："
  echo "  - $CACHE_DIR（便携 Node 与 dsh 依赖，需重新下载；会优先用离线包）"
  echo "  - $DATA_DIR（配置、密钥、会话记录）"
  echo "  - $READY_FLAG"
else
  echo "软重置（保留运行环境，无需联网下载）—— 将删除："
  echo "  - $DATA_DIR（配置、密钥、会话记录）"
  echo "  - $READY_FLAG"
  echo ""
  echo "保留："
  echo "  - $CACHE_DIR（便携 Node + dsh 运行环境 + 离线安装包）"
  echo "  - brand-patch / config / docs / scripts / launch.sh"
fi
echo ""

read -r -p "确认重置？输入 yes 继续 " ans
if [ "$ans" != "yes" ]; then
  echo "已取消。"
  exit 0
fi

if [ "$FULL" = "1" ] && [ -e "$CACHE_DIR" ]; then
  rm -rf "$CACHE_DIR"
  echo "  已删除: $CACHE_DIR"
fi
if [ -e "$DATA_DIR" ]; then
  rm -rf "$DATA_DIR"
  echo "  已删除: $DATA_DIR"
fi
if [ -e "$READY_FLAG" ]; then
  rm -f "$READY_FLAG"
  echo "  已删除: $READY_FLAG"
fi
mkdir -p "$DATA_DIR"

echo ""
if [ "$FULL" = "1" ]; then
  echo "完全重置完成。重新启动时将重新安装（优先使用 U 盘离线包）。"
else
  echo "软重置完成。运行环境已保留，直接重新启动即可（无需联网下载）。"
fi
echo ""
