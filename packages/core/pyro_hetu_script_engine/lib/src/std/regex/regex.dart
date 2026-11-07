class Regex implements Pattern {
  final RegExp _regex;

  Regex(
    String pattern, {
    bool caseSensitive = true,
    bool multiLine = false,
    bool dotAll = false,
    bool unicode = false,
  }) : _regex = RegExp(
          pattern,
          caseSensitive: caseSensitive,
          multiLine: multiLine,
          dotAll: dotAll,
          unicode: unicode,
        );

  static String escape(String input) {
    return RegExp.escape(input);
  }

  bool get isCaseSensitive => _regex.isCaseSensitive;
  bool get isMultiLine => _regex.isMultiLine;
  bool get isDotAll => _regex.isDotAll;
  bool get isUnicode => _regex.isUnicode;
  String get pattern => _regex.pattern;
  @override
  Match? matchAsPrefix(String input, [int start = 0]) {
    return _regex.matchAsPrefix(input, start);
  }

  RegExpMatch? firstMatch(String input) {
    return _regex.firstMatch(input);
  }

  String? stringMatch(String input) {
    final match = _regex.firstMatch(input);
    return match?.group(0);
  }

  @override
  List<RegExpMatch> allMatches(String input, [int start = 0]) {
    return _regex.allMatches(input, start).toList();
  }

  bool hasMatch(String input) {
    return _regex.hasMatch(input);
  }

  @override
  String toString() {
    return _regex.toString();
  }

  static List<String> splitString(String input, Regex pattern) {
    return input.split(pattern._regex);
  }
}
