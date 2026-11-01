# EffectCraft 一键安装指南

> 第三方部署指南 · 非 EffectCraft 官方仓库。官方项目：[storytold/effectcraft](https://github.com/storytold/effectcraft)
> 内容来自官方文档（2026-11-01）。项目迭代快，请以[官方文档](https://github.com/storytold/effectcraft#readme)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 动效软件最贵的是订阅费：同样的合成、关键帧与特效链，这里离线跑在自己机器上。

⚠️ 官方把状态标为「young and moving fast」，功能补齐得快但仍在变化。Windows、macOS、Linux 有安装包，浏览器版也能用。渲染吃 CPU 与显存，长合成与高分辨率导出耗时明显。它不替代剪辑软件的音频与多轨能力，复杂工程建议先小样验证。安装包未签名时系统会拦一次。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/effectcraft-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按系统下载安装包并比对 SHA256，装完新建合成加一个特效试渲染，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## EffectCraft 是什么？

EffectCraft 是开源的合成、图层、关键帧、308 个特效、图层样式、表达式、3D 相机与灯光、渲染队列，做进一个原生应用（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/storytold/effectcraft?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

动效与视觉合成：合成与图层、关键帧与曲线、308 个内置特效、图层样式、表达式、3D 相机与灯光、渲染队列，原生运行并支持浏览器版。

- 特效多：308 个内置效果开箱可用
- 表达式：能写脚本驱动参数
- 3D 空间：相机与灯光做伪三维
- 渲染队列：批量排队导出
- 原生 Rust：不吃 Electron 那套开销
- Apache-2.0，可商用可二开

（来源：[官方仓库](https://github.com/storytold/effectcraft)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 8.3k stars 10 月新项目 | 名称搜索 96 条结果 |
| 308 个内置特效 | 覆盖面广 |
| 支持表达式与 3D 相机灯光 | — |
| 原生 Rust | 启动快 |
| 三平台安装包 + 浏览器版 | — |
| Apache-2.0 | 可商用可二开 |

| 需要注意 | 说明 |
|---|---|
| 官方标注仍在快速变化 | — |
| 不含音频编辑与多轨剪辑 | — |
| 长合成渲染耗时 | — |
| 第三方插件生态尚未形成 | — |
| 复杂工程的兼容性待验证 | — |

> 以上基于官方文档与社区反馈整理（2026-11-01），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
curl -fL -o effectcraft.AppImage https://github.com/storytold/effectcraft/releases/download/v0.19.0/effectcraft-0.19.0-linux-x86_64.AppImage
echo "9c8b8c5b33f1f04240deaebc854cc53b997cda48cf29ecd7173b43c98049f0c1  effectcraft.AppImage" | sha256sum -c -
chmod +x effectcraft.AppImage
echo "安装完成：运行 ./effectcraft.AppImage，新建合成加一个特效试渲染"
```

安装包来源：[https://github.com/storytold/effectcraft/releases/latest](https://github.com/storytold/effectcraft/releases/latest)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认 308 个特效、3D 相机灯光与渲染队列 | 已核对 2026-11-01 |
| Release v0.19.0 的 SHA256SUMS.txt 已下载核对（Windows 与 Linux） | 已核对 2026-11-01 |
| 未实测安装与渲染 | 说明 2026-11-01 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-01 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-01 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不含 MCP；本仓库的 MCP 只提供安装步骤、渲染注意与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-01）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\effectcraft-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 能做什么

| 能力 | 说明 |
|---|---|
| 合成与图层 | 多层叠加，混合模式与蒙版 |
| 关键帧 | 位置、缩放、旋转、不透明度与曲线 |
| 特效 | 308 个内置效果，可串联 |
| 表达式 | 用脚本驱动参数，做联动动画 |
| 3D 相机与灯光 | 在三维空间里排布图层 |
| 渲染队列 | 多任务排队导出 |

## 快捷键

官方沿用了动效软件常见的快捷键（Character、Align、Progress、Render Queue 等），上手成本比换一套新键位低。

## 注意

- 它不是剪辑软件：音频与多轨叙事仍要另配工具
- 长合成渲染吃内存，先小样试参数
- 表达式出错误整个合成会静止，注意检查
- 浏览器版适合预览，正式渲染用桌面端
- Apache-2.0，二次分发保留声明

## 常见坑

- Windows 安装被 SmartScreen 拦：核对 SHA256 后仍报，选仍要运行
- AppImage 打不开：先 chmod +x，缺 FUSE 用 --appimage-extract
- 渲染很慢：降低分辨率或先渲染预览档
- 表达式报错导致画面静止：检查语法与引用图层名
- 字体缺失：把工程用到的字体装进系统
- 导出无声音：它本身不做音频，声音要另混
- 显存不足崩溃：减少 3D 图层与特效层数

## 免责声明

本仓库为第三方指南，与 EffectCraft 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-01），项目迭代快，请以[官方文档](https://github.com/storytold/effectcraft#readme)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
