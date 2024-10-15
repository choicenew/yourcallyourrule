import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/ad_manager.dart';
import '../utils/ad_state.dart';
import 'google_ad.dart';

/*
class InAppPurchaseManager {

  bool _isPurchasesEnabled = false; // 默认情况下是未购买的

  bool get isPurchasesEnabled => _isPurchasesEnabled;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  BuildContext? _buildContext; // 用于显示 SnackBar

  InAppPurchaseManager(BuildContext context) {
    _buildContext = context;
    _initialize();
  }

  Future<void> _initialize() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      throw Exception('应用内购不可用');
    }

    _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList, _buildContext!);
    });
  }

  // 购买消耗型商品
  Future<void> purchaseConsumable(String productId) async {
    try {
      final ProductDetailsResponse response =
          await _inAppPurchase.queryProductDetails({productId});
      if (response.notFoundIDs.isNotEmpty) {
        throw Exception('找不到商品: ${response.notFoundIDs}');
      }

      final ProductDetails productDetails = response.productDetails
          .firstWhere((element) => element.id == productId);

      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);
      final bool status = await _inAppPurchase.buyConsumable(
          purchaseParam: purchaseParam, autoConsume: false);

      if (!status) {
        throw Exception('购买请求失败');
      }
    } catch (e) {
      print('购买消耗型商品失败: $e');
    }
  }

  // 购买非消耗型商品（例如订阅）
  Future<void> purchaseNonConsumable(String productId) async {
    try {
      final ProductDetailsResponse response =
          await _inAppPurchase.queryProductDetails({productId});
      if (response.notFoundIDs.isNotEmpty) {
        throw Exception('找不到商品: ${response.notFoundIDs}');
      }

      final ProductDetails productDetails = response.productDetails
          .firstWhere((element) => element.id == productId);

      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);
      final bool status =
          await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);

      if (!status) {
        throw Exception('购买请求失败');
      }
    } catch (e) {
      print('购买非消耗型商品失败: $e');
    }
  }

  // 处理购买更新
  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList, BuildContext context) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        // 购买成功
                _isPurchasesEnabled = true;
        // 使用 Provider 更新广告状态
         Provider.of<AdState>(context, listen: false).disableAds();
        // 显示 SnackBar
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('购买成功!'),
        ));
        // 可以根据需要添加其他处理逻辑
      } else if (purchaseDetails.status == PurchaseStatus.pending) {
        // 购买待处理 (例如：等待用户付款确认)
        // 可以添加一些 UI 提示，告知用户正在处理购买
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('购买正在处理中...'),
        ));
        // 可以添加一些 UI 提示
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // 购买失败
        //print("购买失败: ${purchaseDetails.error}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('购买失败: ${purchaseDetails.error}'),
        ));
        // 可以根据错误类型添加不同的处理逻辑
      }

      if (purchaseDetails.pendingCompletePurchase) {
        // 确认购买已完成
        _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  // 提供一个公共方法来切换广告状态
  void toggleAdState(BuildContext context) {
    final adState = Provider.of<AdState>(context, listen: false);
    adState.isAdEnabled ? adState.disableAds() : adState.enableAds();
  }
}


class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  
  @override
  Widget build(BuildContext context) {
        // 在这里初始化 inAppPurchaseManager
    final inAppPurchaseManager = InAppPurchaseManager(context); 
    return Scaffold(
      appBar: AppBar(
        title: const Text('应用内购买'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                inAppPurchaseManager.purchaseConsumable(
                    'consumable_product_id'); // 替换为你的消耗型商品ID
              },
              child: const Text('移除广告'),
            ),
            ElevatedButton(
              onPressed: () {
                inAppPurchaseManager.purchaseNonConsumable(
                    'monthly_subscription_id'); // 替换为你的月订阅商品ID
              },
              child: const Text('月订阅'),
            ),
            ElevatedButton(
              onPressed: () {
                inAppPurchaseManager.purchaseNonConsumable(
                    'quarterly_subscription_id'); // 替换为你的季度订阅商品ID
              },
              child: const Text('季度订阅'),
            ),
          ],
        ),
      ),
    );
  }
}
*/


