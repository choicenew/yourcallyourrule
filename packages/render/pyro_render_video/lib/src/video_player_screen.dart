import 'package:material_ui/material_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';
import 'package:pyro_viewer_hub/pyro_viewer_hub.dart';
import 'package:pyro_viewer_protocol/pyro_viewer_protocol.dart';

/// 视频全屏深度落地播放与消费屏幕
class VideoPlayerScreen extends StatefulWidget {
  final MediaEntity? entity;
  final Map<String, dynamic> params;

  const VideoPlayerScreen({
    super.key,
    this.entity,
    this.params = const {},
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late MediaEntity _entity;
  late String _title;
  late String _author;
  late String _coverUrl;
  late String _description;
  bool _isPlaying = false;
  double _progress = 0.0;
  double _playbackSpeed = 1.0;
  String _selectedQuality = '1080P';
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _entity = widget.entity ?? MediaEntityMapper.fromMap(widget.params);

    _title = _entity.title;
    _author = AuthorFormatter.formatAuthorName(_entity.creators, defaultName: '');
    _coverUrl = _entity.coverUrl ?? _entity.thumbUrl ?? _entity.contentUrl;
    _description = _entity.description ?? '';
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    debugPrint('Video play status changed: isPlaying=$_isPlaying');
  }

  void _cycleSpeed() {
    setState(() {
      if (_playbackSpeed == 1.0) {
        _playbackSpeed = 1.5;
      } else if (_playbackSpeed == 1.5) {
        _playbackSpeed = 2.0;
      } else {
        _playbackSpeed = 1.0;
      }
    });
    debugPrint('Video playback speed: ${_playbackSpeed}x');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String rawPath = _entity.contentUrl;

    if (rawPath.isNotEmpty) {
      final cleanPath = sanitizePhysicalPath(rawPath);
      if (ViewerHub.instance.supports(cleanPath)) {
        final viewerWidget = ViewerHub.instance.buildViewer(
          context,
          cleanPath,
          entity: _entity,
        );
        if (viewerWidget != null) {
          return viewerWidget;
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (_coverUrl.isNotEmpty)
                    Image.network(
                      _coverUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildFallbackVideoBg(),
                    )
                  else
                    _buildFallbackVideoBg(),

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).maybePop(),
                        ),
                        Expanded(
                          child: Text(
                            _title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.share_outlined, color: Colors.white),
                          onPressed: () {
                            debugPrint('Share video: $_title');
                          },
                        ),
                      ],
                    ),
                  ),

                  Center(
                    child: IconButton(
                      iconSize: 56,
                      icon: Icon(
                        _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      onPressed: _togglePlayPause,
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 8,
                    right: 8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                            activeTrackColor: theme.colorScheme.primary,
                            inactiveTrackColor: Colors.white24,
                            thumbColor: theme.colorScheme.primary,
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
                          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(_progress * 300),
                                style: const TextStyle(color: Colors.white70, fontSize: 11),
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      minimumSize: Size.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: _cycleSpeed,
                                    child: Text(
                                      '${_playbackSpeed}x',
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  DropdownButton<String>(
                                    value: _selectedQuality,
                                    dropdownColor: Colors.grey[900],
                                    underline: const SizedBox.shrink(),
                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                    items: ['1080P', '720P', '480P'].map((q) {
                                      return DropdownMenuItem(value: q, child: Text(q));
                                    }).toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          _selectedQuality = val;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                color: theme.scaffoldBackgroundColor,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      _title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_author.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: theme.colorScheme.primaryContainer,
                            child: Text(
                              _author[0].toUpperCase(),
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _author,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          icon: Icon(
                            _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                            size: 16,
                            color: _isLiked ? theme.colorScheme.primary : null,
                          ),
                          label: Text(ActionLocalizerScope.translate(context, id: ActionId.like.name, defaultText: '')),
                          onPressed: () {
                            setState(() {
                              _isLiked = !_isLiked;
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        FilledButton.tonalIcon(
                          icon: const Icon(Icons.download_rounded, size: 16),
                          label: Text(ActionLocalizerScope.translate(context, id: ActionId.download.name, defaultText: '')),
                          onPressed: () {
                            debugPrint('Download video requested: $_title');
                          },
                        ),
                      ],
                    ),
                    if (_description.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        _description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.6,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackVideoBg() {
    return Container(
      color: const Color(0xFF14141E),
      child: const Center(
        child: Icon(Icons.movie_filter_rounded, size: 54, color: Colors.white24),
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
