// lib/data/database/local/drift_migration_helper.dart

part of 'local_database.dart'; // ✅ 这一行是正确的

class _DriftMigrationHelper {
  
  static Future<bool> _tableExists(LocalDatabase db, String tableName) async {
    final result = await db.customSelect(
      "SELECT name FROM sqlite_master WHERE type='table' AND name = ?",
      variables: [Variable.withString(tableName)],
    ).get();
    return result.isNotEmpty;
  }

  // =============================================================
  // 升级到版本 2
  // =============================================================
  static Future<void> upgradeFrom1To2(Migrator m, LocalDatabase db) async {
    await m.addColumn(db.callHistory, db.callHistory.name);
    if (!await _tableExists(db, 'phone_rules')) await m.createTable(db.phoneRules);
    if (!await _tableExists(db, 'regex_rules')) await m.createTable(db.regexRules);
    
    await m.addColumn(db.subscriptions, db.subscriptions.tableType);
    await db.customStatement("UPDATE subscriptions SET table_type = 'phone' WHERE table_type IS NULL OR table_type = ''");

    await _migratePhoneBlacklist(m, db);
    await _migratePhoneWhitelist(m, db);
    await _migrateSmsBlacklist(m, db);
    await _migrateSmsWhitelist(m, db);
    await _migrateSmsTextBlacklist(m, db);
    await _migrateSmsTextWhitelist(m, db);
    await _migrateSubscriptionActions(db);
  }

  // ... (升级到 V3, V4 的方法是正确的，保持不变) ...
  static Future<void> upgradeFrom2To3(Migrator m, LocalDatabase db) async {
    if (await _tableExists(db, 'labelPhone') && !await _tableExists(db, 'label_phones')) {
      await db.customStatement('ALTER TABLE labelPhone RENAME TO label_phones');
    }
    await m.addColumn(db.labelPhones, db.labelPhones.ruleType);
  }
  static Future<void> upgradeFrom3To4(Migrator m, LocalDatabase db) async {
    await m.addColumn(db.callHistory, db.callHistory.endTime);
    await m.addColumn(db.callHistory, db.callHistory.duration);
  }

  // =============================================================
  // ✅ 【所有数据迁移方法已完全修正】
  // =============================================================
  static Future<void> _migratePhoneBlacklist(Migrator m, LocalDatabase db) async {
    if (await _tableExists(db, 'blacklist_phonenumber')) {
      final oldData = await db.customSelect('SELECT *, rowid FROM blacklist_phonenumber').get();
      await db.batch((batch) {
        batch.insertAll(db.rules, oldData.map((row) => RulesCompanion.insert(
              // ✅ 必填字段，直接传递原始值
              id: 'bl_${row.read<int>('rowid')}',
              name: row.read<String?>('name') ?? 'Blocked Number',
              ruleType: 'blacklist',
              // ✅ 可空/有默认值字段，用 Value() 包装
              phoneNumber: Value(row.read<String?>('phoneNumber')),
              labelId: Value(row.read<String?>('label')),
              priority: const Value(10),
              action: const Value('block'),
              avatar: Value(row.read<String?>('avatar')),
            )));
      });
    }
  }

  static Future<void> _migratePhoneWhitelist(Migrator m, LocalDatabase db) async {
    if (await _tableExists(db, 'whitelist_phonenumber')) {
      final oldData = await db.customSelect('SELECT *, rowid FROM whitelist_phonenumber').get();
      await db.batch((batch) {
        batch.insertAll(db.rules, oldData.map((row) => RulesCompanion.insert(
              // ✅ 必填字段，直接传递原始值
              id: 'wl_${row.read<int>('rowid')}',
              name: row.read<String?>('name') ?? 'Allowed Number',
              ruleType: 'whitelist',
              // ✅ 可空/有默认值字段，用 Value() 包装
              phoneNumber: Value(row.read<String?>('phoneNumber')),
              labelId: Value(row.read<String?>('label')),
              priority: const Value(20),
              action: const Value('allow'),
              avatar: Value(row.read<String?>('avatar')),
            )));
      });
    }
  }

