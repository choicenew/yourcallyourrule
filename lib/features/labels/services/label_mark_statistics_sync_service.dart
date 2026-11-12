import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

part 'label_mark_statistics_sync_service.g.dart';

/// LabelMarkStatisticsSyncService Riverpod Provider
@Riverpod(keepAlive: true)
LabelMarkStatisticsSyncService labelMarkStatisticsSyncService(Ref ref) {
  final statisticsService = ref.watch(labelMarkStatisticsServiceProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  return LabelMarkStatisticsSyncService(statisticsService, predefinedLabelService);
}

/// 标签标记统计同步服务类
class LabelMarkStatisticsSyncService {
  final LabelMarkStatisticsService _statisticsService;
  final PredefinedLabelService _predefinedLabelService;
  StreamSubscription<dynamic>? _dataSubscription;

  LabelMarkStatisticsSyncService(
    this._statisticsService,
    this._predefinedLabelService,
  );

  void startSync(Stream<LabelPhoneEntry> labelPhoneEntryStream) {
    _dataSubscription?.cancel();
    _dataSubscription = labelPhoneEntryStream.listen(_handleLabelData);
  }

  Future<void> syncSingleLabel(LabelPhoneEntry labelPhoneEntry) async {
    await _handleLabelData(labelPhoneEntry);
  }

  Future<void> _handleLabelData(LabelPhoneEntry labelPhoneEntry) async {
    final phoneNumberStr = labelPhoneEntry.phoneNumber;
    final labelId = labelPhoneEntry.labelId;
    final predefinedLabel = await _predefinedLabelService.getLabelById(labelId);

    if (predefinedLabel != null && predefinedLabel.text.toLowerCase() != 'unknown') {
      await _statisticsService.recordMark(PhoneNumber.fromString(phoneNumberStr), labelId);
    }
  }

  void stopSync() {
    _dataSubscription?.cancel();
    _dataSubscription = null;
  }

  void dispose() {
    stopSync();
  }
}
