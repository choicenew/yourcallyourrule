import 'dart:async';
import 'package:test/test.dart';
import 'package:pyro_sync_protocol/pyro_sync_protocol.dart';

class TestTodo {
  final String id;
  final String title;
  final bool completed;

  TestTodo({
    required this.id,
    required this.title,
    required this.completed,
  });

  TestTodo copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return TestTodo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestTodo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          completed == other.completed;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ completed.hashCode;
}

class FakeTodoSyncAdapter implements SyncDataAdapter<TestTodo> {
  final List<TestTodo> db = [];
  final StreamController<TestTodo> _changeController =
      StreamController<TestTodo>.broadcast();

  @override
  String get moduleId => 'todo_module';

  @override
  String get providerId => 'todo_module';

  @override
  Future<List<TestTodo>> readAll() async {
    return List.unmodifiable(db);
  }

  @override
  Future<void> overwriteAll(List<dynamic> items) async {
    db.clear();
    db.addAll(List<TestTodo>.from(items));
  }

  @override
  Stream<TestTodo> watchChanges() {
    return _changeController.stream;
  }

  @override
  Future<void> upsert(TestTodo item) async {
    final index = db.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      db[index] = item;
    } else {
      db.add(item);
    }
    _changeController.add(item);
  }

  @override
  Map<String, dynamic> toJson(TestTodo item) {
    return {
      'id': item.id,
      'title': item.title,
      'completed': item.completed,
    };
  }

  @override
  TestTodo fromJson(Map<String, dynamic> json) {
    return TestTodo(
      id: json['id'] as String,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }

  void dispose() {
    _changeController.close();
  }
}

void main() {
  group('pyro_sync_protocol Tests', () {
    late FakeTodoSyncAdapter adapter;

    setUp(() {
      adapter = FakeTodoSyncAdapter();
    });

    tearDown(() {
      adapter.dispose();
    });

    test('FakeTodoSyncAdapter Basic Storage Tests', () async {
      final todo1 = TestTodo(id: '1', title: 'Task 1', completed: false);
      final todo2 = TestTodo(id: '2', title: 'Task 2', completed: true);
      await adapter.upsert(todo1);
      await adapter.upsert(todo2);

      final currentDb = await adapter.readAll();
      expect(currentDb.length, equals(2));
      expect(currentDb[0].id, equals('1'));
      expect(currentDb[1].id, equals('2'));
    });
  });
}
