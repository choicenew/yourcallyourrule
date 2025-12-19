import 'package:flutter/material.dart';

class LiveUpdateSegment {
  final int progress;
  final Color color;

  LiveUpdateSegment({required this.progress, required this.color});

  Map<String, dynamic> toMap() => {'progress': progress, 'color': color.value};
}

class LiveUpdatePoint {
  final int progress;
  final Color color;

  LiveUpdatePoint({required this.progress, required this.color});

  Map<String, dynamic> toMap() => {'progress': progress, 'color': color.value};
}