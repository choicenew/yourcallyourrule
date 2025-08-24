import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/sync/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return const ApiService();
});