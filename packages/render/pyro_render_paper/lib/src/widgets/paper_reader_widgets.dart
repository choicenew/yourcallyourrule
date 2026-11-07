import 'package:material_ui/material_ui.dart';

/// 学术阅读器章节与分段渲染器
class PaperReaderSectionContent extends StatelessWidget {
  final String title;
  final String text;

  const PaperReaderSectionContent({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              height: 1.7,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
