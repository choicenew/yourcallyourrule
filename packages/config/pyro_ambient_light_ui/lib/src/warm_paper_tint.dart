import 'package:material_ui/material_ui.dart';

/// Warm paper tint color matrix generator for low blue-light eye protection.
class WarmPaperTint {
  /// Generates a 4x5 ColorFilter matrix for warm paper tint (reduces blue spectrum).
  static ColorFilter getWarmPaperFilter({double intensity = 0.3}) {
    final clamped = intensity.clamp(0.0, 1.0);
    final blueScale = 1.0 - (0.35 * clamped);
    final redScale = 1.0 + (0.05 * clamped);

    return ColorFilter.matrix([
      redScale, 0, 0, 0, 0,
      0, 1.0, 0, 0, 0,
      0, 0, blueScale, 0, 0,
      0, 0, 0, 1.0, 0,
    ]);
  }
}
