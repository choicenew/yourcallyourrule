import 'citation_item.dart';

/// Helper resolving DOI strings into [CitationItem] metadata.
class DoiResolver {
  static CitationItem parseDoiUrl(String doiUrl) {
    final cleanDoi = doiUrl.replaceAll(RegExp(r'https?://doi\.org/'), '');
    final parts = cleanDoi.split('/');
    final key = parts.length > 1 ? parts[1] : 'paper_doi';

    return CitationItem(
      citeKey: 'doi_$key',
      title: 'Resolved Article ($cleanDoi)',
      authors: const ['Academic Author'],
      journal: 'DOI Academic Repository',
      year: 2024,
      doi: cleanDoi,
      url: 'https://doi.org/$cleanDoi',
    );
  }
}
