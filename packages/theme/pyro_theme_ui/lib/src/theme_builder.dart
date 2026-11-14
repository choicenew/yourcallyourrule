import 'package:material_ui/material_ui.dart';
import 'package:pyro_theme_hub/pyro_theme_hub.dart';

/// Builder widget that rebuilds MaterialApp whenever ThemeHub settings change.
class ThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData lightTheme, ThemeData darkTheme, ThemeMode themeMode) builder;

  const ThemeBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeHub.instance,
      builder: (context, _) {
        final palette = ThemeHub.instance.palette;
        final mode = ThemeHub.instance.themeMode.toFlutterThemeMode();

        return builder(
          context,
          palette.buildLightData(),
          palette.buildDarkData(),
          mode,
        );
      },
    );
  }
}
