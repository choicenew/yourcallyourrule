// Local database schema definition using drift
import 'dart:async';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:yourcallyourrule/features/labels/utils/predefined_labels.dart' as predefined;
import '../../../main.dart' show isOverlayMode;
import 'package:uuid/uuid.dart';

import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';

part 'local_database.g.dart';
part 'drift_migration_helper.dart';

/// 本地 Drift 数据库提供者
@Riverpod(keepAlive: true)
LocalDatabase localDatabase(Ref ref) {
  return LocalDatabase();
}

// Table definitions
@UseRowClass(ContactEntry)
class Contacts extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get phoneNumber => text().withLength(min: 1)();
  TextColumn get name => text().withLength(min: 1)();
  TextColumn get avatar => text().nullable()();
  TextColumn get url => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get labelIds => text().nullable()();
  IntColumn get isFavorite => integer().withDefault(const Constant(0))();
  TextColumn get lastUpdated => text().withLength(min: 1)();

  @override
  Set<Column> get primaryKey => {id};
}

@UseRowClass(CallLog)
class CallHistory extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get phoneNumber => text().withLength(min: 1)();
  TextColumn get name => text().nullable()();
  TextColumn get timestamp => text().withLength(min: 1)();
  TextColumn get endTime => text().nullable()();
  IntColumn get duration => integer().nullable()();
  TextColumn get simDisplayName => text().nullable()();
  TextColumn get callType => text().withLength(min: 1)();
  IntColumn get simSlotIndex => integer().nullable()();
  TextColumn get carrierName => text().nullable()();
  TextColumn get countryIso => text().nullable()();
  IntColumn get subscriptionId => integer().nullable()();
  TextColumn get labelIds => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseRowClass(PhoneRule)
class Rules extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get name => text().withLength(min: 1)();
  TextColumn get ruleType => text().withLength(min: 1)();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get labelId => text().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(5))();
  TextColumn get action => text().withDefault(const Constant('none'))();
  IntColumn get isEnabled => integer().withDefault(const Constant(1))();
  TextColumn get pattern => text().nullable()();
  TextColumn get avatar => text().nullable()();
  IntColumn get isSubscribed => integer().withDefault(const Constant(0))();
  IntColumn get count => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseRowClass(PhoneRule)
class PhoneRules extends Table {
  TextColumn get id => text().nullable()();
  TextColumn get name => text().withLength(min: 1)();
  TextColumn get ruleType => text().withLength(min: 1)();
  TextColumn get phoneNumber => text().withLength(min: 1)();
  TextColumn get labelId => text().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(5))();
  TextColumn get action => text().withDefault(const Constant('none'))();
  IntColumn get isEnabled => integer().withDefault(const Constant(1))();
  IntColumn get count => integer().withDefault(const Constant(0))();
  TextColumn get avatar => text().nullable()();
  TextColumn get subscriptionId => text().nullable()();

  @override
  Set<Column> get primaryKey => {phoneNumber};
}

@UseRowClass(RegexRule)
class RegexRules extends Table {
  TextColumn get id => text().nullable()();
  TextColumn get name => text().withLength(min: 1)();
  TextColumn get ruleType => text().withLength(min: 1)();
  TextColumn get pattern => text().withLength(min: 1)();
  IntColumn get priority => integer().withDefault(const Constant(5))();
  TextColumn get action => text().withDefault(const Constant('none'))();
  IntColumn get isEnabled => integer().withDefault(const Constant(1))();
  TextColumn get subscriptionId => text().nullable()();

  @override
  Set<Column> get primaryKey => {pattern};
}

