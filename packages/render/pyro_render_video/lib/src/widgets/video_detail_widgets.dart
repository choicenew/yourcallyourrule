import 'package:material_ui/material_ui.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 视频详情页 Header 封面与播放与标题栏
class VideoDetailHeader extends StatelessWidget {
  final String title;
  final String coverUrl;
  final String duration;
  final VoidCallback onPlayTap;

  const VideoDetailHeader({
    super.key,
    required this.title,
    required this.coverUrl,
    required this.duration,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SafeImageBuilder.buildSafeCoverImage(
                  url: coverUrl,
                  fallbackWidget: Container(
                    color: colorScheme.surfaceContainerHigh,
                    child: Icon(Icons.movie_rounded, size: 48, color: colorScheme.primary.withValues(alpha: 0.5)),
                  ),
                ),
              ),
            ),
            IconButton.filled(
              iconSize: 42,
              icon: const Icon(Icons.play_arrow_rounded),
              onPressed: onPlayTap,
            ),
            if (duration.isNotEmpty)
              Positioned(
                right: 12,
                bottom: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    duration,
                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
