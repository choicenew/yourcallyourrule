import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'match.dart';
import 'regex.dart';

extension ExpressionMatchBinding on ExpressionMatch {
  dynamic htFetch(String id) {
    return switch (id) {
      "start" => start,
      "end" => end,
      "group" => (ExpressionMatch _, int index) => group(index),
      "groupCount" => groupCount,
      "input" => input,
      "namedGroup" => (ExpressionMatch _, String name) => namedGroup(name),
      _ => throw HTError.undefined(id),
    };
  }
}

class ExpressionMatchClassBinding extends HTExternalClass {
  ExpressionMatchClassBinding() : super("ExpressionMatch");

  @override
  dynamic memberGet(String id,
      {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    throw HTError.undefined(id);
  }

  @override
  dynamic instanceMemberGet(dynamic instance, String id,
      {bool ignoreUndefined = false}) {
    return (instance as ExpressionMatch).htFetch(id);
  }

  @override
  instanceSubGet(dynamic instance, dynamic key) {
    return (instance as ExpressionMatch)[key as int];
  }
}

extension SimpleMatchBinding on SimpleMatch {
  dynamic htFetch(String id) {
    return switch (id) {
      "start" => start,
      "end" => end,
      "group" => (SimpleMatch _, int index) => group(index),
      "groups" => (SimpleMatch _, List indices) =>
          groups(indices.cast<int>()),
      "input" => input,
      _ => throw HTError.undefined(id),
    };
  }
}

class SimpleMatchClassBinding extends HTExternalClass {
  SimpleMatchClassBinding() : super("SimpleMatch");

  @override
  dynamic memberGet(String id,
      {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    throw HTError.undefined(id);
  }

  @override
  dynamic instanceMemberGet(dynamic instance, String id,
      {bool ignoreUndefined = false}) {
    return (instance as SimpleMatch).htFetch(id);
  }

  @override
  instanceSubGet(dynamic instance, dynamic key) {
    return (instance as SimpleMatch)[key as int];
  }
}

extension RegexBinding on Regex {
  dynamic htFetch(String id) {
    return switch (id) {
      "isCaseSensitive" => isCaseSensitive,
      "isMultiLine" => isMultiLine,
      "isUnicode" => isUnicode,
      "isDotAll" => isDotAll,
      "pattern" => pattern,
      "hasMatch" => (Regex _, String input) => hasMatch(input),
      "firstMatch" => (Regex _, String input) {
          final match = firstMatch(input);
          return match != null ? ExpressionMatch(match) : null;
        },
      "allMatches" => (Regex _, String input, [int start = 0]) =>
          allMatches(input, start).map((match) => ExpressionMatch(match)).toList(),
      "matchAsPrefix" => (Regex _, String input, [int start = 0]) {
          final match = matchAsPrefix(input, start);
          return match != null ? SimpleMatch(match) : null;
        },
      "stringMatch" => (Regex _, String input) => stringMatch(input),
      _ => throw HTError.undefined(id),
    };
  }
}

class RegexClassBinding extends HTExternalClass {
  RegexClassBinding() : super("Regex");

  @override
  dynamic memberGet(String id,
      {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    return switch (id) {
      "Regex" => ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) {
          final pattern = positionalArgs[0] as String;
          return Regex(
            pattern,
            caseSensitive: namedArgs["caseSensitive"] ?? true,
            multiLine: namedArgs["multiLine"] ?? false,
            unicode: namedArgs["unicode"] ?? false,
            dotAll: namedArgs["dotAll"] ?? false,
          );
        },
      "Regex.escape" => ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) =>
            Regex.escape(positionalArgs[0] as String),
      "Regex.splitString" => ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) =>
            Regex.splitString(
                positionalArgs[0] as String, positionalArgs[1] as Regex),
      _ => throw HTError.undefined(id),
    };
  }

  @override
  dynamic instanceMemberGet(dynamic instance, String id,
      {bool ignoreUndefined = false}) {
    return (instance as Regex).htFetch(id);
  }
}
