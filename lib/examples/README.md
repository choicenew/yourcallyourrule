# 广告列表组件使用指南

## 概述

本文档提供了在列表和网格中插入广告的通用组件使用指南。这些组件可以帮助您在应用的各种列表页面中按指定间隔插入广告，提高广告展示效率和用户体验。

## 可用组件

### 1. AdListWidget

`AdListWidget` 是一个通用的列表组件，可以在列表中按指定间隔插入广告。

**主要特性：**
- 支持自定义广告构建器和列表项构建器
- 支持自定义广告间隔
- 支持空状态显示
- 支持分隔符
- 支持自定义滚动方向、物理效果和内边距

### 2. AdGridWidget

`AdGridWidget` 是一个通用的网格组件，可以在网格中按指定间隔插入广告。

**主要特性：**
- 支持自定义广告构建器和网格项构建器
- 支持自定义广告间隔
- 支持自定义网格布局参数（如交叉轴数量、间距、宽高比等）
- 支持空状态显示

## 使用方法

### 在列表中使用 AdListWidget

```dart
AdListWidget<YourItemType>(
  items: yourItemsList,
  adBuilder: () => YourAdWidget(),
  itemBuilder: (context, item) => YourItemWidget(item),
  adInterval: 3, // 每3个项目插入一个广告
  adControlServiceProvider: adControlServiceProvider,
  emptyWidget: YourEmptyWidget(), // 可选
  useSeparated: true, // 可选，是否使用分隔符
  separatorBuilder: (context, index) => Divider(), // 可选
  scrollDirection: Axis.vertical, // 可选
  shrinkWrap: false, // 可选
  physics: AlwaysScrollableScrollPhysics(), // 可选
  padding: EdgeInsets.all(8), // 可选
)
```

### 在网格中使用 AdGridWidget

```dart
AdGridWidget<YourItemType>(
  items: yourItemsList,
  adBuilder: () => YourAdWidget(),
  itemBuilder: (context, item) => YourItemWidget(item),
  adInterval: 6, // 每6个项目插入一个广告
  adControlServiceProvider: adControlServiceProvider,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    childAspectRatio: 1.0,
  ),
  emptyWidget: YourEmptyWidget(), // 可选
  scrollDirection: Axis.vertical, // 可选
  shrinkWrap: false, // 可选
  physics: AlwaysScrollableScrollPhysics(), // 可选
  padding: EdgeInsets.all(8), // 可选
)
```

### 使用通用列表页面组件

为了进一步简化列表页面的创建，我们提供了 `GenericListWithAdsExample` 组件，它封装了常见的列表页面布局和广告插入逻辑。

```dart
GenericListWithAdsExample<YourItemType>(
  title: '页面标题',
  items: yourItemsList,
  itemBuilder: (context, item) => YourItemWidget(item),
  adBuilder: () => YourAdWidget(),
  adInterval: 3, // 可选，默认为3
  emptyText: '暂无数据', // 空状态文本
  themeColor: Colors.blue, // 可选，主题颜色
)
```

## 示例

我们提供了多个示例，展示如何在不同类型的页面中使用这些组件：

1. `mark_phone_management_page_with_ad_widget.dart` - 展示如何在号码标记管理页面中使用 AdListWidget
2. `generic_list_with_ads_example.dart` - 展示如何使用通用列表页面组件，包含以下示例：
   - 插件管理页面
   - 规则管理页面
   - 短信管理页面
   - 联系人管理页面

## 最佳实践

1. **广告间隔**：根据页面内容和用户体验，选择合适的广告间隔。一般建议在列表中每3-5个项目插入一个广告，在网格中每6-9个项目插入一个广告。

2. **广告样式**：确保广告样式与应用整体设计风格一致，避免过于突兀。

3. **性能优化**：对于大量数据的列表，考虑使用分页加载或虚拟滚动，避免一次性加载过多数据。

4. **广告控制**：使用 `AdControlService` 控制广告的显示和隐藏，根据用户购买状态或其他条件决定是否显示广告。

5. **空状态处理**：为空列表提供友好的空状态提示，提高用户体验。

## 注意事项

1. 确保在使用这些组件前已正确设置 `AdControlService`。

2. 广告构建器返回的广告组件应该具有合适的大小和样式，以适应列表或网格的布局。

3. 对于需要特殊布局或交互的页面，可能需要自定义组件或修改现有组件。