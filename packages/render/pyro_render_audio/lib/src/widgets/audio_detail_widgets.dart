import 'package:material_ui/material_ui.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 音频播客详情 Header 专辑封面与播放栏
class AudioDetailHeader extends StatelessWidget {
  final String title;
  final String artist;
  final String coverUrl;
  final VoidCallback onPlayTap;

  const AudioDetailHeader({
    super.key,
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: 200,
            height: 200,
            child: SafeImageBuilder.buildSafeCoverImage(
              url: coverUrl,
              fallbackWidget: Container(
                color: colorScheme.surfaceContainerHigh,
                child: Icon(Icons.music_note_rounded, size: 64, color: colorScheme.primary),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        if (artist.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            artist,
            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 20),
        IconButton.filled(
          iconSize: 48,
          icon: const Icon(Icons.play_arrow_rounded),
          onPressed: onPlayTap,
        ),
      ],
    );
  }
}
