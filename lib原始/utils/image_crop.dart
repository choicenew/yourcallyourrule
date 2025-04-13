import 'dart:ui' as ui;

import 'package:flutter/material.dart';


Future<ui.Image> cropImage(ui.Image image, ui.Rect cropRect) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  // 绘制裁剪后的图像
  canvas.drawImageRect(
    image,
    cropRect,
    Rect.fromLTWH(0, 0, cropRect.width, cropRect.height),
    Paint(),
  );

  final picture = recorder.endRecording();
  return picture.toImage(cropRect.width.toInt(), cropRect.height.toInt());
}



