import 'dart:math' as math;
import 'package:material_ui/material_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';
import 'package:pyro_source_match/pyro_source_match.dart';
import 'package:pyro_viewer_hub/pyro_viewer_hub.dart';
import 'package:pyro_viewer_protocol/pyro_viewer_protocol.dart';

import 'l10n/generated/app_localizations.dart';
import 'widgets/audio_source_sheet.dart';

/// 音频/播客全屏深度落地播放与消费屏幕 (100% 强类型)
class AudioPlayerScreen extends StatefulWidget {
  final MediaEntity? entity;
  final Map<String, dynamic> params;

  const AudioPlayerScreen({
    super.key,
    this.entity,
    this.params = const {},
  });

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> with SingleTickerProviderStateMixin {
  late String _title;
  late String _artist;
  late String _album;
  late String _coverUrl;
  bool _isPlaying = false;
  double _progress = 0.0;
  double _speed = 1.0;
  bool _isLiked = false;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    final entity = widget.entity ?? MediaEntityMapper.fromMap(widget.params);

    _title = entity.title;
    _artist = AuthorFormatter.formatAuthorName(entity.creators, defaultName: '');
    _album = entity.album ?? entity.category ?? '';
    _coverUrl = entity.coverUrl ?? entity.thumbUrl ?? entity.contentUrl;

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _rotationController.repeat();
      } else {
        _rotationController.stop();
      }
    });
    debugPrint('Audio playback toggled: isPlaying=$_isPlaying');
  }

  void _cycleSpeed() {
    setState(() {
      if (_speed == 1.0) {
        _speed = 1.25;
      } else if (_speed == 1.25) {
        _speed = 1.5;
      } else if (_speed == 1.5) {
        _speed = 2.0;
      } else {
        _speed = 1.0;
      }
    });
    debugPrint('Audio playback speed set to: ${_speed}x');
  }

  void _openSourceSheet() {
    final swapper = SiblingsSwapper(
      activeCandidate: {
        'id': 'cand_1',
        'title': '$_title (Official Audio)',
        'artists': [_artist],
      },
      siblings: [
        {
          'id': 'cand_2',
          'title': '$_title (Live Version)',
          'artists': [_artist],
        },
        {
          'id': 'cand_3',
          'title': '$_title (Acoustic Cover)',
          'artists': ['Cover Artist'],
        },
      ],
    );

    AudioSourceSheet.show(
      context,
      swapper: swapper,
      onSelectCandidate: (index) {
        debugPrint('Swapped audio source candidate to index: $index');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String rawPath = widget.entity?.contentUrl ?? '';

    if (rawPath.isNotEmpty) {
      final cleanPath = sanitizePhysicalPath(rawPath);
      if (ViewerHub.instance.supports(cleanPath)) {
        final viewerWidget = ViewerHub.instance.buildViewer(
          context,
          cleanPath,
          entity: widget.entity,
        );
        if (viewerWidget != null) {
          return viewerWidget;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _album.isNotEmpty ? _album : _title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            tooltip: AppLocalizations.of(context)?.play,
            onPressed: _openSourceSheet,
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: AppLocalizations.of(context)?.share,
            onPressed: () {
              debugPrint('Share audio track: $_title');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 1),

            Center(
              child: AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationController.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.25),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                    border: Border.all(color: Colors.white24, width: 4),
                  ),
                  child: ClipOval(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (_coverUrl.isNotEmpty)
                          Image.network(
                            _coverUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _buildFallbackVinyl(),
                          )
                        else
                          _buildFallbackVinyl(),

                        Center(
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.colorScheme.surfaceContainerHigh,
                              border: Border.all(color: Colors.black45, width: 3),
                            ),
                            child: Center(
                              child: Icon(Icons.music_note, size: 20, color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(flex: 1),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    _title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (_artist.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      _artist,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),

            const Spacer(flex: 1),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    ),
                    child: Slider(
                      value: _progress,
                      onChanged: (val) {
                        setState(() {
                          _progress = val;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_progress * 240),
                          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                        Text(
                          _formatDuration(240),
                          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.red : null,
                    ),
                    tooltip: AppLocalizations.of(context)?.like,
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked;
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 36,
                    icon: const Icon(Icons.skip_previous_rounded),
                    tooltip: AppLocalizations.of(context)?.play,
                    onPressed: () {},
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary,
                    ),
                    child: IconButton(
                      iconSize: 42,
                      color: theme.colorScheme.onPrimary,
                      icon: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
                      tooltip: AppLocalizations.of(context)?.play,
                      onPressed: _togglePlayPause,
                    ),
                  ),
                  IconButton(
                    iconSize: 36,
                    icon: const Icon(Icons.skip_next_rounded),
                    tooltip: AppLocalizations.of(context)?.play,
                    onPressed: () {},
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: _cycleSpeed,
                    child: Text(
                      '${_speed}x',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackVinyl() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0xFF2C2C38), Color(0xFF101016)],
          stops: [0.3, 1.0],
        ),
      ),
      child: const Center(
        child: Icon(Icons.album_rounded, size: 72, color: Colors.white24),
      ),
    );
  }

  String _formatDuration(double totalSeconds) {
    final int sec = totalSeconds.toInt();
    final int m = sec ~/ 60;
    final int s = sec % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
