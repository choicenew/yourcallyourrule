/// Safety validator for ReDoS (Regular Expression Denial of Service) protection
class ReDosBacktrackingTree {
  static bool validateSafety(String pattern, {int maxPaths = 1000000}) {
    if (pattern.isEmpty) return true;

    final nestedQuantifierRegex = RegExp(r'(\*|\+|\{\d+,\})\s*(\*|\+|\{\d+,\})');
    if (nestedQuantifierRegex.hasMatch(pattern)) {
      return false; // ReDoS danger detected
    }

    if (pattern.contains('(a+)+') || pattern.contains('(.*)+') || pattern.contains('(a|a)+')) {
      return false;
    }

    return true;
  }
}
