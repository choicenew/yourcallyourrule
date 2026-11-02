// Local database schema definition using drift
import 'dart:async';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'dart:io';

import '../../../main.dart' show isOverlayMode;

part 'local_database.g.dart';

@DataClassName('PluginData')
class Plugins extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get name => text().withLength(min: 1)();
  TextColumn get url => text().withLength(min: 1)();
  TextColumn get version => text().withLength(min: 1)();
  TextColumn get description => text().nullable()();
  IntColumn get isEnabled => integer().withDefault(const Constant(1))();
  IntColumn get pluginOrder => integer()();
  IntColumn get isAutoUpdate => integer().withDefault(const Constant(0))();
  TextColumn get configJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Plugins,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();

  factory LocalDatabase() => _instance;

  @override
  int get schemaVersion => 1;

  LocalDatabase._internal() : super(_openConnection());

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'plugin_demo_database.db'));
      return NativeDatabase(
        file,
        logStatements: false,
        setup: (db) {
          db.execute('PRAGMA foreign_keys = ON');
          if (isOverlayMode) {
            db.execute('PRAGMA query_only = ON');
          }
        },
      );
    });
  }
}