  static Future<void> _migrateSmsBlacklist(Migrator m, LocalDatabase db) async {
    if (await _tableExists(db, 'sms_blacklisted')) {
      final oldData = await db.customSelect('SELECT * FROM sms_blacklisted').get();
      await db.batch((batch) {
        batch.insertAll(db.rules, oldData.where((row) {
          final phone = row.read<String?>('phoneNumber'); return phone != null && phone.isNotEmpty;
        }).map((row) => RulesCompanion.insert(
              // ✅ 必填字段，直接传递原始值
              id: 'sms_bl_${const Uuid().v4()}',
              name: row.read<String?>('name') ?? '从SMS黑名单迁移',
              ruleType: 'sms_regex',
              action: const Value('block'),
              // ✅ 可空/有默认值字段，用 Value() 包装
              phoneNumber: Value(row.read<String>('phoneNumber')),
              labelId: Value(row.read<String?>('label')),
              pattern: Value('.*${row.read<String?>('keyword') ?? ''}.*'),
              priority: const Value(15),
              avatar: Value(row.read<String?>('avatar')),
            )));
      });
    }
  }

  static Future<void> _migrateSmsWhitelist(Migrator m, LocalDatabase db) async {
    if (await _tableExists(db, 'sms_whitelisted')) {
      final oldData = await db.customSelect('SELECT * FROM sms_whitelisted').get();
      await db.batch((batch) {
        batch.insertAll(db.rules, oldData.where((row) {
          final phone = row.read<String?>('phoneNumber'); return phone != null && phone.isNotEmpty;
        }).map((row) => RulesCompanion.insert(
              // ✅ 必填字段，直接传递原始值
              id: 'sms_wl_${const Uuid().v4()}',
              name: row.read<String?>('name') ?? '从SMS白名单迁移',
              ruleType: 'sms_regex',
              action: const Value('allow'),
              // ✅ 可空/有默认值字段，用 Value() 包装
              phoneNumber: Value(row.read<String>('phoneNumber')),
              labelId: Value(row.read<String?>('label')),
              pattern: Value('.*${row.read<String?>('keyword') ?? ''}.*'),
              priority: const Value(25),
              avatar: Value(row.read<String?>('avatar')),
            )));
      });
    }
  }

  static Future<void> _migrateSmsTextBlacklist(Migrator m, LocalDatabase db) async {
    if (await _tableExists(db, 'sms_text_blacklisted')) {
        final oldData = await db.customSelect('SELECT * FROM sms_text_blacklisted').get();
        await db.batch((batch) {
            batch.insertAll(db.smsRules, oldData.where((row) {
                final keyword = row.read<String?>('keyword'); return keyword != null && keyword.isNotEmpty;
            }).map((row) => SmsRulesCompanion.insert(
                // ✅ 必填字段，直接传递原始值
                id: 'sms_txt_bl_${const Uuid().v4()}',
                name: row.read<String?>('name') ?? '从SMS文本黑名单迁移',
                contentRegex: row.read<String>('keyword'),
                action: 'block',
                ruleType: 'sms_text',
                // ✅ 可空/有默认值字段，用 Value() 包装
                priority: const Value(5),
            )));
        });
    }
  }
  
  static Future<void> _migrateSmsTextWhitelist(Migrator m, LocalDatabase db) async {
    if (await _tableExists(db, 'sms_text_whitelisted')) {
        final oldData = await db.customSelect('SELECT * FROM sms_text_whitelisted').get();
        await db.batch((batch) {
            batch.insertAll(db.smsRules, oldData.where((row) {
                final keyword = row.read<String?>('keyword'); return keyword != null && keyword.isNotEmpty;
            }).map((row) => SmsRulesCompanion.insert(
                // ✅ 必填字段，直接传递原始值
                id: 'sms_txt_wl_${const Uuid().v4()}',
                name: row.read<String?>('name') ?? '从SMS文本白名单迁移',
                contentRegex: row.read<String>('keyword'),
                action: 'allow',
                ruleType: 'sms_text',
                // ✅ 可空/有默认值字段，用 Value() 包装
                priority: const Value(10),
            )));
        });
    }
  }

  static Future<void> _migrateSubscriptionActions(LocalDatabase db) async {
    try {
      final oldSubscriptions = await db.customSelect('SELECT id, isWhitelist, isBlacklist FROM subscriptions').get();
      for (final sub in oldSubscriptions) {
        final isWhitelist = sub.read<int?>('isWhitelist') == 1;
        final isBlacklist = sub.read<int?>('isBlacklist') == 1;
        String action = 'none';
        if (isWhitelist) action = 'allow'; else if (isBlacklist) action = 'block';
        if (action != 'none') {
          await (db.update(db.subscriptions)..where((tbl) => tbl.id.equals(sub.read<String>('id'))))
              .write(SubscriptionsCompanion(action: Value(action))); // `action` 有默认值, 所以用 Value()
        }
      }
    } catch (e) {
      print('Skipping subscription action migration: $e');
    }
  }
}