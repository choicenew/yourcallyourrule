import 'dart:typed_data';
import 'package:flutter/material.dart';

/// 用于填充自定义XML布局中视图的数据模型基类。
abstract class CustomViewData {
  String get type;
  Map<String, dynamic> toMap();
}

/// 填充TextView的数据
class TextViewData extends CustomViewData {
  @override
  final String type = 'textView';
  final String text;
  final Color? textColor;
  final double? textSize;
  final Offset? position;

  TextViewData({required this.text, this.textColor, this.textSize, this.position});

  @override
  Map<String, dynamic> toMap() => {
    'type': type,
    'text': text,
    'textColor': textColor?.value,
    'textSize': textSize,
    'x': position?.dx,
    'y': position?.dy,
  };
}

/// 填充ImageView的数据
class ImageViewData extends CustomViewData {
  @override
  final String type = 'imageView';
  final Uint8List imageBytes;
  final double? width;
  final double? height;
  final Offset? position;

  ImageViewData({required this.imageBytes, this.width, this.height, this.position});

  @override
  Map<String, dynamic> toMap() => {
    'type': type,
    'imageBytes': imageBytes,
    'width': width,
    'height': height,
    'x': position?.dx,
    'y': position?.dy,
  };
}

/// 填充ProgressBar的数据
class ProgressBarViewData extends CustomViewData {
  @override
  final String type = 'progressBar';
  final int progress;
  final int max;
  final bool indeterminate;

  ProgressBarViewData({required this.progress, this.max = 100, this.indeterminate = false});

  @override
  Map<String, dynamic> toMap() => {
    'type': type, 'progress': progress, 'max': max, 'indeterminate': indeterminate
  };
}

/// 控制视图可见性的数据
class VisibilityData extends CustomViewData {
    @override
    final String type = 'visibility';
    final bool isVisible;

    VisibilityData({required this.isVisible});

    @override
    Map<String, dynamic> toMap() => {'type': type, 'isVisible': isVisible};
}

 /// 填充一个强制滚动的 TextView
    class MarqueeTextViewData extends CustomViewData {
      @override
      final String type = 'marqueeTextView'; // <-- 类型匹配原生代码
      final String text;
      final Color? textColor;
      final double? textSize;
      final Offset? position;
    
      MarqueeTextViewData({required this.text, this.textColor, this.textSize, this.position});
    
      @override
      Map<String, dynamic> toMap() => {
        'type': type,
        'text': text,
        'textColor': textColor?.value,
        'textSize': textSize,
        'x': position?.dx,
        'y': position?.dy,
      };
    }