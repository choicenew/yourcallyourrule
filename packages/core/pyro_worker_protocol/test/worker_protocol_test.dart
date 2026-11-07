import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_worker_protocol/pyro_worker_protocol.dart';

class _AddTenTask extends WorkerTask<int, int> {
  const _AddTenTask() : super(taskName: 'AddTenTask');

  @override
  int execute(int input) => input + 10;
}

class _EchoActor extends DedicatedActorWorker<String, String> {
  _EchoActor() : super(actorName: 'EchoActor');

  @override
  Future<void> onInitialize() async {}

  @override
  Future<String> onHandleMessage(String message) async {
    return 'Echo: $message';
  }

  @override
  Future<void> onDispose() async {}
}

void main() {
  test('WorkerTask executes properly through default dispatcher', () async {
    final result = await WorkerDispatcher.instance.execute(const _AddTenTask(), 32);
    expect(result, 42);
  });

  test('DedicatedActorWorker handles message across isolate channel', () async {
    final handle = await WorkerDispatcher.instance.spawnActor(_EchoActor());
    final response = await handle.send('PyroWorker');
    expect(response, 'Echo: PyroWorker');
    await handle.dispose();
  });
}
