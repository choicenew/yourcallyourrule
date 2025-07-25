import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:yourcallyourrule/common/utils/hsv_color_picker.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class ColorPickerButton extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerButton({
    super.key,
    required this.color,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showColorPicker(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.colorPickerTitle),
        content: SingleChildScrollView(
          child: HSVColorPicker(
            pickerColor: color,
            onColorChanged: onColorChanged,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.confirmButton),
          ),
        ],
      ),
    );
  }
}