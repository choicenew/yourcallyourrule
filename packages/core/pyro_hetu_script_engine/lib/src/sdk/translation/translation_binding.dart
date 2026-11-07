import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import '../../../delegates/delegates.dart';

class TranslationBinding extends HTExternalClass {
  final TranslationDelegate _delegate;

  TranslationBinding(this._delegate) : super('Translate');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Translate.translate':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          final text = positionalArgs.isNotEmpty ? positionalArgs[0] : '';
          final target = namedArgs['target'] ?? 'en';
          final source = namedArgs['source'] ?? 'auto';
          return await _delegate.translate(text.toString(),
              targetLang: target, sourceLang: source);
        };
      default:
        throw HTError.undefined(id);
    }
  }
}
