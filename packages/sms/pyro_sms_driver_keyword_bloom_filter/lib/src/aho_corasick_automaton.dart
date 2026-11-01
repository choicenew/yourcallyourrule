import 'dart:collection';

class _AcNode {
  final Map<int, _AcNode> children = {};
  _AcNode? fail;
  final List<String> outputs = [];
}

/// Pure Dart Aho-Corasick Automaton for O(n) single-pass multi-pattern keyword search
class AhoCorasickAutomaton {
  final _AcNode _root = _AcNode();
  bool _isBuilt = false;

  void addKeyword(String keyword) {
    if (keyword.isEmpty) return;
    _AcNode curr = _root;
    for (final charCode in keyword.runes) {
      curr = curr.children.putIfAbsent(charCode, () => _AcNode());
    }
    curr.outputs.add(keyword);
    _isBuilt = false;
  }

  void build() {
    final queue = Queue<_AcNode>();

    for (final child in _root.children.values) {
      child.fail = _root;
      queue.add(child);
    }

    while (queue.isNotEmpty) {
      final curr = queue.removeFirst();

      curr.children.forEach((charCode, childNode) {
        _AcNode? failNode = curr.fail;
        while (failNode != null && !failNode.children.containsKey(charCode)) {
          failNode = failNode.fail;
        }
        childNode.fail = failNode?.children[charCode] ?? _root;
        childNode.outputs.addAll(childNode.fail!.outputs);
        queue.add(childNode);
      });
    }

    _isBuilt = true;
  }

  List<String> search(String text) {
    if (!_isBuilt) build();
    final results = <String>[];
    _AcNode curr = _root;

    for (final charCode in text.runes) {
      while (curr != _root && !curr.children.containsKey(charCode)) {
        curr = curr.fail ?? _root;
      }
      curr = curr.children[charCode] ?? _root;
      results.addAll(curr.outputs);
    }

    return results;
  }
}
