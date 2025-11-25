# Live Updates Plugin

[中文]: # (https://github.com/flutter/plugins/blob/master/packages/live_updates/README_CN.md)

Feel free to fork and modify this plugin by AI. The author may not maintain it in a timely manner, but the current functionality is generally usable.

## Introduction

`live_updates` is a Flutter plugin designed to help developers implement highly customizable "Live Activities" notifications on the Android platform. With this plugin, you can create notifications with custom layouts, progress bars, text, and images, providing a richer and more interactive user experience. It supports two main types of notifications:

1.  **Standard Notifications**: These notifications can be promoted to "Live Activities" by the system, supporting various styles (e.g., big text, call style, progress bar), and can be used to display download progress, call status, etc.
2.  **Custom Layout Notifications**: These are high-priority "Heads-Up Notifications" that allow you to fully customize the appearance and content of notifications using XML layout files. This enables you to create notifications that seamlessly integrate with your app's interface, such as custom caller ID displays.

## Features

*   **Custom Notification Layouts**: Define notification UI using XML files and dynamically update text, images, and progress bars from Flutter code.
*   **Multiple Notification Styles**: Supports various native Android notification styles, including `bigText`, `call`, and `progress`.
*   **Real-time Progress Updates**: Easily display real-time progress for downloads, uploads, or other time-consuming operations.
*   **Notification Tap Handling**: Listen for `payload` data passed when the user taps on a notification via `notificationPayloadStream`.
*   **Flexible Notification Management**: Supports canceling specific notifications by `notificationId`.

## Installation

Add `live_updates` to the `dependencies` section of your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  live_updates: ^0.0.1 # Use the latest version
```

Then run `flutter pub get`.

## Android Configuration

### 1. Add Permissions (Optional)

If your custom notifications require specific permissions (e.g., displaying call notifications might require `READ_PHONE_STATE`), add them to your `android/app/src/main/AndroidManifest.xml` file:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.yourapp">

    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <!-- Other permissions -->

    <application
        ...
    </application>
</manifest>
```

### 2. Create Custom Notification Layouts (for `showLayoutNotification`)

For custom layout notifications, you need to create XML layout files in the `android/app/src/main/res/layout/` directory. **You can name this file freely, but the filename must exactly match the `layoutName` parameter you use later in your Flutter code.**

For example, create a file named `my_caller_layout.xml`:

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

**Important Notes**:
*   The `android:id` in the layout file must correspond to the Key in your `viewData` Map in Flutter code.
*   The `android:src` for `ImageView` can be set to a default image or dynamically set via `imageBytes` in `ImageViewData` from Flutter code.

### 3. Add Small Icon

Notifications require a small icon. Place your icon file (e.g., `ic_notification.png`) in the `android/app/src/main/res/drawable/` directory. Reference it in `showLayoutNotification` or `showNotification` using the `smallIconName` parameter (without the file extension).

## Usage

### 1. Initialize the Plugin (Recommended)

Before using any other methods, it's recommended to initialize the plugin. This allows you to register a global callback for notification tap events, which is a simpler way to handle taps.

Call `LiveUpdates.initialize` early in your app's lifecycle, for example, in your `main` function:

```dart
import 'package:flutter/material.dart';
import 'package:live_updates/live_updates.dart';

// It's good practice to have a global key for showing Snackbars or dialogs from the callback.
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the plugin and set up the tap callback
  LiveUpdates.initialize(
    onNotificationTapped: (payload) {
      print('Notification tapped with payload: $payload');
      // You can implement navigation or other logic here.
      // For example, show a SnackBar:
      if (payload != null && payload.isNotEmpty) {
        final snackBar = SnackBar(content: Text('Callback received payload: $payload'));
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
      scaffoldMessengerKey: scaffoldMessengerKey, // Assign the key
      home: const HomePage(),
    );
  }
}
```

### 2. Import the Plugin

```dart
import 'package:live_updates/live_updates.dart';
import 'package:live_updates/models/custom_view_data.dart'; // If using custom layouts
import 'package:live_updates/models/live_update_progress_data.dart'; // If using progress segments
```

### 3. Handling Notification Taps: Callback vs. Stream

The plugin offers two ways to handle notification tap events. You can choose the one that best fits your app's architecture.

**A) `onNotificationTapped` Callback (Simple & Recommended)**

- **Best for**: Simple, direct actions like navigating to a page.
- **How it works**: The callback you provide to `LiveUpdates.initialize` is invoked once per tap.
- **Setup**: As shown in the initialization step above.

**B) `notificationPayloadStream` (Flexible & Advanced)**

- **Best for**: Complex scenarios where multiple parts of your app need to react to a tap event, or if you are using a reactive programming architecture (e.g., with BLoC or Riverpod).
- **How it works**: The stream emits the `payload` whenever a notification is tapped. You can have multiple listeners subscribed to this stream.
- **Setup**: You can listen to the stream anywhere in your app, for example, in a widget's `initState`:

