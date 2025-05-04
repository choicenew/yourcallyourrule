import 'package:flutter/material.dart';


import 'package:yourcallyourrule/common/utils/hsv_color_picker.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';

class TextColorPanel extends StatelessWidget {
  final CallerIdStyleProvider styleProvider;

  const TextColorPanel({super.key, required this.styleProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildColorPicker(
          'Name Color',
          styleProvider.textNameColor,
          (color) => styleProvider.setTextNameColor(color),
        ),
        _buildColorPicker(
          'Carrier Color',
          styleProvider.textCarrierColor,
          (color) => styleProvider.setTextCarrierColor(color),
        ),
        _buildColorPicker(
          'Country Color',
          styleProvider.textCountryColor,
          (color) => styleProvider.setTextCountryColor(color),
        ),
        _buildColorPicker(
          'Labels Color',
          styleProvider.textLabelsColor,
          (color) => styleProvider.setTextLabelsColor(color),
        ),
        _buildColorPicker(
          'Count Color',
          styleProvider.textCountColor,
          (color) => styleProvider.setTextCountColor(color),
        ),
      ],
    );
  }

  Widget _buildColorPicker(String title, Color color, ValueChanged<Color> onChanged) {
    return ListTile(
      title: Text(title),
      trailing: HSVColorPicker(
        initialColor: color,
        onColorChanged: onChanged,
      ),
    );
  }
}