class InAppPurchaseManager {
  bool _isPurchasesEnabled = false;
  bool _hasTempPurchase = false;
  int _adCount = 0;
  Timer? _tempPurchaseTimer;
  RewardItem? rewardItem;

  // 用于存储临时权限的到期时间
  DateTime? _tempPurchaseExpiryDate;

  bool get isPurchasesEnabled => _isPurchasesEnabled;

  bool get hasTempPurchase => _hasTempPurchase;

  // 新函数，判断是否已购买或拥有临时权限
  bool isPurchasedOrHasTempAccess() {
    return _isPurchasesEnabled || _hasTempPurchase;
  }

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  BuildContext? _buildContext;

  InAppPurchaseManager(BuildContext context) {
    _buildContext = context;
    _initialize();
  }

  Future<void> _initialize() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      // 应用内购不可用      
      print('应用内购不可用');
      return;
    }
    // 加载存储的临时权限信息
    await loadTempPurchaseInfo();
        // 加载存储的内购信息
    await loadPurchaseInfo();

    // 监听购买更
    _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList, _buildContext!);
    });
  }

  // 加载存储的临时权限信息
  Future<void> loadTempPurchaseInfo() async {
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    _hasTempPurchase = await asyncPrefs.getBool('hasTempPurchase') ?? false;
    int? expiryTimestamp = await asyncPrefs.getInt('tempPurchaseExpiryDate');
    if (expiryTimestamp != null) {
      _tempPurchaseExpiryDate =
          DateTime.fromMillisecondsSinceEpoch(expiryTimestamp);

      // 检查临时权限是否已过期
      if (_tempPurchaseExpiryDate!.isBefore(DateTime.now())) {
        _hasTempPurchase = false;
        _adCount = 0; // 重置广告计数器
        await asyncPrefs.setBool('hasTempPurchase', false);
        await asyncPrefs.remove('tempPurchaseExpiryDate');
      }
    }
  }

  // 存储临时权限信息
  Future<void> saveTempPurchaseInfo() async {
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool('hasTempPurchase', _hasTempPurchase);
    await asyncPrefs.setInt(
        'tempPurchaseExpiryDate', _tempPurchaseExpiryDate!.millisecondsSinceEpoch);
  }

  // 存储购买信息
  Future<void> savePurchaseInfo() async {
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool('isPurchasesEnabled', _isPurchasesEnabled);
  }

  // 加载购买信息
  Future<void> loadPurchaseInfo() async {
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    _isPurchasesEnabled = await asyncPrefs.getBool('isPurchasesEnabled') ?? false;
  }


  // 购买消耗型商品
  Future<void> purchaseConsumable(String productId) async {
    try {
      final ProductDetailsResponse response =
          await _inAppPurchase.queryProductDetails({productId});
      if (response.notFoundIDs.isNotEmpty) {
        throw Exception('找不到商品: ${response.notFoundIDs}');
      }

      final ProductDetails productDetails = response.productDetails
          .firstWhere((element) => element.id == productId);

      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);
      final bool status = await _inAppPurchase.buyConsumable(
          purchaseParam: purchaseParam, autoConsume: false);

      if (!status) {
        throw Exception('购买请求失败');
      }
    } catch (e) {
      print('购买消耗型商品失败: $e');
      // 处理错误，例如显示错误消息      
      ScaffoldMessenger.of(_buildContext!).showSnackBar(
        SnackBar(content: Text('购买失败: $e')),
      );
    }
  }

  // 购买非消耗型商品（例如订阅）
  Future<void> purchaseNonConsumable(String productId) async {
    try {
      final ProductDetailsResponse response =
          await _inAppPurchase.queryProductDetails({productId});
      if (response.notFoundIDs.isNotEmpty) {
        throw Exception('找不到商品: ${response.notFoundIDs}');
      }

      final ProductDetails productDetails = response.productDetails
          .firstWhere((element) => element.id == productId);

      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);
      final bool status =
          await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);

      if (!status) {
        throw Exception('购买请求失败');
      }
    } catch (e) {
      print('购买非消耗型商品失败: $e');
      // 处理错误，例如显示错误消息      
      ScaffoldMessenger.of(_buildContext!).showSnackBar(
        SnackBar(content: Text('购买失败: $e')),
      );
    }
  }

  // 处理购买更新
  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList, BuildContext context) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        // 购买成功
        _isPurchasesEnabled = true;
            savePurchaseInfo(); // 存储购买信息
        // 使用 Provider 更新广告状态 (如果适用)
        Provider.of<AdState>(context, listen: false).disableAds();
        // 显示 SnackBar
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('购买成功!'),
        ));
        // 可以根据需要添加其他处理逻辑，例如解锁功能        
      } else if (purchaseDetails.status == PurchaseStatus.pending) {
        // 购买待处理 (例如：等待用户付款确认)
        // 可以添加一些 UI 提示，告知用户正在处理购买
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('购买正在处理中...'),
        ));
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // 购买失败
        print("购买失败: ${purchaseDetails.error}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('购买失败: ${purchaseDetails.error}'),
        ));
      }

      if (purchaseDetails.pendingCompletePurchase) {
        // 确认购买已完成
        _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  // 显示激励广告
  void showRewardedAd(BuildContext context) {
    // 如果用户已经拥有临时权限，则不显示广告
    if (_hasTempPurchase) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '您已经拥有临时权限，到期时间：${_tempPurchaseExpiryDate!.toLocal()}'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _RewardedAdPage(
          onRewardEarned: (rewardItem) {
            _adCount++;
            if (_adCount >= 5) {
              _grantTemporaryPurchase(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '您还需要观看 ${5 - _adCount} 个广告才能获得临时权限。'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

// 授予临时购买权限
void _grantTemporaryPurchase(BuildContext context) {
  _hasTempPurchase = true;
  final randomDays = Random().nextInt(5) + 1;

  _tempPurchaseExpiryDate = DateTime.now().add(Duration(days: randomDays));

  // 使用 SharedPreferences 存储临时权限信息
  saveTempPurchaseInfo(); 

  _tempPurchaseTimer = Timer(Duration(days: randomDays), () {
    _hasTempPurchase = false;
    _adCount = 0;
    // 更新 SharedPreferences 中的临时权限信息
    saveTempPurchaseInfo(); 
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('临时购买权限已过期'),
    ));
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
          '您已获得 $randomDays 天的临时购买权限，到期时间：${_tempPurchaseExpiryDate!.toLocal()}'),
    ),
  );
}

  // 提供一个公共方法来切换广告状态 (如果适用)
  void toggleAdState(BuildContext context) {
    final adState = Provider.of<AdState>(context, listen: false);
    // 只有正式购买时才禁用广告
    if (_isPurchasesEnabled) {
      adState.disableAds();
    } else {
      adState.enableAds();
    }
  }
}

// 空白页面用于显示广告
class _RewardedAdPage extends StatefulWidget {
  final Function(RewardItem?) onRewardEarned;

  const _RewardedAdPage({Key? key, required this.onRewardEarned})
      : super(key: key);

  @override
  State<_RewardedAdPage> createState() => _RewardedAdPageState();
}

class _RewardedAdPageState extends State<_RewardedAdPage> {
  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedInterstitialAd.load(
      adUnitId: AdManager.rewardedInterstitialAd.adUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {},
            onAdImpression: (ad) {},
            onAdFailedToShowFullScreenContent: (ad, err) {
              print('激励插页式广告显示失败: $err');
              ad.dispose();
              Navigator.pop(context);
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              widget.onRewardEarned(null);
              Navigator.pop(context);
                // 添加以下代码
  print('广告已关闭'); // 打印一条日志
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text('广告已关闭'),
  )); 
            },
            onAdClicked: (ad) {},
          );
          ad.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              widget.onRewardEarned(reward);
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('激励插页式广告加载失败: $error');
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  late InAppPurchaseManager inAppPurchaseManager;

  @override
  void initState() {
    super.initState();
    inAppPurchaseManager = InAppPurchaseManager(context);
    _loadPurchaseInfo();
  }

  Future<void> _loadPurchaseInfo() async {
    await inAppPurchaseManager.loadTempPurchaseInfo();
    await inAppPurchaseManager.loadPurchaseInfo();
    setState(() {}); // 更新UI以反映加载的信息
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('应用内购买'),
        bottom: inAppPurchaseManager.isPurchasesEnabled
            ? PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.green,
                  child: const Text(
                    '订阅有效',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 移除广告卡片            
            _buildPurchaseCard(
              title: '移除广告',
              description: '永久移除应用内所有广告，享受清爽的使用体验。',
              price: '¥6.00', // 添加价格信息
              buttonText: '购买',
              onTap: () {
                inAppPurchaseManager.purchaseConsumable('consumable_product_id');
              },
              backgroundColor: Colors.amber, // 设置卡片背景颜色
            ),
            const SizedBox(height: 16.0), // 添加卡片之间的间距

            // 订阅卡片 (月订阅和季度订阅)
            Row(
              children: [
                Expanded(
                  child: _buildPurchaseCard(
                    title: '月订阅',
                    description: '每月解锁高级功能，包括独家内容和优先支持。',
                    price: '¥18.00',
                    buttonText: '订阅',
                    onTap: () {
                      inAppPurchaseManager
                          .purchaseNonConsumable('monthly_subscription_id');
                    },
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildPurchaseCard(
                    title: '季度订阅',
                    description: '每季度解锁高级功能，享受更优惠的价格。',
                    price: '¥48.00',
                    buttonText: '订阅',
                    onTap: () {
                      inAppPurchaseManager
                          .purchaseNonConsumable('quarterly_subscription_id');
                    },
                    backgroundColor: Colors.purpleAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // 永久买断卡片
            _buildPurchaseCard(
              title: '永久买断',
              description: '一次性购买，永久解锁所有高级功能和未来更新。',
              price: '¥98.00',
              buttonText: '购买',
              onTap: () {
                inAppPurchaseManager.purchaseNonConsumable('lifetime_purchase_id');
              },
              backgroundColor: Colors.greenAccent,
            ),
            const SizedBox(height: 20),

            // 激励广告卡片
            _buildPurchaseCard(
              title: '观看广告获取临时权限',
              description: '观看一段短广告，即可临时解锁部分高级功能。',
              price: inAppPurchaseManager.hasTempPurchase
                ? '到期时间：${inAppPurchaseManager._tempPurchaseExpiryDate!.toLocal().toString().substring(0, 19)}' // 显示到秒
                : '¥0.00', // 根据是否有临时权限显示不同的价格信息
              buttonText: '观看广告',
              onTap: () {
                inAppPurchaseManager.showRewardedAd(context);
                setState(() {}); // 购买后更新界面
              },
              backgroundColor: Colors.greenAccent,
            ),
            if (inAppPurchaseManager.hasTempPurchase)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '临时权限到期时间：${inAppPurchaseManager._tempPurchaseExpiryDate!.toLocal()}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 购买卡片 Widget
  Widget _buildPurchaseCard({
    required String title,
    required String description,
    required String price, // 添加价格参数
    required String buttonText,
    required VoidCallback onTap,
    required Color backgroundColor, // 添加背景颜色参数
  }) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), // 设置圆角
      color: backgroundColor, // 设置背景颜色
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // 按钮背景颜色
                    foregroundColor: backgroundColor, // 按钮文字颜色
                  ),
                  child: Text(buttonText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}