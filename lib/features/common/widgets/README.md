# 模块化广告集成方案

## 概述

本模块提供了一种灵活、可复用的方式，用于在各种列表页面中集成广告功能。通过使用`GenericListWithAdsPage`组件，开发者可以轻松地将广告功能添加到任何列表页面中，而无需重复编写广告集成逻辑。

## 核心组件

### GenericListWithAdsPage

`GenericListWithAdsPage`是一个通用的列表页面组件，它接收一个列表数据和一个广告构建器，然后在列表中按照指定的间隔插入广告。

#### 主要特性

- 支持任意类型的列表数据
- 自定义广告构建器
- 自定义广告间隔
- 支持空状态显示
- 支持加载状态显示
- 支持刷新功能
- 支持添加项目功能
- 支持更多选项菜单
- 支持自定义操作按钮
- 支持自定义主题颜色
- 支持页面顶部额外内容

## 使用方法

### 基本用法

```dart
GenericListWithAdsPage<YourItemType>(
  title: '页面标题',
  items: yourItemsList,
  itemBuilder: (context, item) => YourItemWidget(item),
  adBuilder: () => YourAdWidget(),
  adInterval: 3, // 每3个项目显示一个广告
  emptyText: '没有数据',
  themeColor: Colors.blue,
);
```

### 完整示例

```dart
GenericListWithAdsPage<YourItemType>(
  title: '页面标题',
  items: yourItemsList,
  itemBuilder: (context, item) => YourItemWidget(item),
  adBuilder: () => YourAdWidget(),
  adInterval: 3, // 每3个项目显示一个广告
  emptyText: '没有数据',
  emptyIcon: Icons.info,
  emptyActionButton: ElevatedButton(
    onPressed: () => addNewItem(),
    child: Text('添加'),
  ),
  themeColor: Colors.blue,
  isLoading: isLoading,
  onRefresh: refreshData,
  onAdd: showAddDialog,
  onMoreOptions: showOptionsMenu,
  actionButtons: [
    IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: showFilterDialog,
    ),
  ],
  headerContent: YourHeaderWidget(),
);
```

## 示例页面

本项目包含了几个使用`GenericListWithAdsPage`的示例页面：

1. **插件管理页面**：展示如何在插件管理页面中集成广告
2. **规则管理页面**：展示如何在规则管理页面中集成广告
3. **短信管理页面**：展示如何在短信管理页面中集成广告
4. **联系人管理页面**：展示如何在联系人管理页面中集成广告

你可以通过访问`AdsExamplesShowcasePage`页面来查看这些示例。

## 广告状态管理

本模块使用`AdState`类来管理广告的启用/禁用状态。`AdState`是一个`StateNotifier`，它提供了以下方法：

- `isAdEnabled`：检查广告是否启用
- `disableAds`：禁用广告
- `enableAds`：启用广告

你可以通过`adStateProvider`来访问`AdState`：

```dart
final adEnabled = ref.watch(adStateProvider);
```

## 如何将现有页面改造为使用GenericListWithAdsPage

1. 确保你的页面有一个列表数据和一个构建列表项的方法
2. 创建一个广告构建器方法
3. 使用`GenericListWithAdsPage`替换现有的`Scaffold`和`ListView`
4. 将列表数据、列表项构建器和广告构建器传递给`GenericListWithAdsPage`
5. 配置其他选项，如空状态、加载状态、刷新功能等

## 最佳实践

1. 为不同类型的页面创建不同的广告构建器，以便根据页面内容显示相关广告
2. 根据列表项的大小调整广告间隔，以确保广告不会过于密集或稀疏
3. 使用`adStateProvider`来管理广告的启用/禁用状态，以便用户可以选择关闭广告
4. 在VIP用户或付费用户的情况下，考虑完全禁用广告

## 注意事项

1. 确保广告内容符合应用商店的政策和法规
2. 避免在关键操作流程中显示过多广告，以免影响用户体验
3. 考虑为用户提供关闭广告的选项，例如通过购买VIP或完成某些任务

## 未来计划

1. 支持更多类型的广告，如横幅广告、插页式广告等
2. 添加广告点击和展示统计功能
3. 支持根据用户行为和偏好智能调整广告显示频率和内容