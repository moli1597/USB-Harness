#!/usr/bin/env bash
# =============================================================================
# launch.sh — USB Harness 启动器（Linux/macOS）
# 职责：环境校验 → 首启自动安装 → 交互菜单（启动/配置/重置/状态/退出）
# 用法：bash launch.sh [web|setup|reset|status]
# =============================================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ACTION="${1:-}"

# 平台/架构
case "$(uname -s)" in
  Linux)  OS="linux" ;;
  Darwin) OS="darwin" ;;
  *)      echo "不支持的平台: $(uname -s)" >&2; exit 1 ;;
esac
case "$(uname -m)" in
  x86_64|amd64) ARCH="x64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *)            echo "不支持的架构: $(uname -m)" >&2; exit 1 ;;
esac
PLATFORM="${OS}-${ARCH}"

NODE_DIR="$ROOT/.cache/runtimes/${PLATFORM}/node"
NODE_BIN="$NODE_DIR/bin/node"
DSH_BIN="$ROOT/.cache/app/node_modules/.bin/dsh"
DSH_HOME_DIR="$ROOT/data/dsh"
LOG_DIR="$ROOT/data/logs"
LOG_FILE="$LOG_DIR/dsh-web.log"

mkdir -p "$DSH_HOME_DIR" "$LOG_DIR"

echo ""
echo "============================================"
echo "   USB Harness — 便携式 AI 助手"
echo "============================================"

# 环境就绪校验
ready() { [ -x "$NODE_BIN" ] && [ -x "$DSH_BIN" ]; }

do_setup() {
  bash "$ROOT/scripts/setup-unix.sh"
}

# 显示状态
show_status() {
  echo ""
  echo "--------------------------------------------"
  echo "  USB Harness 状态"
  echo "--------------------------------------------"
  if ready; then
    echo "  便携 Node : $("$NODE_BIN" -v)"
    echo "  dsh 版本  : $("$DSH_BIN" --version 2>/dev/null || echo '未知')"
    echo "  数据目录  : $DSH_HOME_DIR"
    echo "  监听地址  : http://0.0.0.0:3080（本机 + 局域网）"
  else
    echo "  环境      : 未安装（首次使用需联网下载）"
  fi
  echo "--------------------------------------------"
  echo ""
}

# 启动 Web 界面
start_web() {
  PORT="${PORT:-3080}"
  export DSH_HOME="$DSH_HOME_DIR"
  export PATH="$NODE_DIR/bin:$ROOT/.cache/app/node_modules/.bin:$PATH"
  echo ""
  echo "  本机访问:   http://127.0.0.1:$PORT"
  echo "  局域网访问: http://<本机IP>:$PORT"
  echo "  按 Ctrl+C 停止服务"
  echo ""
  exec "$DSH_BIN" web --port "$PORT" --host 0.0.0.0 2>&1 | tee -a "$LOG_FILE"
}

# 重置
do_reset() {
  bash "$ROOT/scripts/reset-unix.sh"
}

# 首启自动安装
if ! ready; then
  echo "[警告] 未检测到运行环境，首次使用需要联网下载便携 Node 与 dsh（约 3-8 分钟）。"
  read -r -p "是否现在安装？[Y/N] " ans
  if [[ "$ans" =~ ^[Yy] ]]; then
    do_setup
  else
    echo "已取消安装。"
    exit 0
  fi
fi

# 命令行动作直通
case "$ACTION" in
  web)    start_web; exit 0 ;;
  setup)  do_setup; exit 0 ;;
  reset)  do_reset; exit 0 ;;
  status) show_status; exit 0 ;;
esac

# 交互菜单
while true; do
  show_status
  echo "  [1] 启动 Web 界面"
  echo "  [2] 重置（清配置数据，保留运行环境，无需下载）"
  echo "  [3] 退出"
  echo ""
  read -r -p "  请选择 " choice
  case "$choice" in
    1) start_web ;;
    2) do_reset ;;
    3) exit 0 ;;
    *) echo "[警告] 无效选择：$choice" ;;
  esac
done
