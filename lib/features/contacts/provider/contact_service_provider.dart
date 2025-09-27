import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/contact_repository_provider.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';

/// ContactService的Provider
final contactServiceProvider = Provider<ContactService>((ref) {
  final contactRepository = ref.watch(contactRepositoryProvider);
  
  return ContactService(contactRepository);
});