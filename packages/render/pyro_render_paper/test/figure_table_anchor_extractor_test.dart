import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_render_paper/src/figure_table_anchor_extractor.dart';

void main() {
  group('FigureTableAnchorExtractor Tests', () {
    test('Extracts Fig. and Table anchors from paper text', () {
      const text = 'As shown in Fig. 3, the loss curve drops rapidly. See Table 1 for hyperparameters.';
      final anchors = FigureTableAnchorExtractor.extractAnchors(text);

      expect(anchors.length, equals(2));
      expect(anchors.first.label, equals('Fig. 3'));
      expect(anchors.first.targetImageId, equals('fig_3'));
      expect(anchors.last.label, equals('Table 1'));
    });
  });
}
