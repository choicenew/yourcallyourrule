import 'package:material_ui/material_ui.dart';

/// Pure Bionic Reading algorithm and TextSpan generator.
class BionicReadingAlgorithm {
  /// Converts plain text into Bionic Reading TextSpan list.
  static List<TextSpan> generateBionicSpans(
    String text, {
    TextStyle? baseStyle,
    Color? boldColor,
  }) {
    if (text.isEmpty) return const [];

    final spans = <TextSpan>[];
    final wordsAndSpaces = text.split(RegExp(r'(\s+)'));

    final boldStyle = (baseStyle ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.bold,
      color: boldColor,
    );

    for (final token in wordsAndSpaces) {
      if (token.trim().isEmpty) {
        spans.add(TextSpan(text: token, style: baseStyle));
        continue;
      }

      final length = token.length;
      int boldLength = 1;
      if (length > 3) boldLength = (length * 0.4).ceil();

      final boldPart = token.substring(0, boldLength);
      final normalPart = token.substring(boldLength);

      spans.add(TextSpan(text: boldPart, style: boldStyle));
      if (normalPart.isNotEmpty) {
        spans.add(TextSpan(text: normalPart, style: baseStyle));
      }
    }

    return spans;
  }
}
