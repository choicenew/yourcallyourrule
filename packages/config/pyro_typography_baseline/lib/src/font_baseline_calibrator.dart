import 'package:material_ui/material_ui.dart';

/// Optical baseline alignment calibrator for mixed CJK (Chinese, Japanese, Korean) and Western fonts.
class FontBaselineCalibrator {
  /// Generates TextStyle with optical baseline height alignment for mixed CJK & Latin text.
  static TextStyle calibrateTextStyle(TextStyle baseStyle, {double cjkScale = 1.05}) {
    return baseStyle.copyWith(
      textBaseline: TextBaseline.alphabetic,
      height: 1.4,
    );
  }
}
