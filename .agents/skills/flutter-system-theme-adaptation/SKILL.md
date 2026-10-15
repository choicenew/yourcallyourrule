---
name: flutter-system-theme-adaptation
description: Flutter 全局原生系统主题 (Theme.of(context)) 100% 适配与硬编码色彩替换指南。包含严格的 1:1 外科手术式修改原则、themeColor 参数完整保留策略、常用组件 (Scaffold, Card, ListTile, TextField, Switch, Dialog, SnackBar) 系统的 Light/Dark 自适应映射矩阵，防止白底白字与未跟随系统夜景变黑的问题。
---

# Flutter 全局原生系统主题适配与防坑最佳实践指南

本指南汇集了 Flutter 项目中全局原生系统主题（Material 3 / ThemeData）重构、深浅色模式（Light / Dark / Follow System）自适应接入以及硬编码色彩清理的完整实践经验与规矩。

---

## 核心原则 (Core Guiding Rules)

### 1. 100% 原生主题化，坚决消除硬编码 (Zero Hardcoded Colors)
- **能用系统主题的必须 100% 使用系统主题 (`Theme.of(context)`)**。
- 严禁在页面脚手架、卡片外壳、对话框、列表 Tile 或文本样式中硬编码写死颜色（如 `Color(0xFFFFFBF5)`、`Colors.white`、`Colors.black87`、`Colors.grey[600]`、`Color(0xFFEDE8DF)` 等）。
- 硬编码颜色会在用户切换到深色/夜景模式（Dark Mode）时，产生**纯白白格**或**白底白字/文字隐形不可读**的严重 UI 缺陷。

### 2. 绝对保留 `themeColor` 属性与传参 (Preserve `themeColor`)
- 如果组件、弹窗或页面定义了 `final Color? themeColor` 可选构造参数，**绝对不能删除、改动或省略**。
- 永远保持平滑降级原则：
  - 当外部传入 `themeColor`（非 `null`）时，**尊重并优先使用局部传入的色彩**；
  - 当 `themeColor == null` 时，平滑降级使用 `Theme.of(context).colorScheme.primary` 作为保底。
  ```dart
  // 标准降级范式
  final activeColor = widget.themeColor ?? Theme.of(context).colorScheme.primary;
  ```

### 3. 外科手术式单行替换，零逻辑侵入 (1:1 Surgical Edits Only)
- 修改样式时，**只改动硬编码色彩的那一行（1:1 精确替换）**。
- 绝对不动任何业务逻辑代码、事件响应（`onTap`、`onPressed`）、状态管理（`setState`、`ref.read`）、方法声明、变量定义或注释。
- 严禁擅自包裹额外的 Widget（如非必要的 `Theme(...)` 或 `PopScope(...)`），避免出现括号错配引发的 `Expected to find ')'` 编译错误。

---

## 原生系统主题映射矩阵 (Native System Theme Mapping)

| UI 元素类型 | 废弃的硬编码色值 | 标准原生主题映射 (`Theme.of(context)`) | Light Mode 自动表现 | Dark Mode 自动表现 |
| :--- | :--- | :--- | :--- | :--- |
| **脚手架底色** | `const Color(0xFFFFFBF5)` / `0xFFFAF8F5` | `Theme.of(context).scaffoldBackgroundColor` | 柔和米白/亮色底 | 深色 Slate 900 沉浸底 |
| **卡片/容器背景** | `Colors.white` | `Theme.of(context).colorScheme.surface` | 纯白卡片 | Slate 800 深色卡片 |
| **浅色容器/输入框填充** | `const Color(0xFFF7F5F0)` / `0xFFF0EDE6` | `Theme.of(context).colorScheme.surfaceContainerHighest` | 浅灰小胶囊底 | 暗灰小胶囊底 |
| **精细边框/分割线** | `const Color(0xFFEDE8DF)` / `Colors.grey[300]` | `Theme.of(context).colorScheme.outlineVariant` | 精细浅灰线 | 精细暗灰线 |
| **主标题/核心文本** | `Colors.black87` / `Colors.black` | `Theme.of(context).colorScheme.onSurface` | 黑色/高对比深色字 | 高亮清晰白字/浅色字 |
| **副标题/弱化描述文本** | `Colors.grey[600]` / `Colors.grey[700]` | `Theme.of(context).colorScheme.onSurfaceVariant` | 舒适中灰色字 | 舒适浅灰色字 |
| **开关/滑块激活色** | `activeColor: const Color(0xFFFF9500)` | `activeColor: Theme.of(context).colorScheme.primary` | 主配色（橙/琥珀） | 主配色（高亮橙/琥珀） |
| **成功提示 SnackBar** | `backgroundColor: Colors.green` | `backgroundColor: Theme.of(context).colorScheme.primary` | 绿/主色 Toast | 主色 Toast |
| **错误提示 SnackBar** | `backgroundColor: Colors.red` | `backgroundColor: Theme.of(context).colorScheme.error` | 红色 Error Toast | 红色 Error Toast |
| **警告/次要 SnackBar** | `backgroundColor: Colors.orange` | `backgroundColor: Theme.of(context).colorScheme.secondary` | 橙/次要色 Toast | 次要色 Toast |

---

## 主题架构解耦设计 (Theme Architecture)

### 1. `lib/theme/` 模块的完全闭环封装
- 所有的色彩 Token、Material 3 原生 `ThemeData`（如 `ColorScheme`、`CardTheme`、`DialogTheme`、`SwitchThemeData` 等）全部封装隐藏在 `lib/theme/` 内部解决。
- 即使未来重命名、拆分或重构 `lib/theme/` 内部的文件，外部所有 UI 页面也绝对不会产生哪怕一行编译报错。

### 2. `main.dart` 里的极简 1~2 行绑定
```dart
MaterialApp.router(
  // 1. 全局亮色与暗色主题接管
  theme: AppTheme.buildLightTheme(seedColor: themeColor),
  darkTheme: AppTheme.buildDarkTheme(seedColor: themeColor),

  // 2. 绑定全局主题模式 (Light / Dark / Follow System)
  themeMode: themeMode,
  // ...
)
```

---

## 典型避坑案例 (Pitfalls & Solutions)

### 案例 1：卡片装饰器默认回退硬编码白色
- **错误写错**：
  ```dart
  static BoxDecoration warmCardDecoration({required BuildContext context, Color? baseColor, ...}) {
    return BoxDecoration(
      color: baseColor ?? cardSurface, // cardSurface 写死了 Colors.white！导致深色模式全变白格
      ...
    );
  }
  ```
- **正确修复**：
  ```dart
  static BoxDecoration warmCardDecoration({required BuildContext context, Color? baseColor, ...}) {
    final surfaceColor = baseColor ?? Theme.of(context).colorScheme.surface; // 动态回退原生 surface
    return BoxDecoration(
      color: surfaceColor,
      ...
    );
  }
  ```

### 案例 2：删除 `themeColor` 参数引发破坏性变更
- **错误写错**：直接把组件调用处的 `themeColor: Colors.amber` 或构造函数里的 `this.themeColor` 删掉。
- **正确规矩**：绝对保留 `themeColor`，仅在其为 null 时通过 `widget.themeColor ?? Theme.of(context).colorScheme.primary` 进行降级。

### 案例 3：误加 Wrapper 导致括号不匹配
- **错误写错**：外层加 `PopScope` 或 `Theme` 时未匹配末尾的 `)，`，导致 `Expected to find ')'` 编译报错。
- **正确规矩**：只改动色彩调用的那一行代码，不增加非必要的层级包裹。
