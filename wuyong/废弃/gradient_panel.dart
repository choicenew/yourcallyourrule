import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/commom/utils/hsv_color_picker.dart';
import 'package:yourcallyourrule/common/utils/hsv_color_picker.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';

class BackgroundGradientPanel extends StatelessWidget {
  final CallerIdStyleProvider styleProvider;

  const BackgroundGradientPanel({super.key, required this.styleProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildGradientPicker(
          'Start Color',
          styleProvider.gradientStartColor,
          (color) => styleProvider.setGradientStartColor(color),
        ),
        _buildGradientPicker(
          'End Color',
          styleProvider.gradientEndColor,
          (color) => styleProvider.setGradientEndColor(color),
        ),
        Slider(
          value: styleProvider.gradientAngle,
          min: 0,
          max: 360,
          onChanged: (value) => styleProvider.setGradientAngle(value),
          label: 'Gradient Angle: ${styleProvider.gradientAngle.round()}°',
        ),
      ],
    );
  }

  Widget _buildGradientPicker(String title, Color color, ValueChanged<Color> onChanged) {
    return ListTile(
      title: Text(title),
      trailing: HSVColorPicker(
        initialColor: color,
        onColorChanged: onChanged,
      ),
    );
  }
}