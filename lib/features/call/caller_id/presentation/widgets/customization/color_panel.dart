import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/customization/color_picker_button.dart';


class ColorPanel extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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