@UseRowClass(Subscription)
class Subscriptions extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get name => text().withLength(min: 1)();
  TextColumn get url => text().withLength(min: 1)();
  TextColumn get tableType => text().withLength(min: 1)();
  IntColumn get isEnabled => integer().withDefault(const Constant(1))();
  TextColumn get lastUpdated => text().withLength(min: 1)();
  IntColumn get autoUpdate => integer().withDefault(const Constant(0))();
  TextColumn get contactGroup => text().nullable()();
  TextColumn get keywordFilters => text().nullable()();
  TextColumn get action => text().withDefault(const Constant('none'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SmsMessageData')
class Sms extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get phoneNumber => text().withLength(min: 1)();
  TextColumn get contactName => text().nullable()();
  TextColumn get messageType => text().withLength(min: 1)();
  TextColumn get content => text().withLength(min: 1)();
  TextColumn get timestamp => text().withLength(min: 1)();
  IntColumn get isRead => integer().withDefault(const Constant(0))();
  TextColumn get simInfo => text().nullable()();
  IntColumn get isMarked => integer().withDefault(const Constant(0))();
  TextColumn get labelIds => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseRowClass(SmsRegexRule)
class SmsRules extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get name => text().withLength(min: 1)();
  TextColumn get contentRegex => text().withLength(min: 1)();
  TextColumn get senderRegex => text().nullable()();
  TextColumn get action => text().withLength(min: 1)();
  IntColumn get priority => integer().withDefault(const Constant(5))();
  IntColumn get isEnabled => integer().withDefault(const Constant(1))();
  TextColumn get ruleType => text().withLength(min: 1)();

  @override
  Set<Column> get primaryKey => {id};
}

@UseRowClass(PluginEntry)
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

@UseRowClass(LocationEntry)
class Locations extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get phoneNumber => text().withLength(min: 1)();
  TextColumn get region => text().nullable()();
  TextColumn get countryName => text().nullable()();
  TextColumn get carrier => text().nullable()();
  IntColumn get numberType => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseRowClass(PredefinedLabelEntry)
class PredefinedLabels extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get labelText => text().withLength(min: 1)();
  TextColumn get avatar => text().nullable()();
  TextColumn get icon => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseRowClass(LabelPhoneEntry)
class LabelPhones extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get name => text().nullable()();
  TextColumn get icon => text().nullable()();
  TextColumn get phoneNumber => text().withLength(min: 1)();
  TextColumn get labelId => text().withLength(min: 1)();
  TextColumn get avatar => text().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  TextColumn get action => text().withDefault(const Constant('none'))();
  IntColumn get isEnabled => integer().withDefault(const Constant(1))();
  TextColumn get ruleType => text().withDefault(const Constant('label'))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseRowClass(SimSlotRule)
class SimSlotRules extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get name => text().withLength(min: 1)();
  IntColumn get priority => integer()();
  TextColumn get action => text().withLength(min: 1)();
  IntColumn get isEnabled => integer().withDefault(const Constant(1))();
  TextColumn get phoneNumber => text().withLength(min: 1)();
  IntColumn get simSlotIndex => integer()();
  TextColumn get labelId => text().withLength(min: 1)();
  TextColumn get avatar => text().nullable()();
  TextColumn get ruleType => text().withDefault(const Constant('simSlot'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LabelMarkStatisticData')
class LabelMarkStatistics extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get phoneNumber => text().withLength(min: 1)();
  TextColumn get labelId => text().withLength(min: 1)();
  TextColumn get markedAt => text().withLength(min: 1)();
  IntColumn get isCounted => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UserMarkCountData')
class UserMarkCount extends Table {
  TextColumn get id => text().withLength(min: 1)();
  IntColumn get totalCount => integer().withDefault(const Constant(0))();
  TextColumn get lastUpdated => text().withLength(min: 1)();

  @override
  Set<Column> get primaryKey => {id};
}

// Database class
@DriftDatabase(
  tables: [
    Contacts,
    CallHistory,
    Rules,
    PhoneRules,
    RegexRules,
    Subscriptions,
    Sms,
    SmsRules,
    Plugins,
    Locations,
    PredefinedLabels,
    LabelPhones,
    SimSlotRules,
    LabelMarkStatistics,
    UserMarkCount,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();

  factory LocalDatabase() => _instance;

  @override
  int get schemaVersion => 4;

  LocalDatabase._internal() : super(_openConnection());

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'local_database.db'));
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

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();

      await batch((batch) {
        final labelsToInsert =
            predefined.predefinedLabels
                .map((labelMap) {
                  final text = labelMap['text'] as String?;
                  if (text == null || text.isEmpty) {
                    return null;
                  }

                  var id = text
                      .toLowerCase()
                      .replaceAll(' ', '_')
                      .replaceAll(RegExp(r'[^a-z0-9_]'), '');

                  if (id.isEmpty) {
                    id = const Uuid().v4();
                  }

                  return PredefinedLabelsCompanion.insert(
                    id: id,
                    labelText: text,
                    avatar: Value(null),
                    icon: Value(null),
                  );
                })
                .whereType<PredefinedLabelsCompanion>()
                .toList();

        batch.insertAll(predefinedLabels, labelsToInsert);

        batch.insert(
          userMarkCount,
          UserMarkCountCompanion.insert(
            id: const Uuid().v4(),
            totalCount: const Value(0),
            lastUpdated: DateTime.now().toIso8601String(),
          ),
        );
      });
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await _DriftMigrationHelper.upgradeFrom1To2(m, this);
      }

      if (from < 3) {
        await _DriftMigrationHelper.upgradeFrom2To3(m, this);
      }

      if (from < 4) {
        await _DriftMigrationHelper.upgradeFrom3To4(m, this);
      }
    },
  );
}