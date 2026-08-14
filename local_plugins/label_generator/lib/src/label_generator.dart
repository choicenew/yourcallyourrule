import 'dart:async';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';

class LabelGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    // We manually iterate over top-level elements to find ones annotated with @AppLabel

    final buffer = StringBuffer();

    // Check top-level variables (like const Lists)
    // Note: library.allElements might be safer but library.element.topLevelVariables specifically targets what we need

    // We use dynamic to iterate because of analyzer version differences
    final topLevelVariables = (library.element as dynamic).topLevelVariables;

    for (final element in topLevelVariables) {
      if (_hasAppLabel(element)) {
        final output = _generateForElement(element);
        buffer.write(output);
      }
    }

    // Also check fields (if it's inside a class, but user used top level const)
    // The previous code targeted top level const.

    return buffer.toString();
  }

  bool _hasAppLabel(dynamic element) {
    try {
      if (element is Element) {
        const checker = TypeChecker.fromName('AppLabel');
        if (checker.hasAnnotationOf(element)) {
          return true;
        }
      }
    } catch (_) {}

    try {
      final metadata = (element as dynamic).metadata;
      final iterable = metadata is Iterable ? metadata : (metadata as dynamic).annotations;
      if (iterable is Iterable) {
        for (final meta in iterable) {
          final obj = (meta as dynamic).computeConstantValue();
          if (obj?.type?.element?.name == 'AppLabel') {
            return true;
          }
        }
      }
    } catch (_) {}

    return false;
  }

  String _generateForElement(dynamic element) {
    ConstantReader annotation;
    // We don't really need the annotation object content for AppLabel as it has no fields currently.
    // But if we did, we'd wrap it.

    DartObject? constantValue;
    try {
      constantValue = element.computeConstantValue();
    } catch (e) {
      // ignore
    }

    if (constantValue == null) {
      return '// Error: Could not compute constant value of ${element.name}.';
    }

    final listValue = constantValue.toListValue();
    if (listValue == null) {
      return '// Error: Annotated element ${element.name} is not a List.';
    }

    final buffer = StringBuffer();

    buffer.writeln('extension LabelTranslationExtension on String {');
    buffer.writeln('  String translate(BuildContext context) {');
    buffer
        .writeln('    final appLocalizations = AppLocalizations.of(context);');
    buffer.writeln('    if (appLocalizations == null) return this;');
    buffer.writeln();
    buffer.writeln(
        "    final normalizedLabel = toLowerCase().replaceAll(' ', '');");
    buffer.writeln();
    buffer.writeln('    switch (normalizedLabel) {');

    // Special overrides
    final overrides = {
      'Debt Collection': 'collection',
    };

    for (final item in listValue) {
      final mapValue = item.toMapValue();
      if (mapValue != null) {
        String? text;
        String? key;

        mapValue.forEach((k, v) {
          final kStr = k?.toStringValue();
          if (kStr == 'text') {
            text = v?.toStringValue();
          } else if (kStr == 'key') {
            key = v?.toStringValue();
          }
        });

        if (text != null) {
          final normalized = text!.toLowerCase().replaceAll(' ', '');

          String getterName;

          if (key != null) {
            getterName = key!;
          } else if (overrides.containsKey(text)) {
            getterName = overrides[text]!;
          } else {
            final parts = text!.split(' ');
            getterName = parts[0].toLowerCase();
            for (int i = 1; i < parts.length; i++) {
              if (parts[i].isEmpty) continue;
              getterName += parts[i][0].toUpperCase() +
                  parts[i].substring(1).toLowerCase();
            }
          }

          buffer.writeln("      case '$normalized':");
          buffer.writeln("        return appLocalizations.$getterName;");
        }
      }
    }

    buffer.writeln('      default:');
    buffer.writeln('        return this;');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }
}
