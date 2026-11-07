import 'package:meta/meta.dart';

/// Entity representing citation metadata for a paper or book.
@immutable
class CitationItem {
  final String citeKey;
  final String title;
  final List<String> authors;
  final String journal;
  final int year;
  final String doi;
  final String url;

  const CitationItem({
    required this.citeKey,
    required this.title,
    required this.authors,
    this.journal = '',
    this.year = 2024,
    this.doi = '',
    this.url = '',
  });

  Map<String, dynamic> toJson() => {
        'citeKey': citeKey,
        'title': title,
        'authors': authors,
        'journal': journal,
        'year': year,
        'doi': doi,
        'url': url,
      };

  factory CitationItem.fromJson(Map<String, dynamic> json) => CitationItem(
        citeKey: json['citeKey'] as String,
        title: json['title'] as String? ?? '',
        authors: (json['authors'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        journal: json['journal'] as String? ?? '',
        year: json['year'] as int? ?? 2024,
        doi: json['doi'] as String? ?? '',
        url: json['url'] as String? ?? '',
      );
}
