# 官方 material_ui GitHub Fork 与无依赖液态玻璃扩展未来迁移 SOP 白皮书

> **文档定位**: 记录未来从本地 `pyro_material_ui` 过渡移到官方 GitHub Fork 仓库 + GitHub Actions 上游同步补丁方案的完整实施 SOP。  
> **核心铁律**: 现阶段**绝对不动现有工程代码**，保持当前状态稳定。未来开启迁移时按本 SOP 零风险落操。

---

## 一、 核心设计原则 (Core Principles)

### 1. 绝对零外部微包依赖 (Zero Private Package Dependencies)
在 GitHub 上 Fork 官方 `material_ui` 仓库后：
- **绝对禁止**在 Fork 的仓库中引入 `pyro_theme_ui` 或任何 `pyro_*` 本地/私有微包！
- 补丁后的 `material_ui` 必须是 **100% 独立、干干净净、标准纯粹的 Dart/Flutter 开源包**。
- 液态玻璃拟态卡片仅使用 Flutter SDK 核心原生 `BackdropFilter`、`ImageFilter.blur` 与原生标量参数绘制，零私有拓展依赖。

### 2. 上游自动无缝追随 (Automated Upstream Syncing)
利用 GitHub Actions 工作流与自动 Patch 脚本：
- 官方 `material_ui` 仓库只要有更新发版，Actions 自动执行 `git merge upstream/main`；
- 自动运行 Patch 脚本将独立玻璃卡片补丁注入，保持与官方上游 100% 同步升级，无需人工维护修 Bug。

---

## 二、 未来 GitHub Fork 与补丁脚本落操 SOP

### 步骤 1：GitHub 仓库 Fork 与 Upstream 绑定
1. 在 GitHub 上 Fork 官方 `material_ui` 仓库（例如 Fork 到 `https://github.com/your-org/material_ui.git`）。
2. 配置官方 upstream 远程分支：
   ```bash
   git remote add upstream https://github.com/flutter/material_ui.git
   ```

### 步骤 2：注入 GitHub Actions 自动同步工作流 (`.github/workflows/upstream_sync.yml`)

在 Fork 的仓库中添加自动化脚本：

```yaml
name: Upstream Sync & Glassmorphism Patch

on:
  schedule:
    - cron: '0 0 * * *' # 每天凌晨自动同步上游更新
  workflow_dispatch: # 支持手动一键触发同步

jobs:
  sync_and_patch:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Fork Repository
        uses: actions/checkout@v4
        with:
          ref: main
          fetch-depth: 0

      - name: Sync Upstream
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git remote add upstream https://github.com/flutter/material_ui.git || true
          git fetch upstream main
          git merge upstream/main -m "chore: sync upstream official material_ui"

      - name: Apply Liquid Glass Card Patch
        run: |
          # 运行本地 Dart 补丁脚本，确保 Card 叠加高斯玻璃拟态且 0 依赖 pyro_theme_ui
          dart run scripts/apply_glass_patch.dart

      - name: Push Changes
        run: |
          git commit -am "feat: apply zero-dependency liquid glassmorphism card patch" || true
          git push origin main
```

---

## 三、 零 `pyro_theme_ui` 依赖的玻璃 Card 物理实现

在 Fork 仓库中，玻璃 `Card` 的实现仅依靠原生 `package:flutter/widgets.dart` 与标量参数（**100% 独立干净**）：

```dart
import 'dart:ui';
import 'package:flutter/widgets.dart';

/// 100% 无外部微包依赖、纯原生 Flutter 核心绘制的高斯玻璃 Card 扩展
class Card extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final ShapeBorder? shape;
  final bool borderOnForeground;
  final EdgeInsetsGeometry? margin;
  final Clip? clipBehavior;
  final bool semanticContainer;
  final bool enableGlass;

  const Card({
    super.key,
    this.child,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.semanticContainer = true,
    this.enableGlass = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = shape is RoundedRectangleBorder
        ? (shape as RoundedRectangleBorder).borderRadius
        : BorderRadius.circular(16.0);

    final cardContent = Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color ?? const Color(0x00000000),
        borderRadius: effectiveRadius,
      ),
      clipBehavior: clipBehavior ?? Clip.antiAlias,
      child: child,
    );

    if (!enableGlass) {
      return Container(
        margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
        child: cardContent,
      );
    }

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: effectiveRadius.resolve(Directionality.maybeOf(context)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            decoration: BoxDecoration(
              color: color ?? const Color(0x1F000000),
              borderRadius: effectiveRadius,
              border: Border.all(
                color: const Color(0x33FFFFFF),
                width: 1.0,
              ),
            ),
            child: cardContent,
          ),
        ),
      ),
    );
  }
}
```

---

## 四、 未来切换挂载 SOP (Future Cutover SOP)

当日后有充足时间开启迁移时：

1. **主 App `pubspec.yaml` 零侵入切换**：
   在 `pyro_magma/pubspec.yaml` 中，将依赖指向 GitHub Fork 仓库：
   ```yaml
   dependencies:
     material_ui:
       git:
         url: https://github.com/your-org/material_ui.git
         ref: main
   ```
2. **微包业务代码 zero-edit**：
   工程里 100+ 个微包继续统一使用：
   ```dart
   import 'package:material_ui/material_ui.dart';
   ```
3. **物理安全归档与废包**：
   删除本地过度的 `packages/config/pyro_material_ui` 文件夹，主工程架构彻底回归至单层纯粹形态。
