import 'package:test/test.dart';
import 'package:pyro_citation_parser/pyro_citation_parser.dart';

void main() {
  group('BibtexFormatter Tests', () {
    const item = CitationItem(
      citeKey: 'vaswani2017',
      title: 'Attention Is All You Need',
      authors: ['Ashish Vaswani', 'Noam Shazeer'],
      journal: 'NeurIPS',
      year: 2017,
      doi: '10.5555/3295222.3295349',
    );

    test('Formats BibTeX string accurately', () {
      final bib = BibtexFormatter.format(item, style: CitationStyleTokens.bibtex);
      expect(bib, contains('@article{vaswani2017,'));
      expect(bib, contains('title={Attention Is All You Need}'));
      expect(bib, contains('author={Ashish Vaswani and Noam Shazeer}'));
    });

    test('Formats APA string accurately', () {
      final apa = BibtexFormatter.format(item, style: CitationStyleTokens.apa);
      expect(apa, equals('Ashish Vaswani, Noam Shazeer (2017). Attention Is All You Need. NeurIPS.'));
    });

    test('Parses DOI URL correctly', () {
      final resolved = DoiResolver.parseDoiUrl('https://doi.org/10.1086/296260');
      expect(resolved.doi, equals('10.1086/296260'));
    });
  });
}
