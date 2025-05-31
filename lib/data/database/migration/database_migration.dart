// 数据库迁移脚本，用于管理数据库版本升级和表结构变更

import 'package:sqflite/sqflite.dart';

// 数据库迁移管理器
class DatabaseMigration {
  // 执行本地数据库迁移
  static Future<void> migrateLocalDatabase(Database db, int oldVersion, int newVersion) async {
    // 按版本号顺序执行迁移
    if (oldVersion < 1) {
      await _migrateLocalToV1(db);
    }
    
    if (oldVersion < 2 && newVersion >= 2) {
      await _migrateLocalToV2(db);
    }
    
    // 可以继续添加更多版本的迁移
  }
  
  // 执行远程数据库迁移
  static Future<void> migrateRemoteDatabase(Database db, int oldVersion, int newVersion) async {
    // 按版本号顺序执行迁移
    if (oldVersion < 1) {
      await _migrateRemoteToV1(db);
    }
    
    if (oldVersion < 2 && newVersion >= 2) {
      await _migrateRemoteToV2(db);
    }
    
    // 可以继续添加更多版本的迁移
  }
  
  // 本地数据库迁移到版本1
  static Future<void> _migrateLocalToV1(Database db) async {
    // 创建联系人表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS contacts (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        name TEXT NOT NULL,
        avatar TEXT,
        note TEXT,
        labelIds TEXT,
        isFavorite INTEGER NOT NULL DEFAULT 0,
        lastUpdated TEXT NOT NULL
      )
    ''');
    
    // 创建通话记录表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS calls (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        contactName TEXT,
        callType TEXT NOT NULL,
        startTime TEXT NOT NULL,
        endTime TEXT,
        duration INTEGER NOT NULL DEFAULT 0,
        isRead INTEGER NOT NULL DEFAULT 0,
        simInfo TEXT,
        note TEXT,
        isMarked INTEGER NOT NULL DEFAULT 0,
        labelIds TEXT
      )
    ''');
    
    // 创建正则规则表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS regex_rules (
        id TEXT PRIMARY KEY,
        pattern TEXT NOT NULL,
        action TEXT NOT NULL,
        name TEXT NOT NULL,
        priority INTEGER NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1
      )
    ''');
    
    // 创建规则表（统一处理黑白名单/allow/block）
    await db.execute('''
      CREATE TABLE IF NOT EXISTS rules (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        ruleType TEXT NOT NULL,
        phoneNumber TEXT,
        labelId TEXT,
        priority INTEGER NOT NULL,
        action TEXT NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        pattern TEXT,
        avatar TEXT,
        contentRegex TEXT,
        senderRegex TEXT
      )
    ''');
    
    // 创建订阅表（处理三种订阅类型）
    await db.execute('''
      CREATE TABLE IF NOT EXISTS subscriptions (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        url TEXT NOT NULL,
        type TEXT NOT NULL,
        enabled INTEGER NOT NULL DEFAULT 1,
        action TEXT NOT NULL DEFAULT 'none',
        lastUpdated TEXT NOT NULL,
        autoUpdate INTEGER NOT NULL DEFAULT 0,
        contactGroup TEXT,
        keywordFilters TEXT
      )
    ''');
    
    // 创建短信表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS sms (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        contactName TEXT,
        messageType TEXT NOT NULL,
        content TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        isRead INTEGER NOT NULL DEFAULT 0,
        simInfo TEXT,
        isMarked INTEGER NOT NULL DEFAULT 0,
        labelIds TEXT,
        ruleId TEXT,
        actionApplied TEXT,
        contentRegex TEXT,
        senderRegex TEXT
      )
    ''');
    
    // 创建插件表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS plugins (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        url TEXT NOT NULL,
        version TEXT NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        pluginOrder INTEGER NOT NULL,
        isAutoUpdate INTEGER NOT NULL DEFAULT 0
      )
    ''');
    
    // 创建位置表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS locations (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        region TEXT,
        countryName TEXT,
        carrier TEXT,
        numberType INTEGER NOT NULL
      )
    ''');
    
    // 创建标签表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS labels (
        id TEXT PRIMARY KEY,
        name TEXT,
        icon TEXT,
        phoneNumber TEXT NOT NULL,
        label TEXT NOT NULL,
        labelId TEXT NOT NULL,
        avatar TEXT,
        priority INTEGER NOT NULL DEFAULT 0,
        action TEXT NOT NULL DEFAULT 'none',
        isEnabled INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (labelId) REFERENCES predefined_labels (id)
      )
    ''');
    
    // 检查是否存在旧的SMS黑白名单表，如果存在则迁移数据
    final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    final tableNames = tables.map((t) => t['name'] as String).toList();
    
    // 迁移SMS黑名单到规则表
    if (tableNames.contains('sms_blacklisted')) {
      // 获取所有黑名单记录
      final blacklistItems = await db.query('sms_blacklisted');
      
      // 将黑名单记录转换为正则规则
      for (final item in blacklistItems) {
        final phoneNumber = item['phoneNumber'] as String?;
        final name = item['name'] as String? ?? '从黑名单迁移';
        
        if (phoneNumber != null && phoneNumber.isNotEmpty) {
          // 创建一个新的SMS正则规则（阻止操作）
          await db.insert('rules', {
            'id': 'sms_bl_v1_' + DateTime.now().millisecondsSinceEpoch.toString(),
            'name': name,
            'ruleType': 'sms_regex',
            'phoneNumber': phoneNumber,
            'labelId': item['label'],
            'contentRegex': '.*${item['keyword']}.*',
            'senderRegex': '^${item['phoneNumber']}\$',
            'action': 'block',
            'priority': 5,
            'isEnabled': 1,
            'avatar': item['avatar']
          });
        }
      }
    }
    
    // 迁移SMS白名单到规则表
    if (tableNames.contains('sms_whitelisted')) {
      // 获取所有白名单记录
      final whitelistItems = await db.query('sms_whitelisted');
      
      // 将白名单记录转换为正则规则
      for (final item in whitelistItems) {
        final phoneNumber = item['phoneNumber'] as String?;
        final name = item['name'] as String? ?? '从白名单迁移';
        
        if (phoneNumber != null && phoneNumber.isNotEmpty) {
          // 创建一个新的SMS正则规则（允许操作）
          await db.insert('rules', {
            'id': 'sms_wl_v1_' + DateTime.now().millisecondsSinceEpoch.toString(),
            'name': name,
            'ruleType': 'sms_regex',
            'phoneNumber': phoneNumber,
            'labelId': item['label'],
            'contentRegex': '.*${item['keyword']}.*',
            'senderRegex': '^${item['phoneNumber']}\$',
            'action': 'allow',
            'priority': 10,
            'isEnabled': 1,
            'avatar': item['avatar']
          });
        }
      }
    }
    
    // 迁移SMS文本黑名单到规则表
    if (tableNames.contains('sms_text_blacklisted')) {
      final textBlacklistItems = await db.query('sms_text_blacklisted');
      
      for (final item in textBlacklistItems) {
        final keyword = item['keyword'] as String?;
        final name = item['name'] as String? ?? '从SMS文本黑名单迁移';
        
        if (keyword != null && keyword.isNotEmpty) {
          await db.insert('rules', {
            'id': 'sms_txt_bl_v1_' + DateTime.now().millisecondsSinceEpoch.toString(),
            'name': name,
            'ruleType': 'sms_text',
            'contentRegex': '.*${'$keyword'}.*',
            'action': 'block',
            'priority': 5,
            'isEnabled': 1
          });
        }
      }
    }
    
    // 迁移SMS文本白名单到规则表
    if (tableNames.contains('sms_text_whitelisted')) {
      final textWhitelistItems = await db.query('sms_text_whitelisted');
      
      for (final item in textWhitelistItems) {
        final keyword = item['keyword'] as String?;
        final name = item['name'] as String? ?? '从SMS文本白名单迁移';
        
        if (keyword != null && keyword.isNotEmpty) {
          await db.insert('rules', {
            'id': 'sms_txt_wl_v1_' + DateTime.now().millisecondsSinceEpoch.toString(),
            'name': name,
            'ruleType': 'sms_text',
            'contentRegex': '.*${'$keyword'}.*',
            'action': 'allow',
            'priority': 10,
            'isEnabled': 1
          });
        }
      }
    }
    
    // 创建通话记录表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS calls (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        contactName TEXT,
        callType TEXT NOT NULL,
        startTime TEXT NOT NULL,
        endTime TEXT,
        duration INTEGER NOT NULL DEFAULT 0,
        isRead INTEGER NOT NULL DEFAULT 0,
        simInfo TEXT,
        note TEXT,
        isMarked INTEGER NOT NULL DEFAULT 0,
        labelIds TEXT
      )
    ''');
    
    // 创建正则规则表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS regex_rules (
        id TEXT PRIMARY KEY,
        pattern TEXT NOT NULL,
        action TEXT NOT NULL,
        name TEXT NOT NULL,
        priority INTEGER NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1
      )
    ''');
    
    // 创建规则表（统一处理黑白名单/allow/block）
    await db.execute('''
      CREATE TABLE IF NOT EXISTS rules (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        ruleType TEXT NOT NULL,
        phoneNumber TEXT,
        labelId TEXT,
        priority INTEGER NOT NULL,
        action TEXT NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        pattern TEXT,
        avatar TEXT
      )
    ''');
    
    // 创建订阅表（处理三种订阅类型）
    await db.execute('''
      CREATE TABLE IF NOT EXISTS subscriptions (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        url TEXT NOT NULL,
        type TEXT NOT NULL,
        enabled INTEGER NOT NULL DEFAULT 1,
        action TEXT NOT NULL DEFAULT 'none',
        lastUpdated TEXT NOT NULL,
        autoUpdate INTEGER NOT NULL DEFAULT 0,
        contactGroup TEXT,
        keywordFilters TEXT
      )
    ''');
    
    // 创建短信表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS sms (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        contactName TEXT,
        messageType TEXT NOT NULL,
        content TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        isRead INTEGER NOT NULL DEFAULT 0,
        simInfo TEXT,
        isMarked INTEGER NOT NULL DEFAULT 0,
        labelIds TEXT,
        ruleId TEXT,
        actionApplied TEXT,
        contentRegex TEXT,
        senderRegex TEXT
      )
    ''');
    
    // 创建插件表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS plugins (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        url TEXT NOT NULL,
        version TEXT NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        pluginOrder INTEGER NOT NULL,
        isAutoUpdate INTEGER NOT NULL DEFAULT 0
      )
    ''');
    
    // 创建位置表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS locations (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        region TEXT,
        countryName TEXT,
        carrier TEXT,
        numberType INTEGER NOT NULL
      )
    ''');
    
    // 创建标签表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS labels (
        id TEXT PRIMARY KEY,
        name TEXT,
        icon TEXT,
        phoneNumber TEXT NOT NULL,
        label TEXT NOT NULL,
        labelId TEXT NOT NULL,
        avatar TEXT,
        priority INTEGER NOT NULL DEFAULT 0,
        action TEXT NOT NULL DEFAULT 'none',
        isEnabled INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (labelId) REFERENCES predefined_labels (id)
      )
    ''');
  }
  
  // 本地数据库迁移到版本2
  static Future<void> _migrateLocalToV2(Database db) async {
    // 添加新的字段或表
    await db.execute('ALTER TABLE contacts ADD COLUMN isBlocked INTEGER NOT NULL DEFAULT 0');
    
    // 为calls表添加name字段
    try {
      // 检查calls表是否存在name列
      final result = await db.rawQuery("PRAGMA table_info(calls)");
      final hasNameColumn = result.any((column) => column['name'] == 'name');
      
      // 如果不存在name列，则添加
      if (!hasNameColumn) {
        await db.execute('ALTER TABLE calls ADD COLUMN name TEXT');
        print('成功为calls表添加name字段');
      }
    } catch (e) {
      print('为calls表添加name字段时出错: ${e.toString()}');
    }
    
    // 创建SMS规则相关表（如果不存在）
    await db.execute('''
      CREATE TABLE IF NOT EXISTS sms_text_rules (
        id TEXT PRIMARY KEY,
        keyword TEXT NOT NULL,
        ruleType TEXT NOT NULL,
        action TEXT NOT NULL,
        priority INTEGER NOT NULL DEFAULT 0,
        isEnabled INTEGER NOT NULL DEFAULT 1
      )
    ''');
    
    // 创建位置数据缓存表（如果不存在）
    await db.execute('''
      CREATE TABLE IF NOT EXISTS location_cache (
        phoneNumber TEXT PRIMARY KEY,
        data TEXT NOT NULL,
        lastUpdated TEXT NOT NULL
      )
    ''');
    
    // 迁移旧的黑白名单数据到新的规则表
    try {
      // 检查旧表是否存在
      final blacklistExists = await _tableExists(db, 'blacklist_phonenumber');
      final whitelistExists = await _tableExists(db, 'whitelist_phonenumber');
      final smsBlacklistExists = await _tableExists(db, 'sms_blacklisted');
      final smsWhitelistExists = await _tableExists(db, 'sms_whitelisted');
      final smsTextBlacklistExists = await _tableExists(db, 'sms_text_blacklisted');
      final smsTextWhitelistExists = await _tableExists(db, 'sms_text_whitelisted');
      
      // 迁移 subscriptions 表中的 isWhitelist 和 isBlacklist 字段到 action 字段
      try {
        // 获取所有订阅记录
        final subscriptions = await db.query('subscriptions');
        
        // 更新每个订阅记录的 action 字段
        for (final subscription in subscriptions) {
          final isWhitelist = subscription['isWhitelist'] == 1;
          final isBlacklist = subscription['isBlacklist'] == 1;
          String action = 'none';
          
          if (isWhitelist) {
            action = 'allow';
          } else if (isBlacklist) {
            action = 'block';
          }
          
          // 更新记录
          await db.update(
            'subscriptions',
            {'action': action},
            where: 'id = ?',
            whereArgs: [subscription['id']]
          );
        }
        
        print('成功迁移 subscriptions 表中的 isWhitelist 和 isBlacklist 字段到 action 字段');
      } catch (e) {
        print('迁移 subscriptions 表数据时出错: ${e.toString()}');
      }
      
      // 迁移电话黑名单数据到规则表
      if (blacklistExists) {
        await db.execute('''
          INSERT INTO rules (id, name, ruleType, phoneNumber, labelId, priority, action, isEnabled, avatar)
          SELECT 
            'bl_' || rowid, 
            COALESCE(name, 'Blocked Number'), 
            'blacklist', 
            phoneNumber, 
            label, 
            10, 
            'block', 
            1, 
            avatar
          FROM blacklist_phonenumber
        ''');
      }
      
      // 迁移电话白名单数据到规则表
      if (whitelistExists) {
        await db.execute('''
          INSERT INTO rules (id, name, ruleType, phoneNumber, labelId, priority, action, isEnabled, avatar)
          SELECT 
            'wl_' || rowid, 
            COALESCE(name, 'Allowed Number'), 
            'whitelist', 
            phoneNumber, 
            label, 
            20, 
            'allow', 
            1, 
            avatar
          FROM whitelist_phonenumber
        ''');
      }
      
      // 迁移SMS号码黑名单到规则表
      if (smsBlacklistExists) {
        final blacklistItems = await db.query('sms_blacklisted');
        
        for (final item in blacklistItems) {
          final phoneNumber = item['phoneNumber'] as String?;
          final name = item['name'] as String? ?? '从SMS黑名单迁移';
          
          if (phoneNumber != null && phoneNumber.isNotEmpty) {
            await db.insert('rules', {
              'id': 'sms_bl_' + DateTime.now().millisecondsSinceEpoch.toString(),
              'name': name,
              'ruleType': 'sms_regex',
              'phoneNumber': phoneNumber,
              'labelId': item['label'],
              'priority': 15,
              'action': 'block',
              'isEnabled': 1,
              'pattern': '.*',
              'avatar': item['avatar']
            });
          }
        }
      }
      
      // 迁移SMS号码白名单到规则表
      if (smsWhitelistExists) {
        final whitelistItems = await db.query('sms_whitelisted');
        
        for (final item in whitelistItems) {
          final phoneNumber = item['phoneNumber'] as String?;
          final name = item['name'] as String? ?? '从SMS白名单迁移';
          
          if (phoneNumber != null && phoneNumber.isNotEmpty) {
            await db.insert('rules', {
              'id': 'sms_wl_' + DateTime.now().millisecondsSinceEpoch.toString(),
              'name': name,
              'ruleType': 'sms_regex',
              'phoneNumber': phoneNumber,
              'labelId': item['label'],
              'priority': 25,
              'action': 'allow',
              'isEnabled': 1,
              'pattern': '.*',
              'avatar': item['avatar']
            });
          }
        }
      }
      
      // 迁移SMS文本黑名单到规则表
      if (smsTextBlacklistExists) {
        final textBlacklistItems = await db.query('sms_text_blacklisted');
        
        for (final item in textBlacklistItems) {
          final keyword = item['keyword'] as String?;
          final name = item['name'] as String? ?? '从SMS文本黑名单迁移';
          
          if (keyword != null && keyword.isNotEmpty) {
            await db.insert('sms_text_rules', {
              'id': 'sms_txt_bl_' + DateTime.now().millisecondsSinceEpoch.toString(),
              'keyword': keyword,
              'ruleType': 'sms_text',
              'action': 'block',
              'priority': 5,
              'isEnabled': 1
            });
          }
        }
      }
      
      // 迁移SMS文本白名单到规则表
      if (smsTextWhitelistExists) {
        final textWhitelistItems = await db.query('sms_text_whitelisted');
        
        for (final item in textWhitelistItems) {
          final keyword = item['keyword'] as String?;
          final name = item['name'] as String? ?? '从SMS文本白名单迁移';
          
          if (keyword != null && keyword.isNotEmpty) {
            await db.insert('sms_text_rules', {
              'id': 'sms_txt_wl_' + DateTime.now().millisecondsSinceEpoch.toString(),
              'keyword': keyword,
              'ruleType': 'sms_text',
              'action': 'allow',
              'priority': 10,
              'isEnabled': 1
            });
          }
        }
      }
    } catch (e) {
      // 迁移过程中出错，记录错误但继续执行
      print('迁移黑白名单数据时出错: ${e.toString()}');
    }
  }
  
  // 辅助方法：检查表是否存在
  static Future<bool> _tableExists(Database db, String tableName) async {
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName]
    );
    return result.isNotEmpty;
  }
  
  // 远程数据库迁移到版本1
  static Future<void> _migrateRemoteToV1(Database db) async {
    // 创建远程规则表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS remote_rules (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        ruleType TEXT NOT NULL,
        phoneNumber TEXT,
        labelId TEXT,
        priority INTEGER NOT NULL DEFAULT 0,
        action TEXT NOT NULL DEFAULT 'none',
        isEnabled INTEGER NOT NULL DEFAULT 1,
        pattern TEXT,
        avatar TEXT,
        source TEXT NOT NULL,
        lastUpdated TEXT NOT NULL
      )
    ''');
    
    // 创建远程正则规则表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS remote_regex_rules (
        id TEXT PRIMARY KEY,
        pattern TEXT NOT NULL,
        action TEXT NOT NULL,
        name TEXT NOT NULL,
        priority INTEGER NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        source TEXT NOT NULL,
        lastUpdated TEXT NOT NULL
      )
    ''');
    
    // 创建同步记录表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS sync_records (
        id TEXT PRIMARY KEY,
        syncTime TEXT NOT NULL,
        syncType TEXT NOT NULL,
        status TEXT NOT NULL,
        error TEXT
      )
    ''');
    
    // 创建同步配置表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS sync_config (
        id TEXT PRIMARY KEY,
        lastSyncTime TEXT,
        syncInterval INTEGER NOT NULL DEFAULT 24,
        isAutoSync INTEGER NOT NULL DEFAULT 1,
        syncTypes TEXT NOT NULL DEFAULT 'rules,regex,sms'
      )
    ''');
    
    // 创建远程SMS规则表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS remote_sms_rules (
        id TEXT PRIMARY KEY,
        keyword TEXT NOT NULL,
        ruleType TEXT NOT NULL,
        action TEXT NOT NULL,
        priority INTEGER NOT NULL DEFAULT 0,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        source TEXT NOT NULL,
        lastUpdated TEXT NOT NULL
      )
    ''');
    
    // 插入默认同步配置
    await db.insert(
      'sync_config',
      {
        'id': '1',
        'lastSyncTime': null,
        'syncInterval': 24,
        'isAutoSync': 1,
        'syncTypes': 'rules,regex,sms'
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  // 远程数据库迁移到版本2
  static Future<void> _migrateRemoteToV2(Database db) async {
    // 创建远程数据访问日志表（用于审计）
    await db.execute('''
      CREATE TABLE IF NOT EXISTS remote_access_logs (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        accessTime TEXT NOT NULL,
        accessType TEXT NOT NULL,
        userId TEXT
      )
    ''');
    
    // 创建远程位置数据缓存表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS remote_location_cache (
        phoneNumber TEXT PRIMARY KEY,
        data TEXT NOT NULL,
        lastUpdated TEXT NOT NULL,
        source TEXT NOT NULL
      )
    ''');
    
    // 创建远程订阅规则表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS remote_subscriptions (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        url TEXT NOT NULL,
        type TEXT NOT NULL,
        enabled INTEGER NOT NULL DEFAULT 1,
        isWhitelist INTEGER NOT NULL DEFAULT 0,
        isBlacklist INTEGER NOT NULL DEFAULT 0,
        lastUpdated TEXT NOT NULL,
        autoUpdate INTEGER NOT NULL DEFAULT 0,
        source TEXT NOT NULL
      )
    ''');
    
    // 迁移旧的远程号码数据（如果存在）
    try {
      // 检查旧表是否存在
      final remoteNumbersExists = await _tableExists(db, 'remote_numbers');
      
      if (remoteNumbersExists) {
        // 迁移远程号码数据到远程规则表
        await db.execute('''
          INSERT INTO remote_rules (id, name, ruleType, phoneNumber, label, priority, action, isEnabled, source, lastUpdated)
          SELECT 
            id, 
            COALESCE(name, 'Remote Number'), 
            CASE WHEN action = 'block' THEN 'blacklist' ELSE 'whitelist' END, 
            phoneNumber, 
            label, 
            priority, 
            action, 
            1, 
            'migration', 
            COALESCE(updatedAt, datetime('now'))
          FROM remote_numbers
        ''');
        
        // 可以选择删除旧表
        // await db.execute('DROP TABLE IF EXISTS remote_numbers');
      }
    } catch (e) {
      // 迁移过程中出错，记录错误但继续执行
      print('迁移远程号码数据时出错: ${e.toString()}');
    }
  }
  
 }