import 'package:flutter/material.dart';


import 'package:yourcallyourrule/generated/app_localizations.dart';

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
        Text(AppLocalizations.of(context)!.axisPosition(axis.toUpperCase())),
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