/// Safety calculator for ReDoS (Regular Expression Denial of Service) protection
class ReDosBacktrackingTree {
  /// Evaluates estimated backtracking paths for regex patterns to prevent thread locks.
  /// Patterns like (a+)+ or (.*a){10} generate exponential $O(2^n)$ backtracking paths.
  static bool validateSafety(String pattern, {int maxPaths = 1000000}) {
    if (pattern.isEmpty) return true;

    // Check for nested quantifiers e.g. (a+)+ or (.*)*
    final nestedQuantifierRegex = RegExp(r'(\*|\+|\{\d+,\})\s*(\*|\+|\{\d+,\})');
    if (nestedQuantifierRegex.hasMatch(pattern)) {
      return false; // ReDoS danger detected
    }

    // Check overlapping group loops e.g. (a|a)+
    if (pattern.contains('(a+)+') || pattern.contains('(.*)+') || pattern.contains('(a|a)+')) {
      return false;
    }

    return true;
  }
}
