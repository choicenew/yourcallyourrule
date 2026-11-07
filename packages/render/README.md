# Pyro Render 深度多媒介渲染与消费微包矩阵 (`packages/render`)

`packages/render` 是 Pyro 架构中专门负责**多种媒介（小说、漫画、壁纸/画廊、新闻/资讯、音频/播客、视频、论文、作者主页等）深度消费卡片排版与视觉呈现**的渲染层微包矩阵。

---

## 📁 目录与微包矩阵 (Package Matrix)

`packages/render` 包含 12 个彻底解耦的专用 Package：

```text
packages/render/
├── pyro_render_protocol/        # [1] 纯抽象渲染类型与 CardBuilder/SlotBuilder 契约包
├── pyro_render_hub/             # [2] 渲染中介与服务定位注册中心 (RenderHub 单例)
├── pyro_render_ad_protocol/     # [3] 0-SDK 广告占位符抽象协议包 (RenderAdSlot)
├── pyro_browser_engine/         # [4] 网页端 Headless 浏览器 JS 桥接与划词提取引擎
├── pyro_render_wallpaper/       # [5] 壁纸/画廊消费与设为壁纸/裁剪卡片包
├── pyro_render_novel/           # [6] 小说/网文长文本排版与动态分页卡片包
├── pyro_render_comic/           # [7] 漫画分镜流与流式切片卡片包
├── pyro_render_news/            # [8] 新文/资讯富文本图文混排卡片包
├── pyro_render_audio/           # [9] 音频/播客歌词同步与媒体控制卡片包
├── pyro_render_video/           # [10] 视频/弹幕引擎与全屏手势卡片包
├── pyro_render_paper/           # [11] 论文 PDF/公式排版与引用分析卡片包
└── pyro_render_author/          # [12] 作者主页头部与作品流插槽卡片包
```

---

## 🏗️ 核心解耦理念

1. **契约与中介分离 (Protocol & Hub Separation)**:
   - 全部渲染包统一以 **`pyro_render_<media_type>`** 命名。
   - 具体渲染包互不依赖，仅向 `RenderHub.instance` 注册自己的 `type -> CardBuilder` 和 `slotName -> SlotBuilder`。
2. **数据类型擦除 (JSON-driven Rendering)**:
   - UI 列表向 `RenderHub` 索要卡片时传的是纯 JSON，强类型反序列化在具体渲染包内部闭环。
