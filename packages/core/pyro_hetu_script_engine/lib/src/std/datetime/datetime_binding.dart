import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';

extension DateTimeBindingExtension on DateTime {
  dynamic htFetch(String id) => switch (id) {
    'year' => year,
    'month' => month,
    'weekday' => weekday,
    'day' => day,
    'hour' => hour,
    'minute' => minute,
    'second' => second,
    'microsecond' => microsecond,
    'microsecondsSinceEpoch' => microsecondsSinceEpoch,
    'millisecond' => millisecond,
    'millisecondsSinceEpoch' => millisecondsSinceEpoch,
    'isUtc' => isUtc,
    'timeZoneName' => timeZoneName,
    'timeZoneOffset' => timeZoneOffset,
    'add' => (DateTime _, Duration duration) => add(duration),
    'subtract' => (DateTime _, Duration duration) => subtract(duration),
    'compareTo' => (DateTime _, DateTime other) => compareTo(other),
    'difference' => (DateTime _, DateTime other) => difference(other),
    'isAfter' => (DateTime _, DateTime other) => isAfter(other),
    'isBefore' => (DateTime _, DateTime other) => isBefore(other),
    'isAtSameMomentAs' => (DateTime _, DateTime other) => isAtSameMomentAs(other),
    'toLocal' => (DateTime _) => toLocal(),
    'toUtc' => (DateTime _) => toUtc(),
    'toIso8601String' => (DateTime _) => toIso8601String(),
    'toString' => (DateTime _) => toString(),
    _ => throw HTError.undefined(id),
  };
}

class DateTimeClassBinding extends HTExternalClass {
  DateTimeClassBinding() : super('DateTime');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) => switch (id) {
    'DateTime' =>
      ({List? positionalArgs, Map? namedArgs}) {
        final pos = positionalArgs ?? const [];
        return DateTime(
          pos.isNotEmpty && pos[0] is int ? pos[0] as int : DateTime.now().year,
          pos.length > 1 && pos[1] is int ? pos[1] as int : 1,
          pos.length > 2 && pos[2] is int ? pos[2] as int : 1,
          pos.length > 3 && pos[3] is int ? pos[3] as int : 0,
          pos.length > 4 && pos[4] is int ? pos[4] as int : 0,
          pos.length > 5 && pos[5] is int ? pos[5] as int : 0,
          pos.length > 6 && pos[6] is int ? pos[6] as int : 0,
          pos.length > 7 && pos[7] is int ? pos[7] as int : 0,
        );
      },
    'DateTime.now' =>
      ({List? positionalArgs, Map? namedArgs}) =>
          DateTime.now(),
    'DateTime.fromMillisecondsSinceEpoch' =>
      ({List? positionalArgs, Map? namedArgs}) {
        final ms = (positionalArgs?.isNotEmpty == true && positionalArgs![0] is int)
            ? positionalArgs[0] as int
            : 0;
        return DateTime.fromMillisecondsSinceEpoch(
          ms,
          isUtc: namedArgs?['isUtc'] ?? false,
        );
      },
    'DateTime.fromMicrosecondsSinceEpoch' =>
      ({List? positionalArgs, Map? namedArgs}) {
        final us = (positionalArgs?.isNotEmpty == true && positionalArgs![0] is int)
            ? positionalArgs[0] as int
            : 0;
        return DateTime.fromMicrosecondsSinceEpoch(
          us,
          isUtc: namedArgs?['isUtc'] ?? false,
        );
      },
    'DateTime.utc' =>
      ({List? positionalArgs, Map? namedArgs}) {
        final pos = positionalArgs ?? const [];
        return DateTime.utc(
          pos.isNotEmpty && pos[0] is int ? pos[0] as int : DateTime.now().year,
          pos.length > 1 && pos[1] is int ? pos[1] as int : 1,
          pos.length > 2 && pos[2] is int ? pos[2] as int : 1,
          pos.length > 3 && pos[3] is int ? pos[3] as int : 0,
          pos.length > 4 && pos[4] is int ? pos[4] as int : 0,
          pos.length > 5 && pos[5] is int ? pos[5] as int : 0,
          pos.length > 6 && pos[6] is int ? pos[6] as int : 0,
          pos.length > 7 && pos[7] is int ? pos[7] as int : 0,
        );
      },
    'DateTime.parse' =>
      ({List? positionalArgs, Map? namedArgs}) {
        final s = positionalArgs?.isNotEmpty == true ? positionalArgs![0]?.toString() ?? '' : '';
        return DateTime.parse(s);
      },
    _ => throw HTError.undefined(id),
  };

  @override
  dynamic instanceMemberGet(dynamic instance, String id, {bool ignoreUndefined = false}) =>
      (instance as DateTime).htFetch(id);
}

class DurationClassBinding extends HTExternalClass {
  DurationClassBinding() : super('Duration');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) => switch (id) {
    'Duration' =>
      ({List? positionalArgs, Map? namedArgs}) =>
          Duration(
            days: namedArgs?['days'] ?? 0,
            hours: namedArgs?['hours'] ?? 0,
            minutes: namedArgs?['minutes'] ?? 0,
            seconds: namedArgs?['seconds'] ?? 0,
            milliseconds: namedArgs?['milliseconds'] ?? 0,
            microseconds: namedArgs?['microseconds'] ?? 0,
          ),
    _ => throw HTError.undefined(id),
  };
}
