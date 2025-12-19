// lib/customization_screen.dart

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:live_updates/live_updates.dart';
import 'package:live_updates/models/custom_view_data.dart';
import 'notification_style.dart'; // <--- 导入拆分出去的文件

// 这是一个独立的帮助函数，只在这个文件内部使用
Future<Uint8List?> createAvatarImage({required double width, required double height}) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  final size = Size(width, height);

  final bgPaint = ui.Paint()..color = Colors.grey.shade300;
  canvas.drawCircle(size.center(Offset.zero), size.width / 2, bgPaint);

  final icon = Icons.person;
  final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
    fontFamily: icon.fontFamily,
    fontSize: size.width * 0.6,
  ))
    ..pushStyle(ui.TextStyle(color: Colors.white))
    ..addText(String.fromCharCode(icon.codePoint));
  final paragraph = builder.build()..layout(ui.ParagraphConstraints(width: size.width));
  
  final dx = (size.width - paragraph.width) / 2;
  final dy = (size.height - paragraph.height) / 2;
  canvas.drawParagraph(paragraph, ui.Offset(dx, dy));

  final img = await recorder.endRecording().toImage(size.width.toInt(), size.height.toInt());
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  return byteData?.buffer.asUint8List();
}

class CustomizationScreen extends StatefulWidget {
  final NotificationStyle initialStyle;
  const CustomizationScreen({super.key, required this.initialStyle});
  @override
  _CustomizationScreenState createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  late NotificationStyle _currentStyle;
  final int notificationId = 101;
  bool _isPreviewExpanded = true;

  @override
  void initState() {
    super.initState();
    _currentStyle = widget.initialStyle;
  }

