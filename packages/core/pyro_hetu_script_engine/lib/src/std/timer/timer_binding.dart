import 'dart:async';
import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';

extension TimerBinding on Timer {
  dynamic htFetch(String varName) {
    switch (varName) {
      case 'cancel':
        return ({positionalArgs, namedArgs}) =>
            cancel();
      case 'isActive':
        return isActive;
      case 'tick':
        return tick;
      default:
        throw HTError.undefined(varName);
    }
  }
}

class TimerClassBinding extends HTExternalClass {
  TimerClassBinding() : super('Timer');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Timer':
        return ({positionalArgs, namedArgs}) =>
            Timer(
              positionalArgs[0] == null
                  ? Duration.zero
                  : positionalArgs[0] as Duration, // Ensure Duration
              () => (positionalArgs[1] as HTFunction).call(),
            );
      case 'Timer.periodic':
        return ({positionalArgs, namedArgs}) =>
            Timer.periodic(
              positionalArgs[0] == null
                  ? Duration.zero
                  : positionalArgs[0] as Duration,
              (timer) => (positionalArgs[1] as HTFunction).call(
                positionalArgs: [timer], // Pass timer instance to callback
              ),
            );
      default:
        throw HTError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic instance, String id, {bool ignoreUndefined = false}) {
    return (instance as Timer).htFetch(id);
  }
}
