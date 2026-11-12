import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/core/database/entity_store.dart';
import 'package:yourcallyourrule/core/database/drift_entity_store.dart';

/// 全局一键可切换的 EntityStore 工厂 Provider
final entityStoreFactoryProvider = Provider<EntityStoreFactory>((ref) {
  final db = ref.watch(localDatabaseProvider);
  return DriftEntityStoreFactory(db);
});

/// 泛型 EntityStore 快捷获取函数
EntityStore<T> getEntityStore<T>(Ref ref) {
  final factory = ref.watch(entityStoreFactoryProvider);
  return factory.createStore<T>();
}
