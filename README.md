# USB Harness

> **deepseek-harness 的便携式变体（variant）**——把 [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness)
> 的全部能力装进一个 **即插即用的 U 盘包**：免安装、零宿主机污染、数据随盘、
> 适配中国网络、支持自定义 OpenAI 兼容网关。

---

## 🚀 下载（推荐：下载即用）

**完整包已含运行时（便携 Node + dsh 依赖 + 离线安装包），解压即可使用，无需联网安装：**

> ## 👉 [前往 Releases 页下载最新完整包](https://github.com/tmy2623231/USB-Harness/releases/latest)

| 方式 | 说明 |
|------|------|
| **Releases 完整包**（推荐） | 下载 `USB-Harness-with-runtime.zip`（约 137MB）→ 解压 → 双击 `launch.bat` → 直接用 |
| 源码 ZIP / git clone | 仅源码（不含运行时），首次启动需联网安装一次（走中国镜像 + 离线包） |

**完整包使用步骤**：

1. 在 [Releases 页](https://github.com/tmy2623231/USB-Harness/releases/latest) 下载 `USB-Harness-with-runtime.zip`
2. 解压到 U 盘（建议 NTFS 或 exFAT、≥4GB 空间）
3. Windows 双击 **`launch.bat`**；Linux/macOS 执行 **`bash launch.sh`**
4. 浏览器自动打开 `http://127.0.0.1:3080`，在「设置 → 模型」配置自定义 OpenAI 兼容网关即可使用

---

## 这是什么

USB Harness 是 **[deepseek-harness](https://github.com/deepseek-ai/deepseek-harness) 的深度定制变体**，
保留了原版的核心 AI 能力（Web UI、实时对话、流式输出、模型加载、工具/插件、MCP、
权限模式等），在此基础上做了面向「便携 + 国内网络 + 白标」的改造：

| 层 | 来源 | 说明 |
|----|------|------|
| **AI 核心** | deepseek-harness（`@deepseek-ai/dsh`） | Web 界面、对话、流式输出、模型、工具/插件、权限体系——**100% 保留原版能力** |
| **便携外壳** | 本项目自研 | 便携 Node 运行时、数据随盘、免安装启动框架（交互菜单） |
| **品牌改造** | 本项目 `brand-patch/` | 去 DeepSeek 品牌标识，白标为「USB Harness」 |
| **网络适配** | 本项目自研 | 中国镜像（npmmirror）+ U 盘离线安装包，尽量少联网 |

> 核心 dsh 来自 deepseek-harness 官方预编译包（未裁剪），本项目的改造集中在
> 「便携化外壳」与「品牌/本地化」两层。**许可与 deepseek-harness 一致（MIT）**，详见 [LICENSE](LICENSE)。

## 特性

- ✅ **100% dsh 能力**：Web UI、实时对话、流式输出、模型加载、headless、工具/插件、MCP、权限模式
- ✅ **免安装便携**：便携 Node.js + 预置依赖，宿主机无需 Node/npm/Python
- ✅ **跨平台**：Windows（`launch.bat`）+ Linux/macOS（`launch.sh`），一套目录双端运行
- ✅ **交互式启动器**：中文菜单（启动 / 重置 / 退出），首启自动安装
- ✅ **数据随盘**：`DSH_HOME` 重定向到 `data/dsh/`，密钥/配置/会话全部留在 U 盘
- ✅ **零宿主机污染**：不写注册表、不改系统环境变量
- ✅ **中国网络适配**：Node 下载优先 npmmirror 镜像、npm 用 `registry.npmmirror.com`，失败自动回退官方源
- ✅ **U 盘离线安装包**：`.cache/downloads/` 内置 Node 安装包，重装不依赖网络
- ✅ **软重置**：清配置数据但保留运行环境，重置后无需重新下载
- ✅ **默认监听 0.0.0.0:3080**：本机 + 局域网可访问；端口占用自动顺延
- ✅ **exFAT 友好**：核心用 npm 扁平安装（无符号链接），规避 exFAT 限制

## 快速开始

### 1. 拷贝到 U 盘

**方式一（推荐）**：从 [Releases 页](https://github.com/tmy2623231/USB-Harness/releases/latest) 下载
`USB-Harness-with-runtime.zip` 完整包（含运行时），解压后拷贝到 U 盘即可，**无需联网安装**。

**方式二（源码）**：用「Code → Download ZIP」下载源码（或 `git clone`），把整个目录复制到 U 盘
（建议 NTFS 或 exFAT、USB 3.0+、≥4GB 空间）。源码不含运行时，首次启动会提示联网安装一次。

> **说明**：GitHub 下载的 ZIP 解压后文件夹名是 `USB-Harness-main`（GitHub 的
> `仓库名-分支名` 固定命名，属正常现象），把它重命名为 `USB-Harness` 即可，不改也不影响使用。

### 2. 启动

**Windows**：双击 **`launch.bat`**。
**Linux/macOS**：`bash launch.sh`。

首次运行会自动检测并安装运行环境（优先使用 U 盘离线包 + 中国镜像）。
启动菜单：

```
[1] 启动 Web 界面
[2] 重置（清配置数据，保留运行环境，无需下载）
[3] 退出
```

默认监听 `http://0.0.0.0:3080`（本机 `http://127.0.0.1:3080`，局域网 `http://<本机IP>:3080`）。

### 3. 配置模型（进入 Web UI 后）

**设置 → 模型 → 添加自定义提供方**，填入：

- **API 地址**：OpenAI 兼容网关地址，如阿里云百炼 `https://bi.tianmaoyi.cn:4443/v1`、本地 Ollama `http://127.0.0.1:11434/v1`
- **API 密钥**：网关提供的密钥
- **模型目录**：点击「获取可用模型」自动拉取，或手动添加模型 ID

保存后在对话页右上角选择模型即可开始使用。全新安装时欢迎页点「继续」会**直接弹出添加自定义模型表单**。

### 4. 选择工作区

会话基于工作区（项目目录）运行，在 Web 界面中自行选择。会话中读写文件、执行命令都以所选工作区为根。

## 目录结构

```
USB-Harness/
├── launch.bat / launch.sh     # 一键启动入口（交互菜单，首启自动安装）
├── scripts/
│   ├── launch-windows.ps1     # Windows 启动器（中文菜单）
│   ├── setup-windows.ps1      # Windows 首次配置（下载/离线 Node + 安装 dsh + 品牌补丁）
│   ├── setup-unix.sh          # Linux/macOS 首次配置
│   ├── reset-windows.ps1      # Windows 重置（软重置/完全重置 -Full）
│   ├── reset-unix.sh          # Linux/macOS 重置
│   └── COMMANDS.md            # 命令速查
├── brand-patch/               # 品牌补丁（去 DeepSeek 化 + 中文本地化，安装时自动应用）
├── config/
│   └── settings.example.yaml  # 模型配置参考模板
├── docs/
│   ├── ARCHITECTURE.md        # 整合架构与关键决策
│   ├── DEPLOYMENT.md          # 部署指南（U 盘格式/权限/端口/长路径/杀软）
│   ├── COMPATIBILITY.md       # 兼容性矩阵与已验证项
│   └── TROUBLESHOOTING.md     # 故障排查
├── .cache/                    # 便携运行时与依赖（随盘携带，不入 git）
│   ├── runtimes/windows-x64/node/  # 便携 Node.js
│   ├── app/node_modules/           # @deepseek-ai/dsh 及其依赖
│   └── downloads/                  # 离线安装包（无需联网即可装 Node）
├── data/                       # 运行期数据（DSH_HOME，含配置/密钥/会话，不入 git）
│   ├── dsh/
│   └── logs/
└── work/                       # （可选）默认工作目录，项目文件放这里（不入 git）
```

## 品牌改造（brand-patch）

本项目通过 `brand-patch/` 对 dsh 做了**去 DeepSeek 品牌化 + 中文本地化**改造，安装时自动应用：

- 品牌标识、产品名、欢迎文案改为「USB Harness」（保留"欢迎使用"简短简介）
- 「预览版/测试阶段」等字样移除
- 默认移除官方 DeepSeek 适配器（`llm-deepseek` 禁用），模型配置仅保留自定义 OpenAI 兼容网关
- 权限模式等界面文案中文化（只读 / 工作区可写 / 完全访问）
- 升级 dsh 后 `launch.bat setup` 会自动重新应用补丁

## 中国网络 / 离线安装

- **默认已适配中国网络**：Node 下载优先 `npmmirror.com/mirrors/node/`，npm 用 `registry.npmmirror.com`，失败自动回退官方源
- **U 盘预置离线包**：`install` 会优先使用 `.cache/downloads/` 里的 Node 安装包，无需联网即可安装 Node
- **重置不删运行环境**：软重置只清配置数据，`.cache`（Node + dsh + 离线包）原样保留

## 版本锁定

| 组件 | 版本 | 说明 |
|------|------|------|
| `@deepseek-ai/dsh` | `0.1.1-rc.1` | 预发布候选版（rc），官方声明会有破坏性变更 |
| 便携 Node.js | `22.23.2` (LTS Jod) | 满足 dsh `^22.19.0 \|\| >=24.0.0`（23 不支持） |

> 版本号可在 `scripts/setup-windows.ps1` 顶部修改。

## 安全须知

- API 密钥明文存放于 `data/dsh/.credentials.yaml`，**U 盘丢失即泄露**。务必用 BitLocker / VeraCrypt 加密 U 盘
- 默认监听 `0.0.0.0`（局域网可访问）。**不要对公网开放**——Web UI 可执行命令、读写文件、管理凭据
- 该文件已被 `.gitignore` 排除，切勿提交到任何仓库

## 文档

| 文档 | 内容 |
|------|------|
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | 整合架构与关键决策 |
| [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md) | 部署指南（U 盘格式/权限/端口/长路径/杀软） |
| [docs/COMPATIBILITY.md](docs/COMPATIBILITY.md) | 兼容性矩阵与已验证项 |
| [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) | 故障排查 |

## License

本项目为 deepseek-harness 的派生变体，遵循 **MIT License**（与上游 [deepseek-harness](https://github.com/deepseek-ai/deepseek-harness)
一致）。上游版权归 DeepSeek AI 所有，本项目的便携外壳与品牌改造部分见 [LICENSE](LICENSE)。
第三方依赖许可证见上游 `THIRD_PARTY_NOTICES.md`。

## 致谢

- [deepseek-harness](https://github.com/deepseek-ai/deepseek-harness) — 核心 AI 能力与许可基础
