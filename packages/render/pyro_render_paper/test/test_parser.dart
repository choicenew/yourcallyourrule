import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_render_paper/src/paper_translation_parser.dart';

void main() {
  test('PaperTranslationParser correctly parses title and abstract', () {
    const text = "标题：医疗保健中的人工智能:过去、现在和未来摘要：人工智能(AI)旨在模仿人类的认知功能。由于医疗保健数据可用性的增加和分析技术的快速发展，它正在为医疗保健带来范式转变。";
    final result = PaperTranslationParser.parse(text);
    expect(result.title, isNotEmpty);
    expect(result.abstractText, isNotEmpty);
  });
}
