import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';

class FutureUtilsBinding extends HTExternalClass {
  FutureUtilsBinding() : super('FutureUtils');

  /// Executes the futures in queue, one after another. And returns their results
  Future<List> execute(List<dynamic> futures, {Duration? delay}) async {
    final results = [];
    for (var future in futures) {
      if (delay != null && futures.isNotEmpty && futures.first != future) {
        await Future.delayed(delay);
      }
      if (future is Future) {
        results.add(await future);
      } else if (future is HTFunction) {
        results.add(await future.call());
      } else {
        results.add(future);
      }
    }
    return results;
  }

  Future<List> chain(List<Future Function()> futures, {Duration? delay}) async {
    final results = <dynamic>[];
    for (final future in futures) {
      if (delay != null && futures.indexOf(future) > 0) {
        await Future.delayed(delay);
      }
      results.add(await future());
    }
    return results;
  }

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case "FutureUtils.delayed":
        return ({
          List? positionalArgs,
          Map? namedArgs,
        }) {
          final duration = (positionalArgs?.isNotEmpty == true && positionalArgs![0] is Duration)
              ? positionalArgs[0] as Duration
              : Duration.zero;
          final callback = positionalArgs != null && positionalArgs.length > 1 && positionalArgs[1] is HTFunction
              ? positionalArgs[1] as HTFunction
              : null;
          return Future.delayed(
            duration,
            callback != null ? () => callback.call() : null,
          );
        };
      case "FutureUtils.execute":
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) {
          final list = positionalArgs.isNotEmpty && positionalArgs[0] is List
              ? positionalArgs[0] as List
              : const [];
          return execute(
            list,
            delay: namedArgs['delay'] is Duration ? namedArgs['delay'] as Duration : null,
          );
        };
      case "FutureUtils.chain":
        return ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) {
          final list = positionalArgs.isNotEmpty && positionalArgs[0] is List
              ? positionalArgs[0] as List
              : const [];
          return chain(
            list.map((e) {
              return () async => e is HTFunction ? e.call() : e;
            }).toList(),
            delay: namedArgs['delay'] is Duration ? namedArgs['delay'] as Duration : null,
          );
        };
      default:
        throw HTError.undefined(id);
    }
  }
}
