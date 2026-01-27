// Local database schema definition using drift
import 'dart:async';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'dart:io';

import '../../../main.dart' show isOverlayMode;
import 'package:uuid/uuid.dart';

part 'local_database.g.dart';
part 'drift_migration_helper.dart';

// Table definitions
@DataClassName('ContactData')
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

@DataClassName('CallHistoryData')
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

@DataClassName('RuleData')
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

@DataClassName('PhoneRuleData')
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

@DataClassName('RegexRuleData')
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

@DataClassName('SubscriptionData')
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

@DataClassName('SmsRuleData')
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

@DataClassName('LocationData')
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

@DataClassName('PredefinedLabelData')
class PredefinedLabels extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get labelText => text().withLength(min: 1)();
  TextColumn get avatar => text().nullable()();
  TextColumn get icon => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LabelPhoneData')
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

@DataClassName('SimSlotRuleData')
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
  // Singleton instance
  static final LocalDatabase _instance = LocalDatabase._internal();

  // Stream controllers for table changes
  final Map<String, StreamController<List<Map<String, dynamic>>>>
  _tableControllers = {};

  // Factory constructor
  factory LocalDatabase() => _instance;

  // Database version
  @override
  int get schemaVersion => 4;

  // Internal constructor
  LocalDatabase._internal() : super(_openConnection());

  // Open connection
  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'local_database.db'));
      return NativeDatabase(
        file,

        logStatements: false,
        setup: (db) {
          db.execute('PRAGMA foreign_keys = ON');
          // 【关键改动在这里】
          // 如果是 Overlay 模式，就将此连接设置为只读
 
 
 
        },
      );
    });
  }

  // Migration
 
 
 
 

 
 
 
 
 
 
 
 
 
 

 
 
 
 

 
 
 
 
 

 
 
 
 

 
 
 
 
 
 
 
 
 
 
 
 
 

 
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

 
 
 
 
 
 

 
 
 
 
 
 
 
}
