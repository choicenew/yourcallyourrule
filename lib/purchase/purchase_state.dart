import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

class PurchaseState extends ChangeNotifier {
  bool _isPurchasesEnabled = false;
  bool _hasTempPurchase = false;
  DateTime? _tempPurchaseExpiryDate;
  
  final ConfigRepository _configRepository;
  
  PurchaseState({ConfigRepository? configRepository})
      : _configRepository = configRepository ?? SharedPreferencesConfigRepository();

  bool get isPurchasesEnabled => _isPurchasesEnabled;
  bool get hasTempPurchase => _hasTempPurchase;
  DateTime? get tempPurchaseExpiryDate => _tempPurchaseExpiryDate;

  bool isPurchasedOrHasTempAccess() {
    return _isPurchasesEnabled || _hasTempPurchase;
  }

  Future<void> loadState() async {
    final isPurchasedConfig = await _configRepository.getConfig('isPurchasesEnabled');
    _isPurchasesEnabled = isPurchasedConfig?['value'] as bool? ?? false;
    
    final hasTempConfig = await _configRepository.getConfig('hasTempPurchase');
    _hasTempPurchase = hasTempConfig?['value'] as bool? ?? false;
    
    final expiryConfig = await _configRepository.getConfig('tempPurchaseExpiryDate');
    final expiryTimestamp = expiryConfig?['value'] as int?;
    if (expiryTimestamp != null) {
      _tempPurchaseExpiryDate = DateTime.fromMillisecondsSinceEpoch(expiryTimestamp);
    }
    notifyListeners();
  }

  Future<void> updatePurchaseState(bool isPurchased) async {
    _isPurchasesEnabled = isPurchased;
    await _configRepository.saveConfig('isPurchasesEnabled', {'value': isPurchased});
    notifyListeners();
  }

  Future<void> updateTempPurchaseState(bool hasTempPurchase, DateTime expiryDate) async {
    _hasTempPurchase = hasTempPurchase;
    _tempPurchaseExpiryDate = expiryDate;
    await _configRepository.saveConfig('hasTempPurchase', {'value': hasTempPurchase});
    await _configRepository.saveConfig('tempPurchaseExpiryDate', {'value': expiryDate.millisecondsSinceEpoch});
    notifyListeners();
  }
}