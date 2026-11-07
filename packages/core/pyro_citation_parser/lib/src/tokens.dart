import 'package:meta/meta.dart';

/// Tokens representing citation formatting styles.
@immutable
abstract class CitationStyleTokens {
  static const String bibtex = 'bibtex';
  static const String apa = 'apa';
  static const String ieee = 'ieee';
  static const String harvard = 'harvard';
}
