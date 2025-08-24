import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/remote/remote_data_access_restriction.dart';

/// 远程数据访问限制提供者
final remoteDataAccessRestrictionProvider = Provider<RemoteDataAccessRestriction>((ref) {
  return RemoteDataAccessRestrictionImpl();
});