```dart
// Listen for notification tap events via the stream
LiveUpdates.notificationPayloadStream.listen((payload) {
  if (payload != null && payload.isNotEmpty) {
    // Handle payload, e.g., update state or show a dialog
    print('Stream received payload: $payload');
  }
});
```

> **Note**: If you set up both, both the callback and the stream will receive the event when a notification is tapped.

### 4. Display Standard Notifications (`showNotification`)

This method is used to display native Android notifications that can be promoted to "Live Activities" by the system.

```dart
LiveUpdates.showNotification(
  notificationId: 1, // Unique notification ID
  title: 'Download in Progress',
  text: 'File downloading...', // Notification content
  style: 'progress', // Style: 'bigText', 'call', 'progress'
  ongoing: true, // Whether it's an ongoing notification (user cannot swipe to dismiss)
  payload: 'download_notification_clicked', // Data passed when notification is tapped
  progress: 50, // Current progress (0-100)
  progressMax: 100, // Maximum progress
  progressIndeterminate: false, // Whether it's an indeterminate progress bar
  // progressSegments: [ // Android 15+ progress segments
  //   LiveUpdateSegment(progress: 30, color: Colors.green.value),
  //   LiveUpdateSegment(progress: 40, color: Colors.orange.value),
  // ],
  // progressPoints: [ // Android 15+ progress points
  //   LiveUpdatePoint(progress: 25, label: 'Start'),
  //   LiveUpdatePoint(progress: 75, label: 'Complete'),
  // ],
  // progressTrackerIcon: Uint8List.fromList([/* icon bytes */]), // Android 15+ progress tracker icon
);

// Update progress
LiveUpdates.showNotification(
  notificationId: 1,
  title: 'Download in Progress',
  text: 'File downloading... (75%)',
  style: 'progress',
  ongoing: true,
  progress: 75,
  progressMax: 100,
);
```

### 5. Display Custom Layout Notifications (`showLayoutNotification`)

This method is used to display notifications defined using XML layout files. These are typically high-priority heads-up notifications.

```dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:live_updates/models/custom_view_data.dart';

// Assuming you have Uint8List data for an avatar
Uint8List avatarBytes = Uint8List.fromList([/* your image bytes */]);

LiveUpdates.showLayoutNotification(
  notificationId: 101, // Unique notification ID
  title: 'Notification Title', // Optional: Title displayed in the system header of the notification
  // **This string must exactly match your XML filename (without the .xml extension)**
  layoutName: 'my_caller_layout',
  smallIconName: 'ic_notification', // Small notification icon
  ongoing: true, // Whether it's an ongoing notification
  payload: 'caller_id_clicked', // Data passed when notification is tapped
  viewData: { // Dynamically update view data in the layout
    'avatar_image': ImageViewData(
      imageBytes: avatarBytes, // Set image byte data
      width: 48, // Width (dp)
      height: 48, // Height (dp)
      position: Offset(0, 0), // Optional: (x, y) offset in the available area (dp)
    ),
    'caller_name_text': TextViewData(
      text: 'John Doe', // Set text content
      textColor: Colors.black, // Text color
      textSize: 16, // Text size (sp)
      position: Offset(56, 4), // Optional: (x, y) offset in the available area (dp)
    ),
    'caller_number_text': TextViewData(
      text: '555-0101',
      textColor: Colors.grey,
      textSize: 14,
      position: Offset(56, 24),
    ),
    'progress_bar': ProgressBarViewData(
      progress: 70, // Progress bar current progress
      max: 100, // Progress bar maximum value
    ),
    'cancel_button_placeholder': VisibilityData(
      isVisible: true, // Control view visibility
    ),
  },
);
```

**`CustomViewData` Types Supported by `viewData`:**

*   `TextViewData`: Used to update `TextView`'s text, color, size, and position.
*   `ImageViewData`: Used to update `ImageView`'s image (via `imageBytes`), width, height, and position.
*   `ProgressBarViewData`: Used to update `ProgressBar`'s progress, and max value.
*   `VisibilityData`: Used to control the visibility of any view.
*   `MarqueeTextViewData`: Used to update a `TextView` that scrolls automatically.

### 6. Cancel Notification

```dart
LiveUpdates.cancelNotification(1); // Cancel notification with ID 1
LiveUpdates.cancelNotification(101); // Cancel notification with ID 101
```

## Example Project

Please refer to the `example/` directory, which contains a complete Flutter example application demonstrating various usages of the `live_updates` plugin, including:

*   Displaying standard notifications with different styles.
*   Implementing caller ID notifications using custom layouts.
*   Implementing download progress notifications using custom layouts.
*   Customization and preview of notification styles.

To run the example project:

```bash
cd example
flutter run
```

## Contribution

Welcome to submit Pull Requests or report Issues.

## License

[MIT License](LICENSE)