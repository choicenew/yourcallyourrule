import 'dart:async';
import 'package:flutter/material.dart';
import 'package:live_updates/live_updates.dart';
import 'package:live_updates/models/custom_view_data.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  final int notificationId = 102;
  Timer? _timer;
  int _progress = 0;
  bool _isDownloading = false;
 // [最终的、绝对的修正] 定义预览容器的宽度，这个值必须和 CustomizationScreen 里的预览宽度一致
 
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startOrUpdateDownload() {
    if (!_isDownloading) {
      setState(() {
        _isDownloading = true;
        _progress = 0;
      });

      _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          _progress += 2;
          if (_progress >= 100) {
            _progress = 100;
            _isDownloading = false;
            timer.cancel();
          }
        });
        _showNotification();
      });
    }
    _showNotification();
  }

  void _showNotification() {
    LiveUpdates.showLayoutNotification(
      notificationId: notificationId,
      layoutName: 'download_progress_notification',
      smallIconName: 'ic_notification_download',
      ongoing: _isDownloading,
      payload: 'download_clicked_$_progress',
     
      viewData: {
        'file_name': TextViewData(text: _isDownloading ? 'Downloading report.pdf...' : 'Download Paused'),
        'progress_text': TextViewData(text: '$_progress% complete'),
        'progress_bar': ProgressBarViewData(progress: _progress, max: 100),
        'cancel_button_placeholder': VisibilityData(isVisible: _isDownloading),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Download Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.cloud_download, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              'Progress: $_progress%',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            LinearProgressIndicator(value: _progress / 100),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startOrUpdateDownload,
              child: Text(_isDownloading ? 'Update Notification' : 'Start Download'),
            ),
            OutlinedButton(
              onPressed: () {
                _timer?.cancel();
                setState(() => _isDownloading = false);
                LiveUpdates.cancelNotification(notificationId);
              },
              child: const Text('Cancel Download & Notification'),
            ),
          ],
        ),
      ),
    );
  }
}