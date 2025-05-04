import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';

class SizeSettingsPanel extends StatelessWidget {
  final CallerIdStyleProvider styleProvider;

  const SizeSettingsPanel({super.key, required this.styleProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSlider(
          '窗口宽度',
          styleProvider.windowWidth,
          200,
          500,
          (value) => styleProvider.setWindowWidth(value),
        ),
        _buildSlider(
          '窗口高度',
          styleProvider.windowHeight,
          300,
          800,
          (value) => styleProvider.setWindowHeight(value),
        ),
        _buildSlider(
          '头像尺寸',
          styleProvider.avatarSize,
          40,
          120,
          (value) => styleProvider.setAvatarSize(value),
        ),
        _buildSlider(
          '图标尺寸',
          styleProvider.iconSize,
          16,
          48,
          (value) => styleProvider.setIconSize(value),
        ),
      ],
    );
  }

  Widget _buildSlider(String title, double value, double min, double max, ValueChanged<double> onChanged) {
    return Slider(
      value: value,
      min: min,
      max: max,
      divisions: 10,
      label: '$title: ${value.round()}',
      onChanged: onChanged,
    );
  }
}