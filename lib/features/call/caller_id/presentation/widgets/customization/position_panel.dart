import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';

class PositionPanel extends StatelessWidget {
  final String axis;
  final double currentValue;
  final Function(double) onChanged;

  const PositionPanel({
    super.key,
    required this.axis,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${axis.toUpperCase()}轴位置'),
        Slider(
          value: currentValue,
          min: 0,
          max: 1,
          divisions: 10,
          label: currentValue.toStringAsFixed(1),
          onChanged: onChanged,
        ),
      ],
    );
  }
}