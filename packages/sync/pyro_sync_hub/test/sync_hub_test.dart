import 'package:test/test.dart';
import 'package:pyro_sync_protocol/pyro_sync_protocol.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';

class MockModel {
  final String id;
  final String val;
  MockModel(this.id, this.val);
}

class MockSyncDataAdapter implements SyncDataAdapter<MockModel> {
  final List<MockModel> db = [];
  bool watchChangesCalled = false;

  @override
  String get moduleId => 'mock_module';

  @override
  Future<List<MockModel>> readAll() async => db;

  @override
  Future<void> overwriteAll(List<dynamic> items) async {
    db.clear();
    db.addAll(List<MockModel>.from(items));
  }

  @override
  Stream<MockModel> watchChanges() async* {
    watchChangesCalled = true;
    for (final item in db) {
      yield item;
    }
  }

  @override
  Future<void> upsert(MockModel item) async {
    db.removeWhere((x) => x.id == item.id);
    db.add(item);
  }

  @override
  Map<String, dynamic> toJson(MockModel item) => {'id': item.id, 'val': item.val};

  @override
  MockModel fromJson(Map<String, dynamic> json) => MockModel(json['id'] as String, json['val'] as String);
}

void main() {
  setUp(() {
    SyncHub.instance.clear();
  });

  test('SyncHub register & unregister', () {
    final adapter = MockSyncDataAdapter();
    expect(SyncHub.instance.isRegistered('mock_module'), isFalse);

    SyncHub.instance.register(adapter);
    expect(SyncHub.instance.isRegistered('mock_module'), isTrue);
    expect(SyncHub.instance.registeredModuleIds, contains('mock_module'));

    SyncHub.instance.unregister('mock_module');
    expect(SyncHub.instance.isRegistered('mock_module'), isFalse);
  });

  test('SyncHub getAdapter', () async {
    final adapter = MockSyncDataAdapter();
    SyncHub.instance.register(adapter);

    final fetched = SyncHub.instance.getAdapter<MockModel>('mock_module');
    expect(fetched, isNotNull);
    expect(fetched!.moduleId, equals('mock_module'));

    await fetched.overwriteAll([MockModel('1', 'hello')]);
    final data = await fetched.readAll();
    expect(data.length, equals(1));
    expect(data[0].val, equals('hello'));
  });
}
