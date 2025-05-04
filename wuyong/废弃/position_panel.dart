import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';

class PositionSettingsPanel extends StatelessWidget {
  final CallerIdStyleProvider styleProvider;

  const PositionSettingsPanel({super.key, required this.styleProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPositionSlider('名称位置', styleProvider.nameOffset),
        _buildPositionSlider('运营商位置', styleProvider.carrierOffset),
        _buildPositionSlider('国家位置', styleProvider.countryOffset),
        _buildPositionSlider('标签位置', styleProvider.labelsOffset),
        _buildPositionSlider('计数位置', styleProvider.countOffset),
      ],
    );
  }

  Widget _buildPositionSlider(String title, Offset offset) {
    return Column(
      children: [
        Slider(
          value: offset.dx,
          min: 0,
          max: 100,
          label: '$title X: ${offset.dx.round()}',
          onChanged: (x) => styleProvider.updateOffset(title, Offset(x, offset.dy)),
        ),
        Slider(
          value: offset.dy,
          min: 0,
          max: 100,
          label: '$title Y: ${offset.dy.round()}',
          onChanged: (y) => styleProvider.updateOffset(title, Offset(offset.dx, y)),
        ),
      ],
    );
  }
}