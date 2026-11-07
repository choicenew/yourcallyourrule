import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';

/// 壁纸深度全屏大图预览与消费屏幕 (100% 强类型)
class WallpaperPreviewScreen extends StatefulWidget {
  final MediaEntity entity;

  const WallpaperPreviewScreen({
    super.key,
    required this.entity,
  });

  @override
  State<WallpaperPreviewScreen> createState() => _WallpaperPreviewScreenState();
}

class _WallpaperPreviewScreenState extends State<WallpaperPreviewScreen> {
  late String _title;
  late String _imageUrl;
  late String _resolution;
  late String _contentId;
  bool _showControls = true;
  bool _isLiked = false;
  final TransformationController _transformController = TransformationController();

  @override
  void initState() {
    super.initState();
    _title = widget.entity.title;
    _imageUrl = widget.entity.contentUrl.isNotEmpty
        ? widget.entity.contentUrl
        : (widget.entity.coverUrl ?? widget.entity.thumbUrl ?? '');
    _resolution = widget.entity.resolution ?? '';
    _contentId = widget.entity.id;
  }

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  void _resetZoom() {
    _transformController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. 全屏可缩放大图展示区
          GestureDetector(
            onTap: _toggleControls,
            onDoubleTap: _resetZoom,
            child: InteractiveViewer(
              transformationController: _transformController,
              minScale: 1.0,
              maxScale: 4.0,
              child: Center(
                child: _imageUrl.isNotEmpty
                    ? Image.network(
                        _imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => _buildFallbackImage(),
                      )
                    : _buildFallbackImage(),
              ),
            ),
          ),

          // 2. 顶部悬浮栏
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: _showControls ? 0 : -100,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 4,
                bottom: 8,
                left: 8,
                right: 8,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (_resolution.isNotEmpty)
                          Text(
                            _resolution,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_outlined, color: Colors.white),
                    onPressed: () {
                      debugPrint('Share wallpaper: $_title');
                    },
                  ),
                ],
              ),
            ),
          ),

          // 3. 底部操作工具栏
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            bottom: _showControls ? 0 : -120,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 16,
                top: 16,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.85)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  IconButton.filledTonal(
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.redAccent : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked;
                      });
                    },
                  ),
                  const SizedBox(width: 12),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.download_rounded, color: Colors.white),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.wallpaper_rounded),
                      label: Text(
                        ActionLocalizerScope.translate(context, id: ActionId.apply.name, defaultText: ''),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      color: const Color(0xFF14141E),
      child: const Center(
        child: Icon(Icons.image_not_supported_outlined, size: 64, color: Colors.white24),
      ),
    );
  }
}
