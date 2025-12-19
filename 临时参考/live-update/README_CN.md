# Live Updates Plugin

## 简介

`live_updates` 是一个 Flutter 插件，旨在帮助开发者在 Android 平台上实现高度自定义的“实时活动”（Live Activities）通知。通过此插件，您可以创建具有自定义布局、进度条、文本和图像的通知，从而提供更丰富、更具交互性的用户体验。它支持两种主要类型的通知：

1.  **标准通知 (Standard Notifications)**：这些通知可以被系统提升为“实时活动”，支持多种样式（如大文本、来电样式、进度条），并可用于显示下载进度、通话状态等。
2.  **自定义布局通知 (Custom Layout Notifications)**：这些是高优先级的“浮动通知”（Heads-Up Notifications），允许您使用 XML 布局文件完全自定义通知的外观和内容。这使得您可以创建与应用界面无缝融合的通知，例如自定义来电显示界面。

## 功能特性

*   **自定义通知布局**：使用 XML 文件定义通知的 UI，并通过 Flutter 代码动态更新其中的文本、图片和进度条。
*   **多种通知样式**：支持 Android 原生通知的多种样式，包括 `bigText`、`call` 和 `progress`。
*   **实时进度更新**：轻松实现下载、上传或其他耗时操作的实时进度显示。
*   **通知点击事件处理**：通过 `notificationPayloadStream` 监听用户点击通知时传递的数据。
*   **灵活的通知管理**：支持通过 `notificationId` 取消特定通知。

## 安装

在 `pubspec.yaml` 文件的 `dependencies` 部分添加 `live_updates`：

```yaml
dependencies:
  flutter:
    sdk: flutter
  live_updates: ^0.0.1 # 请使用最新版本
```

然后运行 `flutter pub get`。

## Android 配置

### 1. 添加权限 (可选)

如果您的自定义通知需要特定权限（例如，显示来电通知可能需要 `READ_PHONE_STATE`），请在 `android/app/src/main/AndroidManifest.xml` 文件中添加：

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.yourapp">

    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <!-- 其他权限 -->

    <application
        ...
    </application>
</manifest>
```

### 2. 创建自定义通知布局 (针对 `showLayoutNotification`)

对于自定义布局通知，您需要在 `android/app/src/main/res/layout/` 目录下创建 XML 布局文件。**您可以自由命名该文件，但文件名必须与您稍后在 Flutter 代码中使用的 `layoutName` 参数完全对应。**

例如，创建一个名为 `my_caller_layout.xml` 的文件：

```xml
<!-- android/app/src/main/res/layout/my_caller_layout.xml -->
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:padding="8dp">

    <ImageView
        android:id="@+id/avatar_image"
        android:layout_width="48dp"
        android:layout_height="48dp"
        android:layout_marginEnd="8dp"
        android:src="@drawable/ic_launcher" />

    <LinearLayout
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:orientation="vertical">

        <TextView
            android:id="@+id/caller_name_text"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textStyle="bold"
            android:textSize="16sp"
            android:text="Caller Name" />

        <TextView
            android:id="@+id/caller_number_text"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textSize="14sp"
            android:text="Caller Number" />
    </LinearLayout>
</LinearLayout>
```

**重要提示**：
*   布局文件中的 `android:id` 必须与您在 Flutter 代码中 `viewData` Map 的 Key 对应。
*   `ImageView` 的 `android:src` 可以设置为默认图片，或者在 Flutter 代码中通过 `ImageViewData` 动态设置 `imageBytes`。

### 3. 添加小图标 (Small Icon)

通知需要一个小图标。请将您的图标文件（例如 `ic_notification.png`）放置在 `android/app/src/main/res/drawable/` 目录下。在 `showLayoutNotification` 或 `showNotification` 中通过 `smallIconName` 参数引用它（不带文件扩展名）。

## 使用方法

### 1. 初始化插件 (推荐)

在使用任何其他方法之前，建议先初始化插件。这允许您为通知点击事件注册一个全局回调，这是一种更简单的处理点击事件的方式。

在您应用的生命周期早期调用 `LiveUpdates.initialize`，例如，在您的 `main` 函数中：

```dart
import 'package:flutter/material.dart';
import 'package:live_updates/live_updates.dart';

