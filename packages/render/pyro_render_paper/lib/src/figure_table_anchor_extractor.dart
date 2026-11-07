import 'package:meta/meta.dart';

/// Entity representing an in-text figure or table reference in academic paper text.
@immutable
class PaperFigureAnchor {
  final String label; // e.g. "Fig. 1" or "Table 2"
  final int startOffset;
  final int endOffset;
  final String targetImageId;

  const PaperFigureAnchor({
    required this.label,
    required this.startOffset,
    required this.endOffset,
    required this.targetImageId,
  });
}

/// Extractor finding figure and table inline anchors in academic papers.
class FigureTableAnchorExtractor {
  static List<PaperFigureAnchor> extractAnchors(String paperText) {
    if (paperText.isEmpty) return const [];

    final RegExp regex = RegExp(r'(Fig\.|Figure|Table)\s*(\d+[a-z]?)', caseSensitive: false);
    final matches = regex.allMatches(paperText);
    final anchors = <PaperFigureAnchor>[];

    for (final match in matches) {
      final label = match.group(0) ?? '';
      final numPart = match.group(2) ?? '1';
      final imageId = 'fig_$numPart';

      anchors.add(PaperFigureAnchor(
        label: label,
        startOffset: match.start,
        endOffset: match.end,
        targetImageId: imageId,
      ));
    }

    return anchors;
  }
}
