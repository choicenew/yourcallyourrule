import 'package:material_ui/material_ui.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_render_protocol/pyro_render_protocol.dart';
import 'package:pyro_viewer_hub/pyro_viewer_hub.dart';
import 'package:pyro_viewer_protocol/pyro_viewer_protocol.dart';
import 'package:share_plus/share_plus.dart';

import 'widgets/paper_reader_widgets.dart';

/// 学术文献深度阅读与消费屏幕 (100% MediaEntity 强类型，支持本地 PDF/EPUB/TXT 原生渲染)
class PaperReaderScreen extends StatefulWidget {
  final MediaEntity? entity;
  final Map<String, dynamic> params;

  const PaperReaderScreen({
    super.key,
    this.entity,
    this.params = const {},
  });

  @override
  State<PaperReaderScreen> createState() => _PaperReaderScreenState();
}

class _PaperReaderScreenState extends State<PaperReaderScreen> {
  late MediaEntity _entity;
  late String _title;
  late String _authors;
  late String _abstractText;
  late String _url;

  @override
  void initState() {
    super.initState();
    _entity = widget.entity ?? MediaEntityMapper.fromMap(widget.params);

    _title = _entity.title;
    _authors = AuthorFormatter.formatAuthorName(_entity.creators, defaultName: '');
    _abstractText = _entity.abstract ?? _entity.description ?? '';
    _url = _entity.contentUrl;
  }

  void _sharePaper() {
    Share.share('$_title\n$_authors\n$_url');
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
          return Scaffold(
            appBar: AppBar(
              title: Text(_title),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share_rounded),
                  onPressed: _sharePaper,
                ),
              ],
            ),
            body: viewerWidget,
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: _sharePaper,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          PaperReaderSectionContent(
            title: _title,
            text: _abstractText,
          ),
        ],
      ),
    );
  }
}
