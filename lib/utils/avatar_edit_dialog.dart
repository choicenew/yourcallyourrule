import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../generated/l10n.dart';

class AvatarEditDialog extends StatefulWidget {
  final TextEditingController avatarController;
  final Function(String) onAvatarChanged;

  const AvatarEditDialog(
      {super.key,
      required this.avatarController,
      required this.onAvatarChanged});

  @override
  State<AvatarEditDialog> createState() => _AvatarEditDialogState();
}

class _AvatarEditDialogState extends State<AvatarEditDialog> {
  String? _previewImagePath;
  bool _isLocalImage = false;

  @override
  void initState() {
    super.initState();
    _previewImagePath = widget.avatarController.text;
    _isLocalImage = _previewImagePath?.startsWith('http') == false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).editAvatar),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Preview area
            GestureDetector(
              onTap: _previewImagePath != null
                  ? _cropImage
                  : null, // Allow cropping on tap
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: _previewImagePath != null
                    ? _isLocalImage
                        ? Image.file(File(_previewImagePath!),
                            fit: BoxFit.cover)
                        : Image.network(_previewImagePath!, fit: BoxFit.cover)
                    : Center(child: Text(S.of(context).noImageSelected)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text(S.of(context).chooseFromGallery),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _useNetworkImage,
              child: Text(S.of(context).useNetworkImage),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: _saveImage,
          child: Text(S.of(context).save),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _previewImagePath = image.path;
          _isLocalImage = true;
        });
      }
    } catch (e) {
      _showErrorDialog('Error picking image: $e');
    }
  }

  void _useNetworkImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String url = '';
        return AlertDialog(
          title: Text(S.of(context).enterImageUrl),
          content: TextField(
            onChanged: (value) => url = value,
            decoration: const InputDecoration(
                hintText: "https://example.com/image.jpg"),
          ),
          actions: [
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(S.of(context).ok),
              onPressed: () {
                setState(() {
                  _previewImagePath = url;
                  _isLocalImage = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _cropImage() async {
    if (_previewImagePath == null) return;

    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _previewImagePath!,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: S.of(context).cropAvatar,
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: S.of(context).cropAvatar,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _previewImagePath = croppedFile.path;
          _isLocalImage = true;
        });
      }
    } catch (e) {
      _showErrorDialog('Error cropping image: $e');
    }
  }

  void _saveImage() {
    if (_previewImagePath != null) {
      widget.avatarController.text = _previewImagePath!;
      widget.onAvatarChanged(_previewImagePath!);
    }
    Navigator.of(context).pop();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).error),
          content: Text(message),
          actions: [
            TextButton(
              child: Text(S.of(context).ok),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
