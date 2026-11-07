# pyro_render_wallpaper

`pyro_render_wallpaper` 是壁纸类内容的**标准化具体渲染与交互微包**。

## 架构与分层设计 (Modular Structure)
本微包遵循标准化设计，子功能模块独立拆分于 `lib/src/`：
- `src/wallpaper_localizations.dart`: 国际化接口与默认实现，支持主工程无缝覆盖；
- `src/wallpaper_intents.dart`: 壁纸交互意图全集 (`WallpaperDownloadIntent`, `WallpaperLikeIntent`, `WallpaperApplyIntent`)；
- `src/wallpaper_card.dart`: 现代瀑布流高质感壁纸卡片（沉浸式竖版比例、渐变遮罩、作者头像与分辨率 Tag）；
- `src/wallpaper_action_provider.dart`: 壁纸动作协议提供者，驱动响应式状态与 ActionEffect 广播；
- `src/wallpaper_renderer.dart`: 渲染注册中心入口。

## 核心能力
* **现代多巴胺瀑布流卡片**: 杜绝简陋空卡片，原生支持 0.75 纵向比例大图预览、多模态标签徽标、创作者头像及首字母自适应、离线优雅渐变降级，并在点击时触发全屏大图落地预览路由。
* **沉浸式全屏消费器 (`WallpaperPreviewScreen`)**: 支持多点触控与双击多级缩放、单击唤起/收起全屏遮罩、一键设为壁纸、原图无损下载、点赞收藏与元数据检视。
* **国际化完全解耦**: 默认提供英文文案，宿主 App 可通过 `WallpaperLocalizations.setCustomInstance` 注入主工程翻译，实现主包统一语言控制。
* **解耦交互体系**: 注册 `WallpaperActionProvider` 并挂载至 `ActionHub`，向 `pyro_render_hub` 注册标准 `ReaderBuilder`（`registerReader('wallpaper', ...)`）与详情路由（`registerRoute('wallpaper_detail', ...)`）。

## 初始化注册
```dart
WallpaperRenderer.register();
```

