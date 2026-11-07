import 'package:material_ui/material_ui.dart';
import '../font_baseline_calibrator.dart';

/// Text widget with optical font baseline alignment for mixed Chinese, Japanese, Korean, and English text.
class CjkWesternTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CjkWesternTextWidget({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveStyle = FontBaselineCalibrator.calibrateTextStyle(
      style ?? theme.textTheme.bodyMedium!,
    );

    return Text(
      text,
      style: effectiveStyle,
    );
  }
}
