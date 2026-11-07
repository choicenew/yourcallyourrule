import 'citation_item.dart';
import 'tokens.dart';

/// Formatter converting [CitationItem] to BibTeX, APA, or IEEE plain text strings.
class BibtexFormatter {
  static String format(CitationItem item, {String style = CitationStyleTokens.bibtex}) {
    if (style == CitationStyleTokens.apa) {
      final authorsStr = item.authors.join(', ');
      return '$authorsStr (${item.year}). ${item.title}. ${item.journal}.';
    } else if (style == CitationStyleTokens.ieee) {
      final authorsStr = item.authors.join(', ');
      return '$authorsStr, "${item.title}," ${item.journal}, ${item.year}.';
    }

    // Default: BibTeX
    final authorsBib = item.authors.join(' and ');
    final buffer = StringBuffer();
    buffer.writeln('@article{${item.citeKey},');
    buffer.writeln('  title={${item.title}},');
    buffer.writeln('  author={$authorsBib},');
    if (item.journal.isNotEmpty) buffer.writeln('  journal={${item.journal}},');
    buffer.writeln('  year={${item.year}},');
    if (item.doi.isNotEmpty) buffer.writeln('  doi={${item.doi}}');
    buffer.write('}');

    return buffer.toString();
  }
}
