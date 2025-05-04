import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/customization/color_picker_button.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';

class ColorPanel extends StatelessWidget {
  final String title;
  final Color currentColor;
  final Function(Color) onColorChanged;

  const ColorPanel({
    super.key,
    required this.title,
    required this.currentColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Row(
          children: [
            Expanded(
              child: ColorPickerButton(
                color: currentColor,
                onColorChanged: onColorChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}