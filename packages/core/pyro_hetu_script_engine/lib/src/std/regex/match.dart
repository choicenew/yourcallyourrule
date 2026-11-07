class ExpressionMatch implements RegExpMatch {
  final RegExpMatch _match;

  ExpressionMatch(this._match);

  @override
  String? namedGroup(String name) {
    return _match.namedGroup(name);
  }

  @override
  String? group(int index) {
    return _match.group(index);
  }

  @override
  List<String?> groups(List<int> indices) {
    return _match.groups(indices);
  }

  @override
  String? operator [](int group) {
    return _match[group];
  }

  @override
  int get start => _match.start;

  @override
  int get end => _match.end;

  @override
  int get groupCount => _match.groupCount;

  @override
  Iterable<String> get groupNames => _match.groupNames;

  @override
  String get input => _match.input;

  @override
  RegExp get pattern => _match.pattern;
}

class SimpleMatch implements Match {
  final Match _match;

  SimpleMatch(this._match);

  @override
  String? operator [](int group) {
    return _match[group];
  }

  @override
  int get start => _match.start;

  @override
  int get end => _match.end;

  @override
  String? group(int group) {
    return _match.group(group);
  }

  @override
  int get groupCount => _match.groupCount;

  @override
  List<String?> groups(List<int> groupIndices) {
    return _match.groups(groupIndices);
  }

  @override
  String get input => _match.input;

  @override
  Pattern get pattern => _match.pattern;
}
