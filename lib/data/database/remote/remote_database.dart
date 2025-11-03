// Remote database schema definition using drift
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/main.dart' show isOverlayMode;

part 'remote_database.g.dart';

// Table definitions
@DataClassName('RemoteNumberData')
class RemoteNumbers extends Table {
  TextColumn get id => text().unique()();
  TextColumn get phoneNumber => text()();
  TextColumn get name => text().nullable()();
  TextColumn get label => text()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  TextColumn get action => text().withDefault(const Constant('none'))();
  IntColumn get count => integer().withDefault(const Constant(0))();
  TextColumn get labels_json => text().nullable()();

  @override
  Set<Column> get primaryKey => {phoneNumber};
}

@DataClassName('NumberCountryData')
class NumberCountries extends Table {
  TextColumn get phoneNumber => text().references(RemoteNumbers, #phoneNumber, onDelete: KeyAction.cascade)();
  TextColumn get countryIsoCode => text()();

  @override
  Set<Column> get primaryKey => {phoneNumber, countryIsoCode};
}

@DataClassName('PendingOperationData')
class PendingOperations extends Table {
  TextColumn get id => text()();
  TextColumn get entityId => text()(); // This is now phoneNumber
  TextColumn get operation => text()();
  TextColumn get payload => text().nullable()();
  TextColumn get timestamp => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SyncRecordData')
class SyncRecords extends Table {
  TextColumn get id => text()();
  TextColumn get syncTime => text()();
  TextColumn get syncType => text()();
  TextColumn get status => text()();
  IntColumn get pushedRecordCount => integer().nullable()();
  IntColumn get pulledRecordCount => integer().nullable()();
  TextColumn get errorMessage => text().nullable()();
  TextColumn get metadata => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SyncConfigData')
class SyncConfig extends Table {
  TextColumn get id => text()();
  TextColumn get lastSyncTime => text().nullable()();
  IntColumn get syncInterval => integer().withDefault(const Constant(24))();
  IntColumn get isAutoSync => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ActiveDeletionProposalData')
class ActiveDeletionProposals extends Table {
  TextColumn get phoneNumber => text().references(RemoteNumbers, #phoneNumber, onDelete: KeyAction.cascade)();
  TextColumn get proposal_start_time => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get highest_risk_level => text()();
  IntColumn get proposal_count => integer().withDefault(const Constant(0))();
  IntColumn get verified_owner_count => integer().withDefault(const Constant(0))();
  TextColumn get last_updated => text()();
  TextColumn get verificationReportJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {phoneNumber};
}

@DataClassName('ProposalSubmissionData')
class ProposalSubmissions extends Table {
  TextColumn get id => text()();
  TextColumn get proposer_id => text()();
  TextColumn get phone_number => text()();
  TextColumn get submission_time => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ProposalVoteData')
class ProposalVotes extends Table {
  TextColumn get id => text()();
  TextColumn get voter_id => text()();
  TextColumn get proposal_id => text()();
  TextColumn get vote_time => text()();
  IntColumn get is_consumed => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

// ==========================================================================
// --- Database Class (包含了正确的、独立的 @TableIndex 注解) ---
// ==========================================================================

@TableIndex(name: 'idx_number_countries_country_iso_code', columns: {#countryIsoCode})
@TableIndex(name: 'idx_active_deletion_proposals_status', columns: {#status})
@TableIndex(name: 'idx_active_deletion_proposals_start_time', columns: {#proposalStartTime})
@TableIndex(name: 'idx_submissions_proposer_time', columns: {#proposerId, #submissionTime})
@TableIndex(name: 'idx_votes_voter_consumed', columns: {#voterId, #isConsumed})

// Database class
@DriftDatabase(
  tables: [
    RemoteNumbers, NumberCountries, PendingOperations, SyncRecords, 
    SyncConfig, ActiveDeletionProposals, ProposalSubmissions, ProposalVotes
  ],
)
class RemoteDatabase extends _$RemoteDatabase {
  // Singleton instance
  static final RemoteDatabase _instance = RemoteDatabase._internal();
  
  // Factory constructor
  factory RemoteDatabase() => _instance;

  // Database version
  @override
  int get schemaVersion => 3;

  // Internal constructor
  RemoteDatabase._internal() : super(_openConnection());

  // Open connection
  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'remote_database.db'));
      return NativeDatabase(
        file,
        logStatements: false,
        setup: (db) {
          db.execute('PRAGMA foreign_keys = ON');
           // 【关键改动在这里】
          // 如果是 Overlay 模式，就将此连接设置为只读
          if (isOverlayMode) {
            db.execute('PRAGMA query_only = ON');
          }
        },
      );
    });
  }

  // Migration
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
         // m.createAll() 会自动创建所有表和在 @DriftDatabase 外部声明的索引
      await m.createAll();
      
      // Insert default sync config
      await into(syncConfig).insert(
        SyncConfigCompanion.insert(
          id: '1',
          lastSyncTime: const Value(null),
          syncInterval: const Value(24),
          isAutoSync: const Value(1),
        ),
      );
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // Version 1 to 2 migration
      await transaction(() async {
          // Step 1: Read data before any write operations
          final oldPendingOps = await customSelect('SELECT * FROM pending_operations').get();
          final oldNumbers = await customSelect('SELECT id, phoneNumber FROM remote_numbers').get();
          
          final idToPhoneNumberMap = {
            for (var row in oldNumbers) row.data['id'] as String: row.data['phoneNumber'] as String
          };
          
          // Step 2: Create a batch for all write operations
        
            // Rename old table
            await customStatement('ALTER TABLE remote_numbers RENAME TO remote_numbers_old');
            
            // Create new tables
            await m.createTable(remoteNumbers);
            await m.createTable(numberCountries);
            await m.createTable(pendingOperations);
            
            // Create index
         //   await customStatement('CREATE INDEX IF NOT EXISTS idx_number_countries_country_iso_code ON number_countries(countryIsoCode)');
            
            // Migrate data
            await customStatement('''
              INSERT INTO remote_numbers (id, phoneNumber, name, label, priority, action, count)
              SELECT id, phoneNumber, name, label, priority, action, count FROM remote_numbers_old
            ''');
            
            // Migrate pending operations
            for (final op in oldPendingOps) {
              final oldEntityId = op.data['entityId'] as String;
              final newEntityId = idToPhoneNumberMap[oldEntityId];
              
              if (newEntityId != null) {
                await into(pendingOperations).insert(
                  PendingOperationsCompanion.insert(
                    id: op.data['id'] as String,
                    entityId: newEntityId,
                    operation: op.data['operation'] as String,
                    payload: Value(op.data['payload'] as String?),
                    timestamp: op.data['timestamp'] as String,
                  ),
                );
              }
            }
            
            // Drop old tables
            await customStatement('DROP TABLE remote_numbers_old');
            await customStatement('DROP INDEX IF EXISTS idx_remote_numbers_phone_number');
          });
        }
   
      
      if (from < 3) {
        // Version 2 to 3 migration
        await transaction(() async {
          await m.createTable(proposalSubmissions);
          await m.createTable(proposalVotes);
          
        //  await customStatement('CREATE INDEX IF NOT EXISTS idx_submissions_proposer_time ON proposal_submissions(proposer_id, submission_time)');
        //  await customStatement('CREATE INDEX IF NOT EXISTS idx_votes_voter_consumed ON proposal_votes(voter_id, is_consumed)');
        });
      }
    },
  );
}