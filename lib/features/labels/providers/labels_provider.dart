import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/labels/data/repositories/label_phone_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

part 'labels_provider.g.dart';

@Riverpod(keepAlive: true)
LabelService labelSystem(Ref ref) {
  return ref.watch(labelServiceProvider);
}
