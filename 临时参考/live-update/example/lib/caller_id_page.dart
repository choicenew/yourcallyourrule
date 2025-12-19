import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:live_updates/live_updates.dart';
import 'package:live_updates/models/custom_view_data.dart';
import 'package:live_updates_example/customization_screen.dart';
import 'package:live_updates_example/notification_style.dart';

class CallerIdPage extends StatefulWidget {
  final NotificationStyle style;
  const CallerIdPage({super.key, required this.style});

  @override
  State<CallerIdPage> createState() => _CallerIdPageState();
}

class _CallerIdPageState extends State<CallerIdPage> {
  final int notificationId = 101;
  Uint8List? _avatarBytes;

  @override
  void initState() {
    super.initState();
   
   
   
  }

  void _showNotification() {
    if (_avatarBytes == null) return;

    LiveUpdates.showLayoutNotification(
      notificationId: notificationId,
      layoutName: 'caller_id_notification_dynamic',
      smallIconName: 'ic_notification',
      ongoing: true,
      payload: 'caller_id_clicked',
      viewData: {
        'avatar_image': ImageViewData(
          imageBytes: _avatarBytes!,
          position: widget.style.avatarPosition,
          width: widget.style.avatarWidth,
          height: widget.style.avatarHeight,
        ),
        'caller_name_text': TextViewData(
          text: 'John Doe (Works!)',
          textColor: widget.style.nameColor,
          textSize: widget.style.nameFontSize,
          position: widget.style.namePosition,
        ),
        'caller_number_text': TextViewData(
          text: '555-0101',
          textColor: widget.style.phoneNumColor,
          textSize: widget.style.phoneNumFontSize,
          position: widget.style.phoneNumPosition,
        ),
        'caller_label_text': TextViewData(
          text: 'Mobile',
          textColor: widget.style.labelColor,
          textSize: widget.style.labelFontSize,
          position: widget.style.labelPosition,
        ),
        'caller_city_text': TextViewData(
          text: 'San Francisco',
          textColor: widget.style.cityColor,
          textSize: widget.style.cityFontSize,
          position: widget.style.cityPosition,
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Caller ID Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_avatarBytes != null)
              Center(
                child: Image.memory(_avatarBytes!, width: 100, height: 100),
              )
            else
              const Center(child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())),
            const SizedBox(height: 20),
            const Text(
              'This button will show a high-priority notification using a precise layout.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showNotification,
              child: const Text('Show Caller ID Notification'),
            ),
            OutlinedButton(
              onPressed: () => LiveUpdates.cancelNotification(notificationId),
              child: const Text('Cancel This Notification'),
            ),
          ],
        ),
      ),
    );
  }
}