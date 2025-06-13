import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/remote/remote_data_access_restriction.dart';

/// RemoteDataAccessRestriction的Provider
final remoteDataAccessProvider = Provider<RemoteDataAccessRestriction>((ref) {
  return RemoteDataAccessRestrictionImpl();
});