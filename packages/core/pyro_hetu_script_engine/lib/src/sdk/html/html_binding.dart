import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';

class HtmlBinding extends HTExternalClass {
  HtmlBinding() : super('Html');
  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    if (id == 'Html.parse') {
      return ({List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {}}) {
        if (positionalArgs.isEmpty) return null;
        final html = positionalArgs[0]?.toString() ?? '';
        return DocumentBinding(html_parser.parse(html));
      };
    }
    throw HTError.undefined(id);
  }
}

class DocumentBinding extends HTExternalClass {
  final dom.Document _document;
  DocumentBinding(this._document) : super('Document');
  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    if (id == 'querySelector') {
      return ({List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {}}) {
        if (positionalArgs.isEmpty) return null;
        final selector = positionalArgs[0]?.toString();
        if (selector == null) return null;
        final element = _document.querySelector(selector);
        return element != null ? ElementBinding(element) : null;
      };
    }
    if (id == 'querySelectorAll') {
      return ({List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {}}) {
        if (positionalArgs.isEmpty) return [];
        final selector = positionalArgs[0]?.toString();
        if (selector == null) return [];
        final elements = _document.querySelectorAll(selector);
        return elements.map((e) => ElementBinding(e)).toList();
      };
    }
    if (id == 'body') {
      final body = _document.body;
      return body != null ? ElementBinding(body) : null;
    }
    if (id == 'head') {
      final head = _document.head;
      return head != null ? ElementBinding(head) : null;
    }
    throw HTError.undefined(id);
  }
}

class DocumentClassBinding extends HTExternalClass {
  DocumentClassBinding() : super('Document');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    throw HTError.undefined(id);
  }

  @override
  dynamic instanceMemberGet(dynamic instance, String id, {bool ignoreUndefined = false}) {
    if (instance is DocumentBinding) {
      return instance.memberGet(id);
    }
    throw HTError.undefined(id);
  }
}

class ElementBinding extends HTExternalClass {
  final dom.Element _element;
  ElementBinding(this._element) : super('Element');
  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'attr':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) {
          if (positionalArgs.isEmpty) return null;
          final name = positionalArgs[0]?.toString();
          if (name == null) return null;
          return _element.attributes[name];
        };
      case 'getAttribute':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) {
          if (positionalArgs.isEmpty) return null;
          final name = positionalArgs[0]?.toString();
          if (name == null) return null;
          return _element.attributes[name];
        };
      case 'text':
        return _element.text;
      case 'innerHtml':
        return _element.innerHtml;
      case 'outerHtml':
        return _element.outerHtml;
      case 'querySelector':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) {
          if (positionalArgs.isEmpty) return null;
          final selector = positionalArgs[0]?.toString();
          if (selector == null) return null;
          final result = _element.querySelector(selector);
          return result != null ? ElementBinding(result) : null;
        };
      case 'querySelectorAll':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) {
          if (positionalArgs.isEmpty) return [];
          final selector = positionalArgs[0]?.toString();
          if (selector == null) return [];
          return _element
              .querySelectorAll(selector)
              .map((e) => ElementBinding(e))
              .toList();
        };
      case 'attributes':
        return _element.attributes;
      case 'className':
        return _element.className;
      case 'id':
        return _element.id;
      case 'parent':
        final parent = _element.parent;
        return parent != null ? ElementBinding(parent) : null;
      case 'children':
        return _element.children.map((e) => ElementBinding(e)).toList();
      default:
        throw HTError.undefined(id);
    }
  }
}

class ElementClassBinding extends HTExternalClass {
  ElementClassBinding() : super('Element');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    throw HTError.undefined(id);
  }

  @override
  dynamic instanceMemberGet(dynamic instance, String id, {bool ignoreUndefined = false}) {
    if (instance is ElementBinding) {
      return instance.memberGet(id);
    }
    throw HTError.undefined(id);
  }
}
