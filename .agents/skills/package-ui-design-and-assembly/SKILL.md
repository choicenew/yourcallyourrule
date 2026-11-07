---
name: package-ui-design-and-assembly
description: Package UI 高高度封装、全量富元素复刻、100% 系统主题 Theme.of(context) 与主 App 容器+广告插槽三合一无缝装配指南。
---

# 🎨 Package UI 设计、高高度封装与三合一装配指南 (`package-ui-design-and-assembly`)

本 Skill 规定了在全工程子包 UI（`packages/*_ui`）重构打磨与主 App 整合过程中的**最高硬性标准**。

---

## 一、 四大核心硬性铁律 (Core Principles)

### 1. 全量富 UI 元素 100% 完备复刻（0 偷工减料）
包内卡片/Tile 控件必须 100% 包含以下元素，绝不偷工减料删减：
* **`leading`**：优先显示 Avatar 头像（如本地资产图片 `assets/avatars/` 或网络头像），兜底使用系统主题色绘制首字母头像；在多选模式下切换为多选复选框 (`Checkbox`)；
* **`title`**：主标题 Name / Title，可带标记 Label 贴纸 (`Chip`)；
* **`subtitle`**：副标题 Phone Number + 归属地 Location (`• 归属地`)；
* **`trailing`**：动作按钮组（如删除、详情、编辑）。

### 2. 100% 原生系统主题 (`Theme.of(context)`) 自适应
* **0 硬编码色彩**：绝对严禁使用 `Colors.white`, `Colors.black`, `Colors.red` 等硬编码颜色；
* **0 `isBlack` 条件分支逻辑**：不手贱写死三元颜色赋值；
* **全量使用 `colorScheme`**：
  * 背景 ➔ `Theme.of(context).colorScheme.surface`
  * 主文字 ➔ `Theme.of(context).colorScheme.onSurface`
  * 副文字 ➔ `Theme.of(context).colorScheme.onSurfaceVariant`
  * 分割线/边框 ➔ `Theme.of(context).colorScheme.outlineVariant`
  * 警告/主色 ➔ `Theme.of(context).colorScheme.error` / `primary`

### 3. 100% 多语言国际化 (`AppLocalizations`)
* 0 中英文硬编码文案；
* 所有标题、空状态文案、多选提示全量由 `AppLocalizations.of(context)!` 动态供给。

### 4. 三合一高高度封装装配 (One-Line Host Integration)
* **包内高高度封装 (`*PackageView`)**：包内自带添加弹窗处理、编辑回调、删除逻辑、Tile 渲染与 `adBuilder` 广告构建器契约，100% 内部封装；
* **主 App 极简套壳**：主 App 的 `GenericListWithAdsPage` 掌控外壳与 `adInterval = 3` 广告流，主 App 页面仅需一键套壳与函数对接！

---

## 二、 标准代码范式 (Code Templates)

### 1. 包内卡片控件范式 (`Pyro*CardWidget`)

```dart
class PyroPhoneRuleCardWidget extends StatelessWidget {
  final PhoneRuleEntity rule;
  final Widget? avatar;
  final String? location;
  final List<String>? labelTags;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool isMultiSelectMode;
  final bool isSelected;
  final ValueChanged<bool?>? onSelectionChanged;

  const PyroPhoneRuleCardWidget({
    super.key,
    required this.rule,
    this.avatar,
    this.location,
    this.labelTags,
    this.onTap,
    this.onDelete,
    this.isMultiSelectMode = false,
    this.isSelected = false,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: isMultiSelectMode
            ? Checkbox(
                value: isSelected,
                onChanged: onSelectionChanged,
                activeColor: colorScheme.primary,
              )
            : avatar ??
                CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  foregroundColor: colorScheme.onPrimaryContainer,
                  child: Text(
                    rule.name.isNotEmpty ? rule.name[0].toUpperCase() : 'R',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                rule.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (labelTags != null && labelTags!.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 6),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  labelTags!.first,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Row(
            children: [
              Text(
                rule.phoneNumber,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (location != null && location!.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(
                  '• $location',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ],
          ),
        ),
        trailing: onDelete != null
            ? IconButton(
                icon: Icon(Icons.delete_outline_rounded, color: colorScheme.error),
                onPressed: onDelete,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
```

---

### 2. 宿主 App 一键三连接入范式

```dart
class AppRuleManagementPage extends ConsumerWidget {
  const AppRuleManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final rules = ref.watch(phoneRulesControlCenterProvider).rules;

    return GenericListWithAdsPage<PhoneRuleEntity>(
      title: l10n.ruleManagementTitle,
      items: rules,
      emptyText: l10n.noRulesFound,
      adInterval: 3,
      adBuilder: () => const InlineAdaptiveAd(),
      itemBuilder: (context, rule) => PyroPhoneRuleCardWidget(
        rule: rule,
        onTap: () => ref.read(phoneRulesControlCenterProvider).editRule(rule),
      ),
      getItemId: (rule) => rule.id,
      onAdd: () => ref.read(phoneRulesControlCenterProvider).openAddDialog(context),
      onSearchChanged: (query) => ref.read(phoneRulesControlCenterProvider).search(query),
      onDeleteSelected: () => ref.read(phoneRulesControlCenterProvider).deleteSelected(),
    );
  }
}
```
