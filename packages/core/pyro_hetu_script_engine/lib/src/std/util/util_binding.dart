import 'dart:math';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';

class UtilBinding extends HTExternalClass {
  UtilBinding() : super('Util');
  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Util.random':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) {
          if (positionalArgs.length < 2) return 0;
          final min = positionalArgs[0] as int;
          final max = positionalArgs[1] as int;
          if (max <= min) return min;
          return min + Random().nextInt(max - min);
        };
      case 'Util.weightedRandom':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) {
          if (positionalArgs.isEmpty) return null;
          final weights = positionalArgs[0];
          if (weights is! Map || weights.isEmpty) return null;

          int totalWeight = 0;
          weights.forEach((key, value) => totalWeight += (value as int));

          if (totalWeight <= 0) {
            return weights.keys.isNotEmpty ? weights.keys.first : null;
          }

          int randomValue = Random().nextInt(totalWeight);
          for (var entry in weights.entries) {
            randomValue -= (entry.value as int);
            if (randomValue < 0) return entry.key;
          }
          return weights.keys.isNotEmpty ? weights.keys.first : null;
        };
      default:
        throw HTError.undefined(id);
    }
  }
}
