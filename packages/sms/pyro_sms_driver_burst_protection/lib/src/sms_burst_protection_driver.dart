import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

/// Driver tracking sliding time windows for incoming SMS frequency from senders
class SmsBurstProtectionDriver implements SmsBurstProtectionAdapter {
  @override
  String get providerId => 'pyro_sms_driver_burst_protection';

  final int maxMessagesPerWindow;
  final Duration windowDuration;

  final Map<String, List<DateTime>> _senderHistory = {};

  SmsBurstProtectionDriver({
    this.maxMessagesPerWindow = 3,
    this.windowDuration = const Duration(seconds: 60),
  });

  @override
  Future<void> recordMessage(SmsMessageEntity message) async {
    final sender = message.sender.trim();
    if (sender.isEmpty) return;

    final now = DateTime.now();
    final timestamps = _senderHistory.putIfAbsent(sender, () => []);
    timestamps.add(now);

    final cutoff = now.subtract(windowDuration);
    timestamps.removeWhere((t) => t.isBefore(cutoff));
  }

  @override
  Future<bool> isBursting(SmsMessageEntity message) async {
    final sender = message.sender.trim();
    if (sender.isEmpty) return false;

    final timestamps = _senderHistory[sender];
    if (timestamps == null) return false;

    final now = DateTime.now();
    final cutoff = now.subtract(windowDuration);
    final validInWindow = timestamps.where((t) => t.isAfter(cutoff)).length;

    return validInWindow >= maxMessagesPerWindow;
  }
}