// 准备一个全局的 GlobalKey，以便在回调中显示 SnackBar 或对话框
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化插件并设置点击回调
  LiveUpdates.initialize(
    onNotificationTapped: (payload) {
      print('通知被点击，payload: $payload');
      // 在这里实现导航或其他逻辑
      // 例如，显示一个 SnackBar：
      if (payload != null && payload.isNotEmpty) {
        final snackBar = SnackBar(content: Text('回调收到 payload: $payload'));
        scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
      }
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey, // 分配 key
      home: const HomePage(),
    );
  }
}
```

### 2. 导入插件

```dart
import 'package:live_updates/live_updates.dart';
import 'package:live_updates/models/custom_view_data.dart'; // 如果使用自定义布局
import 'package:live_updates/models/live_update_progress_data.dart'; // 如果使用进度条分段
```

### 3. 处理通知点击：回调 (Callback) vs. 流 (Stream)

本插件提供两种方式来处理通知点击事件。您可以选择最适合您应用架构的方式。

**A) `onNotificationTapped` 回调 (简单 & 推荐)**

- **最适合**：简单、直接的操作，如导航到某个页面。
- **工作原理**：您提供给 `LiveUpdates.initialize` 的回调函数会在每次点击时被调用一次。
- **如何设置**：如上面的初始化步骤所示。

**B) `notificationPayloadStream` 流 (灵活 & 高级)**

- **最适合**：复杂的场景，例如应用的多个部分需要对同一次点击事件做出反应，或者您正在使用响应式编程架构（例如 BLoC 或 Riverpod）。
- **工作原理**：每当通知被点击时，该流会发出 `payload`。您可以有多个监听者订阅此流。
- **如何设置**：您可以在应用的任何地方监听此流，例如，在某个 widget 的 `initState` 中：

```dart
// 通过 Stream 监听通知点击事件
LiveUpdates.notificationPayloadStream.listen((payload) {
  if (payload != null && payload.isNotEmpty) {
    // 处理 payload，例如更新状态或显示对话框
    print('Stream 收到 payload: $payload');
  }
});
```

> **注意**：如果您同时设置了两者，那么当通知被点击时，回调和流都会收到事件。

### 4. 显示标准通知 (`showNotification`)

此方法用于显示 Android 原生通知，可以被系统提升为“实时活动”。

```dart
LiveUpdates.showNotification(
  notificationId: 1, // 唯一通知 ID
  title: '下载进行中',
  text: '文件下载中...', // 通知内容
  style: 'progress', // 样式：'bigText', 'call', 'progress'
  ongoing: true, // 是否为持续性通知（用户无法滑动关闭）
  payload: 'download_notification_clicked', // 点击通知时传递的数据
  progress: 50, // 当前进度 (0-100)
  progressMax: 100, // 最大进度
  progressIndeterminate: false, // 是否为不确定进度条
  // progressSegments: [ // Android 15+ 进度条分段
  //   LiveUpdateSegment(progress: 30, color: Colors.green.value),
  //   LiveUpdateSegment(progress: 40, color: Colors.orange.value),
  // ],
  // progressPoints: [ // Android 15+ 进度点
  //   LiveUpdatePoint(progress: 25, label: '开始'),
  //   LiveUpdatePoint(progress: 75, label: '完成'),
  // ],
  // progressTrackerIcon: Uint8List.fromList([/* icon bytes */]), // Android 15+ 进度跟踪图标
);

// 更新进度
LiveUpdates.showNotification(
  notificationId: 1,
  title: '下载进行中',
  text: '文件下载中... (75%)',
  style: 'progress',
  ongoing: true,
  progress: 75,
  progressMax: 100,
);
```

### 5. 显示自定义布局通知 (`showLayoutNotification`)

此方法用于显示使用 XML 布局文件定义的通知。这些通常是高优先级的浮动通知。

```dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:live_updates/models/custom_view_data.dart';

// 假设您有一个头像的 Uint8List 数据
Uint8List avatarBytes = Uint8List.fromList([/* your image bytes */]);

LiveUpdates.showLayoutNotification(
  notificationId: 101, // 唯一通知 ID
  title: '通知标题', // 可选：显示在通知系统头部区域的标题
  // **这里的字符串必须精确匹配你的XML文件名(不含.xml后缀)**
  layoutName: 'my_caller_layout',
  smallIconName: 'ic_notification', // 通知小图标
  ongoing: true, // 是否为持续性通知
  payload: 'caller_id_clicked', // 点击通知时传递的数据
  viewData: { // 动态更新布局中的视图数据
    'avatar_image': ImageViewData(
      imageBytes: avatarBytes, // 设置图片字节数据
      width: 48, // 宽度 (dp)
      height: 48, // 高度 (dp)
      position: Offset(0, 0), // 可选：相对于可用区域的 (x, y) 偏移 (dp)
    ),
    'caller_name_text': TextViewData(
      text: 'John Doe', // 设置文本内容
      textColor: Colors.black, // 文本颜色
      textSize: 16, // 文本大小 (sp)
      position: Offset(56, 4), // 可选：相对于可用区域的 (x, y) 偏移 (dp)
    ),
    'caller_number_text': TextViewData(
      text: '555-0101',
      textColor: Colors.grey,
      textSize: 14,
      position: Offset(56, 24),
    ),
    'progress_bar': ProgressBarViewData(
      progress: 70, // 进度条当前进度
      max: 100, // 进度条最大值
    ),
    'cancel_button_placeholder': VisibilityData(
      isVisible: true, // 控制视图可见性
    ),
  },
);
```

**`viewData` 支持的 `CustomViewData` 类型：**

*   `TextViewData`：用于更新 `TextView` 的文本、颜色、大小和位置。
*   `ImageViewData`：用于更新 `ImageView` 的图片（通过 `imageBytes`）、宽度、高度和位置。
*   `ProgressBarViewData`：用于更新 `ProgressBar` 的进度、最大值。
*   `VisibilityData`：用于控制任何视图的可见性。
*   `MarqueeTextViewData`: 用于更新一个强制滚动的 `TextView`。

### 6. 取消通知

```dart
LiveUpdates.cancelNotification(1); // 取消 ID 为 1 的通知
LiveUpdates.cancelNotification(101); // 取消 ID 为 101 的通知
```

## 示例项目

请查看 `example/` 目录，其中包含一个完整的 Flutter 示例应用，演示了 `live_updates` 插件的各种用法，包括：

*   显示不同样式的标准通知。
*   使用自定义布局实现来电显示通知。
*   使用自定义布局实现下载进度通知。
*   通知样式的自定义和预览。

运行示例项目：

```bash
cd example
flutter run
```

## 贡献

欢迎提交 Pull Request 或报告 Issue。

## 许可证

[MIT License](LICENSE)