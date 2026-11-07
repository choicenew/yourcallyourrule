import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'task.dart';
import 'actor.dart';
import 'dispatcher.dart';

/// 协议内置的自适应默认调度器 (开箱即用，单测与默认场景免配置)
class DefaultAdaptiveWorkerDispatcher implements WorkerDispatcher {
  @override
  Future<Output> execute<Input, Output>(WorkerTask<Input, Output> task, Input input) async {
    try {
      return await Isolate.run(() => task.execute(input));
    } catch (e, stack) {
      debugPrint('❌ [WorkerDispatcher] 任务 ${task.taskName} 在副线程执行失败: $e\n$stack');
      rethrow;
    }
  }

  @override
  Future<ActorHandle<Req, Resp>> spawnActor<Req, Resp>(DedicatedActorWorker<Req, Resp> actor) async {
    final initPort = ReceivePort();
    await Isolate.spawn(_actorIsolateEntryPoint, _ActorInitPayload(initPort.sendPort, actor));
    final sendPort = await initPort.first as SendPort;
    return _DefaultActorHandle<Req, Resp>(sendPort);
  }
}

class _ActorInitPayload {
  final SendPort sendPort;
  final DedicatedActorWorker actor;
  _ActorInitPayload(this.sendPort, this.actor);
}

void _actorIsolateEntryPoint(_ActorInitPayload payload) async {
  final commandPort = ReceivePort();
  payload.sendPort.send(commandPort.sendPort);

  final actor = payload.actor;
  await actor.onInitialize();

  await for (final message in commandPort) {
    if (message is _ActorMessage) {
      try {
        final result = await actor.onHandleMessage(message.data);
        message.responsePort.send(_ActorResponse.success(result));
      } catch (e, stack) {
        message.responsePort.send(_ActorResponse.error(e.toString(), stack.toString()));
      }
    } else if (message == 'DISPOSE') {
      await actor.onDispose();
      commandPort.close();
      break;
    }
  }
}

class _ActorMessage {
  final dynamic data;
  final SendPort responsePort;
  _ActorMessage(this.data, this.responsePort);
}

class _ActorResponse {
  final dynamic data;
  final String? error;
  final String? stack;
  final bool isSuccess;

  _ActorResponse.success(this.data) : error = null, stack = null, isSuccess = true;
  _ActorResponse.error(this.error, this.stack) : data = null, isSuccess = false;
}

class _DefaultActorHandle<Req, Resp> implements ActorHandle<Req, Resp> {
  final SendPort _sendPort;
  bool _isDisposed = false;

  _DefaultActorHandle(this._sendPort);

  @override
  Future<Resp> send(Req message) async {
    if (_isDisposed) {
      throw StateError('Actor handle has already been disposed.');
    }
    final responsePort = ReceivePort();
    _sendPort.send(_ActorMessage(message, responsePort.sendPort));
    final response = await responsePort.first as _ActorResponse;
    if (response.isSuccess) {
      return response.data as Resp;
    } else {
      throw StateError('Actor error: ${response.error}\n${response.stack}');
    }
  }

  @override
  Future<void> dispose() async {
    if (!_isDisposed) {
      _sendPort.send('DISPOSE');
      _isDisposed = true;
    }
  }
}
