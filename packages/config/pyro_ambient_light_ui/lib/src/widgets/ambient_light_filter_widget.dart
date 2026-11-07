import 'package:material_ui/material_ui.dart';
import '../warm_paper_tint.dart';

/// Filter widget applying low blue-light warm paper tint to child readers.
class AmbientLightFilterWidget extends StatelessWidget {
  final Widget child;
  final bool isWarmTintEnabled;
  final double intensity;

  const AmbientLightFilterWidget({
    super.key,
    required this.child,
    this.isWarmTintEnabled = true,
    this.intensity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    if (!isWarmTintEnabled) return child;

    return ColorFiltered(
      colorFilter: WarmPaperTint.getWarmPaperFilter(intensity: intensity),
      child: child,
    );
  }
}
