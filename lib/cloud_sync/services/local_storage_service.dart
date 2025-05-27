import 'package:sqflite/sqflite.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/data/database/database_manager.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';

class LocalStorageService {
  final LocalDatabaseManager _dbManager;

  LocalStorageService(this._dbManager);

  Future<void> saveRules(List<RuleBase> rules) async {
    final db = await _dbManager.database;
    await db.transaction((txn) async {
      await txn.delete('rules');
      for (final rule in rules) {
        await txn.insert(
          'rules',
          CloudDataConverter.serialize(rule),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<RuleBase>> loadRules() async {
    final db = await _dbManager.database;
    final data = await db.query('rules');
    return data.map((json) => CloudDataConverter.deserialize<RuleBase>(json)).toList();
  }

  Future<void> saveSubscription(Subscription subscription) async {
    final db = await _dbManager.database;
    await db.insert(
      'subscriptions',
      CloudDataConverter.serialize(subscription),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Subscription>> loadSubscriptions() async {
    final db = await _dbManager.database;
    final data = await db.query('subscriptions');
    return data.map((json) => CloudDataConverter.deserialize<Subscription>(json)).toList();
  }

  Future<void> saveContacts(List<Contact> contacts) async {
    final db = await _dbManager.database;
    await db.transaction((txn) async {
      await txn.delete('contacts');
      for (final contact in contacts) {
        await txn.insert(
          'contacts',
          CloudDataConverter.serialize(contact),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<Contact>> loadContacts() async {
    final db = await _dbManager.database;
    final data = await db.query('contacts');
    return data.map((json) => CloudDataConverter.deserialize<Contact>(json)).toList();
  }

  Future<void> savePlugins(List<PluginEntry> plugins) async {
    final db = await _dbManager.database;
    await db.transaction((txn) async {
      await txn.delete('plugins');
      for (final plugin in plugins) {
        await txn.insert(
          'plugins',
          CloudDataConverter.serialize(plugin),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<PluginEntry>> loadPlugins() async {
    final db = await _dbManager.database;
    final data = await db.query('plugins');
    return data.map((json) => CloudDataConverter.deserialize<PluginEntry>(json)).toList();
  }

  Future<void> saveCallLogs(List<CallLog> logs) async {
    final db = await _dbManager.database;
    await db.transaction((txn) async {
      await txn.delete('calls');
      for (final log in logs) {
        await txn.insert(
          'calls',
          CloudDataConverter.serialize(log),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<CallLog>> loadCallLogs() async {
    final db = await _dbManager.database;
    final data = await db.query('calls');
    return data.map((json) => CloudDataConverter.deserialize<CallLog>(json)).toList();
  }

  Future<void> saveLabels(List<LabelPhoneEntry> labels) async {
    final db = await _dbManager.database;
    await db.transaction((txn) async {
      await txn.delete('labels');
      for (final label in labels) {
        await txn.insert(
          'labels',
          CloudDataConverter.serialize(label),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<LabelPhoneEntry>> loadLabels() async {
    final db = await _dbManager.database;
    final data = await db.query('labels');
    return data.map((json) => CloudDataConverter.deserialize<LabelPhoneEntry>(json)).toList();
  }

  Future<void> savePredefinedLabels(List<PredefinedLabel> labels) async {
    final db = await _dbManager.database;
    await db.transaction((txn) async {
      await txn.delete('predefined_labels');
      for (final label in labels) {
        await txn.insert(
          'predefined_labels',
          CloudDataConverter.serialize(label),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<PredefinedLabel>> loadPredefinedLabels() async {
    final db = await _dbManager.database;
    final data = await db.query('predefined_labels');
    return data.map((json) => CloudDataConverter.deserialize<PredefinedLabel>(json)).toList();
  }

  Future<void> saveLocations(List<LocationEntry> locations) async {
    final db = await _dbManager.database;
    await db.transaction((txn) async {
      await txn.delete('locations');
      for (final location in locations) {
        await txn.insert(
          'locations',
          CloudDataConverter.serialize(location),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<LocationEntry>> loadLocations() async {
    final db = await _dbManager.database;
    final data = await db.query('locations');
    return data.map((json) => CloudDataConverter.deserialize<LocationEntry>(json)).toList();
  }
}