import 'package:flutter/material.dart';



class SizePanel extends StatelessWidget {
  final String label;
  final double currentSize;
  final Function(double) onSizeChanged;

  const SizePanel({
    super.key,
    required this.label,
    required this.currentSize,
    required this.onSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: currentSize,
          min: 12,
          max: 24,
          divisions: 12,
          label: currentSize.toStringAsFixed(0),
          onChanged: onSizeChanged,
        ),
      ],
    );
  }
}