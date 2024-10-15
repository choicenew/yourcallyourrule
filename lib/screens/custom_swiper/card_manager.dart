
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';

import 'card.dart';
import 'local_card.dart';

class CardManager {
  List<CardItem> _finalCards = [];
  Timer? _updateTimer;

  // 添加缓存机制
  bool _isDataLoaded = false;
  DateTime? _lastUpdated; // 记录最后更新时间

  CardManager() {
    _initializeCards();
    _scheduleWeeklyUpdate();
  }

  void _initializeCards() {
    _finalCards.addAll(localCardsData);
    _fetchRemoteData();
  }


  void _scheduleWeeklyUpdate() {
    if (!_isDataLoaded) { // 仅在数据未加载时才启动定时器
      _fetchRemoteData(); // 首次加载数据
      const duration = Duration(days: 7); 
      _updateTimer = Timer.periodic(duration, (Timer timer) {
        if (_shouldUpdateData()) {
          _fetchRemoteData();
        }
      });
    }
  }

  Future<void> _fetchRemoteData() async {
    final url = Uri.parse('https://raw.githubusercontent.com/haygcao/yourcallyourruletranslation/main/cards'); // 替换为实际的 API 地址
    try {
      var response = await http.get(url);
          // 打印状态码
    //
      if (response.statusCode == 200) {
        List<CardItem> remoteCards = _parseCards(response.body);
        _finalCards.clear();
        _finalCards.addAll(localCardsData);
        _finalCards.addAll(remoteCards);
//添加缓存机制
        _isDataLoaded = true;
        _lastUpdated = DateTime.now(); // 更新最后更新时间
//结束缓存
      } else {
      }
    } catch (e) {
      //
    }
  }

List<CardItem> _parseCards(String responseBody) {
  final trimmedResponseBody = responseBody.trim(); // Trim whitespace and newlines
  final parsed = jsonDecode(trimmedResponseBody).cast<Map<String, dynamic>>();
  return parsed.map<CardItem>((json) => CardItem.fromJson(json)).toList();
}


//新版缓存
  Future<List<CardItem>> getFinalCards() async {
    if (!_isDataLoaded) { 
      await _fetchRemoteData();
    }
    return _finalCards;
  }

  bool _shouldUpdateData() {
    if (_lastUpdated == null) {
      return true; // 如果从未更新过，则需要更新
    }

    // 检查最后更新时间是否超过 7 天
    return DateTime.now().difference(_lastUpdated!).inDays >= 7; 
  }
//新版缓存

  void dispose() {
    _updateTimer?.cancel();
  }
}
