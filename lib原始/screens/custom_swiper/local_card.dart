import 'package:flutter/material.dart';
import '../../utils/blocked_call_repository.dart';
import '../callerID/callerid_overlay_mock.dart';
import 'card.dart';
import '../../views/call_history/blocked_calls.dart';
import '../../views/call_history/blocked_calls_chart.dart';
import '../callerID/callerid_customization_page.dart';

List<CardItem> localCardsData = [
  const CardItem(
    title: "localCard1", // 使用字符串字面量
    content: "localCard1Content", // 使用字符串字面量
    //imageUrl: '',
    // url: '',
    titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    contentTextStyle: TextStyle(fontSize: 20),
    backgroundColor: Color(0xD9FFB0B0),
    borderRadius: 20.0,
  ),
  // Add more local cards here...
  CardItem(
    title: "blockedCallsStatistics", // 使用字符串字面量
    content: BlockedCallsChart(repository: BlockedCallRepository()),
    //imageUrl: '',
    // url: '',
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                BlockedCallsPage(repository: BlockedCallRepository())),
      );
    },
    titleTextStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
    contentTextStyle: const TextStyle(fontSize: 10),
    backgroundColor: const Color.fromRGBO(162, 255, 131, 0.98),
    borderRadius: 20.0,
  ),
  // Add more local cards here...
  CardItem(
    title: "callerIdStyle", // 使用字符串字面量
    // content: "callerIdStyleContent", // 使用字符串字面量
    content: const CallerIdSample(),

    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CallerIdCustomizationPage()),
      );
    },
    titleTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    contentTextStyle: const TextStyle(fontSize: 14),
    backgroundColor: const Color.fromARGB(217, 79, 244, 104),
    borderRadius: 20.0,
  ),
  const CardItem(
    title: "translation", // 使用字符串字面量
    content: "TheTranslationContent", // 使用字符串字面量
    //imageUrl: '',
    url: 'https://github.com/haygcao/yourcallyourruletranslation',
    titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    contentTextStyle: TextStyle(fontSize: 14),
    backgroundColor: Color(0xFFB7E0FF),
    borderRadius: 20.0,
  ),
];
