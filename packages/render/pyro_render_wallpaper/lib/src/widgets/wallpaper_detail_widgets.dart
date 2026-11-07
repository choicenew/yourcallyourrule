import 'package:material_ui/material_ui.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 壁纸大图与应用预览 Header
class WallpaperDetailHeader extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onPreviewTap;

  const WallpaperDetailHeader({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onPreviewTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        GestureDetector(
          onTap: onPreviewTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: SafeImageBuilder.buildSafeCoverImage(
                url: imageUrl,
                fallbackWidget: Container(
                  color: colorScheme.surfaceContainerHigh,
                  child: Icon(Icons.image_rounded, size: 64, color: colorScheme.primary.withValues(alpha: 0.5)),
                ),
              ),
            ),
          ),
        ),
        if (title.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
          ),
        ],
      ],
    );
  }
}
