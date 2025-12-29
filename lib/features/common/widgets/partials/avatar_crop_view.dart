import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class AvatarCropView extends StatefulWidget {
  final File imageFile;
  final Function(Uint8List) onCrop;
  final VoidCallback onCancel;
  final Color themeColor;

  const AvatarCropView({
    super.key,
    required this.imageFile,
    required this.onCrop,
    required this.onCancel,
    this.themeColor = Colors.blue,
  });

  @override
  State<AvatarCropView> createState() => _AvatarCropViewState();
}

class _AvatarCropViewState extends State<AvatarCropView> {
  final _controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  bool _isProcessing = false;

  Future<void> _performCrop() async {
    setState(() => _isProcessing = true);
    try {
      final image = await _controller.croppedBitmap();
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = data!.buffer.asUint8List();
      widget.onCrop(bytes);
    } catch (e) {
      debugPrint('Crop error: $e');
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: CropImage(
            controller: _controller,
            image: Image.file(widget.imageFile),
            gridColor: Colors.white,
            gridCornerColor: Colors.white,
            gridCornerSize: 50,
            gridThinWidth: 3,
            gridThickWidth: 6,
            scrimColor: Colors.grey.withValues(alpha: 0.5),
            alwaysShowThirdLines: true,
            minimumImageSize: 50,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.rotate_left),
              color: widget.themeColor,
              onPressed: () => _controller.rotateLeft(),
            ),
            IconButton(
              icon: const Icon(Icons.rotate_right),
              color: widget.themeColor,
              onPressed: () => _controller.rotateRight(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: widget.onCancel,
              child: Text(AppLocalizations.of(context)!.cancelButton),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _isProcessing ? null : _performCrop,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.themeColor,
              ),
              child:
                  _isProcessing
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : Text(AppLocalizations.of(context)!.confirm),
            ),
          ],
        ),
      ],
    );
  }
}
