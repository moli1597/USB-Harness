# USB Harness — 命令速查

> 所有脚本都在 `scripts/` 目录；入口是根目录的 `launch.bat`（Windows）与 `launch.sh`（Linux/macOS）。

## 日常使用

| 操作 | 命令 |
|------|------|
| 启动（交互菜单） | 双击 `launch.bat` / `bash launch.sh` |
| 直接启动 Web | `launch.bat web` / `bash launch.sh web` |
| 查看状态 | `launch.bat status` / `bash launch.sh status` |
| 重新配置 / 重装 | `launch.bat setup` / `bash launch.sh setup` |
| 重置（清数据，保留运行环境） | `launch.bat reset` / `bash launch.sh reset` |
| 完全重置（连环境一起删） | `.\scripts\reset-windows.ps1 -Full` / `bash scripts/reset-unix.sh --full` |

## 重置说明（重要）

- **软重置（默认）**：只清空 `data/dsh/`（配置、密钥、会话），**保留 `.cache/` 运行环境**
  （便携 Node + dsh 依赖 + 离线安装包）。重置后**无需联网下载**，直接重新启动即可，
  只是回到「未配置模型」的全新状态。
- **完全重置（`-Full` / `--full`）**：连 `.cache/` 一起删，重新安装（会优先用 U 盘离线包，
  尽量少下载）。

## 中国网络 / 离线安装

- **默认已适配中国网络**：Node 下载优先 npmmirror 镜像、npm 用 `registry.npmmirror.com`，
  失败自动回退官方源（nodejs.org / npmjs.org）。
- **U 盘预置离线包**：`install` 会优先使用 `.cache/downloads/` 里的 Node 安装包
  （`node-v22.23.2-win-x64.zip`），无需联网即可装 Node。
- **已装好就直接用**：`.cache/`（便携 Node + dsh 依赖）已随 U 盘携带，
  插入电脑双击 `launch.bat` 即可用，**无需重新安装**。

## 手动配置（首次安装）

```powershell
# Windows
powershell -ExecutionPolicy Bypass -File .\scripts\setup-windows.ps1
```

```bash
# Linux/macOS
bash scripts/setup-unix.sh
```

## 目录结构

```
USB-Harness/
├── launch.bat / launch.sh     # 一键启动入口
├── scripts/                   # 启动器 / 安装 / 重置脚本
│   ├── launch-windows.ps1     # Windows 交互菜单
│   ├── setup-windows.ps1      # Windows 首次配置
│   ├── setup-unix.sh          # Linux/macOS 首次配置
│   ├── reset-windows.ps1      # Windows 重置
│   └── reset-unix.sh          # Linux/macOS 重置
├── brand-patch/               # 品牌补丁（去 DeepSeek 化，安装时自动应用）
├── config/settings.example.yaml
├── docs/                      # 文档
├── .cache/                    # 便携 Node + dsh（安装时生成）
└── data/dsh/                  # 配置 / 密钥 / 会话（DSH_HOME）
```

## 模型配置（进入 Web 界面后）

**设置 → 模型** → 添加「自定义 OpenAI 兼容网关」，填写：

- **baseURL**：如 `https://bi.tianmaoyi.cn:4443/v1`（阿里云百炼）、`http://127.0.0.1:11434/v1`（本地 Ollama）
- **API Key**：网关提供的密钥
- **模型列表**：网关支持的模型 id（如 `qwen3.8-max`）

保存后即生效；在对话页右上角模型选择器里选定模型即可开始使用。

## 工作区

- 工作区由用户在 Web 界面中自行选择（新建会话时选择目录）。
- 会话中读写文件、运行命令都基于所选工作区目录。

## 升级 dsh

删除 `.cache/app` 后重新运行配置脚本（`launch.bat setup`），品牌补丁会自动重新应用。

## 常见问题

- 端口 3080 被占用：启动时自动顺延；也可用环境变量 `PORT=3090 bash launch.sh`。
- 默认监听 `0.0.0.0`（局域网可访问）。**不要对公网开放**。
- 仅本机访问：`bash launch.sh` 后用 `--host 127.0.0.1`（Windows 见 start 逻辑说明）。
