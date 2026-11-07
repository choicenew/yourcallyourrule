import 'package:material_ui/material_ui.dart';
import '../bionic_reading_algorithm.dart';

/// Widget rendering text formatted with Bionic Reading focal bolding.
class BionicTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool isBionicEnabled;

  const BionicTextWidget({
    super.key,
    required this.text,
    this.style,
    this.isBionicEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isBionicEnabled) {
      return Text(text, style: style);
    }

    final spans = BionicReadingAlgorithm.generateBionicSpans(
      text,
      baseStyle: style ?? Theme.of(context).textTheme.bodyMedium,
    );

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}
