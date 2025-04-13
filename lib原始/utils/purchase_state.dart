import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseState extends ChangeNotifier {
  bool _isPurchasesEnabled = false;
  bool _hasTempPurchase = false;
  DateTime? _tempPurchaseExpiryDate;

  bool get isPurchasesEnabled => _isPurchasesEnabled;
  bool get hasTempPurchase => _hasTempPurchase;
  DateTime? get tempPurchaseExpiryDate => _tempPurchaseExpiryDate;

  bool isPurchasedOrHasTempAccess() {
    return _isPurchasesEnabled || _hasTempPurchase;
  }

  Future<void> loadState() async {
   SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    _isPurchasesEnabled = await asyncPrefs.getBool('isPurchasesEnabled') ?? false;
    _hasTempPurchase = await asyncPrefs.getBool('hasTempPurchase') ?? false;
    int? expiryTimestamp = await asyncPrefs.getInt('tempPurchaseExpiryDate');
    if (expiryTimestamp != null) {
      _tempPurchaseExpiryDate =
          DateTime.fromMillisecondsSinceEpoch(expiryTimestamp);
    }
    notifyListeners();
  }

  Future<void> updatePurchaseState(bool isPurchased) async {
    _isPurchasesEnabled = isPurchased;
   SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool('isPurchasesEnabled', isPurchased);
    notifyListeners();
  }

  Future<void> updateTempPurchaseState(bool hasTempPurchase, DateTime expiryDate) async {
    _hasTempPurchase = hasTempPurchase;
    _tempPurchaseExpiryDate = expiryDate;
   SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool('hasTempPurchase', hasTempPurchase);
    await asyncPrefs.setInt('tempPurchaseExpiryDate', expiryDate.millisecondsSinceEpoch);
    notifyListeners();
  }
}