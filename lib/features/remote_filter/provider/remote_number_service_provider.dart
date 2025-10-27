import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/remote_number_repository_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';


final remoteNumberServiceProvider = Provider<RemoteNumberService>((ref) {
  final remoteNumberRepository = ref.watch(remoteNumberRepositoryProvider);
  return RemoteNumberService(remoteNumberRepository);
});