  Future<void> _showNotification() async {
    final avatarBytes = await createAvatarImage(
      width: _currentStyle.avatarWidth,
      height: _currentStyle.avatarHeight,
    );
    if (avatarBytes == null) return;

    LiveUpdates.showLayoutNotification(
      notificationId: notificationId,
      layoutName: 'caller_id_notification_dynamic',
      smallIconName: 'ic_notification',
      ongoing: true,
      payload: 'caller_id_clicked_from_customizer',
      viewData: {
        'avatar_image': ImageViewData(imageBytes: avatarBytes, position: _currentStyle.avatarPosition, width: _currentStyle.avatarWidth, height: _currentStyle.avatarHeight),
        'caller_name_text': TextViewData(text: 'John Doe (Works!)', textColor: _currentStyle.nameColor, textSize: _currentStyle.nameFontSize, position: _currentStyle.namePosition),
        'caller_number_text': TextViewData(text: '555-0101', textColor: _currentStyle.phoneNumColor, textSize: _currentStyle.phoneNumFontSize, position: _currentStyle.phoneNumPosition),
        'caller_label_text': TextViewData(text: 'Mobile', textColor: _currentStyle.labelColor, textSize: _currentStyle.labelFontSize, position: _currentStyle.labelPosition),
        'caller_city_text': TextViewData(text: 'San Francisco', textColor: _currentStyle.cityColor, textSize: _currentStyle.cityFontSize, position: _currentStyle.cityPosition),
        
        // ▼▼▼ 增加新文本的数据 ▼▼▼
         'marquee_alert_text': TextViewData( // <-- 从 TextViewData 改为 MarqueeTextViewData
          text: '这是一个新的、独立的、用于测试的文本字段，它应该能正常工作。', 
          textColor: _currentStyle.alertColor, 
          textSize: _currentStyle.alertFontSize, 
          position: _currentStyle.alertPosition
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize & Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Style Saved!'), duration: Duration(seconds: 1)),
              );
            },
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, _currentStyle),
          )
        
      ),
      body: Column(
        children: [
          _buildPreviewArea(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ElevatedButton(onPressed: _showNotification, child: const Text('Show Notification From Preview')),
                OutlinedButton(onPressed: () => LiveUpdates.cancelNotification(notificationId), child: const Text('Cancel This Notification')),
                const SizedBox(height: 16),
                _buildSectionTitle('Avatar'),
                _buildSlider('Width', _currentStyle.avatarWidth, 20, 100, (val) => setState(() => _currentStyle.avatarWidth = val)),
                _buildSlider('Height', _currentStyle.avatarHeight, 20, 100, (val) => setState(() => _currentStyle.avatarHeight = val)),
                _buildPositionEditor('Position', _currentStyle.avatarPosition, (pos) => setState(() => _currentStyle.avatarPosition = pos)),
                const Divider(),
                _buildSectionTitle('Name'),
                _buildSlider('Font Size', _currentStyle.nameFontSize, 10, 30, (val) => setState(() => _currentStyle.nameFontSize = val)),
                _buildPositionEditor('Position', _currentStyle.namePosition, (pos) => setState(() => _currentStyle.namePosition = pos)),
                const Divider(),
                _buildSectionTitle('Phone Number'),
                _buildSlider('Font Size', _currentStyle.phoneNumFontSize, 10, 30, (val) => setState(() => _currentStyle.phoneNumFontSize = val)),
                _buildPositionEditor('Position', _currentStyle.phoneNumPosition, (pos) => setState(() => _currentStyle.phoneNumPosition = pos)),
                
                // ▼▼▼ 增加新文本的控制 UI ▼▼▼
                const Divider(),
                _buildSectionTitle('Scrolling Alert'),
                _buildSlider('Font Size', _currentStyle.alertFontSize, 10, 30, (val) => setState(() => _currentStyle.alertFontSize = val)),
                _buildPositionEditor('Position', _currentStyle.alertPosition, (pos) => setState(() => _currentStyle.alertPosition = pos)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewArea() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          _buildSystemHeader(),
          _buildContentView(),
        ],
      ),
    );
  }

  Widget _buildSystemHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          const Icon(Icons.android, color: Colors.blueGrey, size: 20),
          const SizedBox(width: 8),
          const Text("live_updates_example", style: TextStyle(color: Colors.black54)),
          const Spacer(),
          const Text("now", style: TextStyle(color: Colors.black54, fontSize: 12)),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => setState(() => _isPreviewExpanded = !_isPreviewExpanded),
            child: Icon(_isPreviewExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.grey.shade700, size: 24),
          ),
        ],
      ),
    );
  }
  
  Widget _buildContentView() {
    const double leftDeadZone = 56.0;
    const double rightDeadZone = 48.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _isPreviewExpanded ? 128 : 64,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(children: [
              Container(width: leftDeadZone, color: Colors.black.withOpacity(0.05)),
              const Spacer(),
              Container(width: rightDeadZone, color: Colors.black.withOpacity(0.05)),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: leftDeadZone, right: rightDeadZone),
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  _DraggableElement(
                    parentConstraints: constraints,
                    position: _currentStyle.avatarPosition,
                    onPositionChanged: (pos) => setState(() => _currentStyle.avatarPosition = pos),
                    child: FutureBuilder<Uint8List?>(
                      key: ValueKey('${_currentStyle.avatarWidth}x${_currentStyle.avatarHeight}'),
                      future: createAvatarImage(width: _currentStyle.avatarWidth, height: _currentStyle.avatarHeight),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Image.memory(snapshot.data!);
                        }
                        return Container(
                          width: _currentStyle.avatarWidth,
                          height: _currentStyle.avatarHeight,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade200),
                        );
                      },
                    ),
                  ),
                  _DraggableElement(parentConstraints: constraints, position: _currentStyle.namePosition, onPositionChanged: (pos) => setState(() => _currentStyle.namePosition = pos), child: Text('John Doe', style: TextStyle(fontSize: _currentStyle.nameFontSize, color: _currentStyle.nameColor, fontWeight: FontWeight.bold))),
                  _DraggableElement(
                    parentConstraints: constraints,
                    position: _currentStyle.phoneNumPosition,
                    onPositionChanged: (pos) => setState(() => _currentStyle.phoneNumPosition = pos),
                    child: Text('555-0101', style: TextStyle(fontSize: _currentStyle.phoneNumFontSize, color: _currentStyle.phoneNumColor)),
                  ),

                  // ▼▼▼ 增加新文本的预览 ▼▼▼
                  _DraggableElement(
                    parentConstraints: constraints,
                    position: _currentStyle.alertPosition,
                    onPositionChanged: (pos) => setState(() => _currentStyle.alertPosition = pos),
                    child: SizedBox(
                      width: constraints.maxWidth - _currentStyle.alertPosition.dx,
                      child: Text(
                        'This is a scrolling alert text preview...',
                        style: TextStyle(fontSize: _currentStyle.alertFontSize, color: _currentStyle.alertColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(label)),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).round(),
            label: value.round().toString(),
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 40, child: Text(value.round().toString())),
      ],
    );
  }

  Widget _buildPositionEditor(String label, Offset position, ValueChanged<Offset> onChanged) {
    const double leftDeadZone = 56.0;
    const double rightDeadZone = 48.0;
    final availableWidth = MediaQuery.of(context).size.width - 32 - leftDeadZone - rightDeadZone;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        _buildSlider('X', position.dx, 0, availableWidth - 50, (val) => onChanged(Offset(val, position.dy))),
        _buildSlider('Y', position.dy, 0, _isPreviewExpanded ? 110 : 50, (val) => onChanged(Offset(position.dx, val))),
      ],
    );
  }
}

class _DraggableElement extends StatelessWidget {
  final BoxConstraints parentConstraints;
  final Offset position;
  final Function(Offset) onPositionChanged;
  final Widget child;

  const _DraggableElement({
    required this.parentConstraints,
    required this.position,
    required this.onPositionChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          final newDx = (position.dx + details.delta.dx).clamp(0.0, parentConstraints.maxWidth - 20);
          final newDy = (position.dy + details.delta.dy).clamp(0.0, parentConstraints.maxHeight - 20);
          onPositionChanged(Offset(newDx, newDy));
        },
        child: child,
      ),
    );
  }
}