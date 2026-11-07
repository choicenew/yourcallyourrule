import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_api_translate/pyro_api_translate.dart';

// IMPORTANT: This script simulates high-concurrency translation requests
// to verify the "Translation Mesh" architecture (Scheduler + Worker Pool).

void main() {
  test('Translation Scheduler Stress Test', () async {
    print('================================================');
    print('🚀 Starting Translation Mesh Simulation (V6) 🚀');
    print('================================================');

    final service = TranslationService();

    // A list of 25 distinct words to saturate the 20+ providers
    final tasks = [
      'Apple',
      'Banana',
      'Cat',
      'Dog',
      'Elephant',
      'Flower',
      'Guitar',
      'House',
      'Ice',
      'Jelly',
      'Kite',
      'Lion',
      'Moon',
      'Night',
      'Orange',
      'Piano',
      'Queen',
      'Rabbit',
      'Sun',
      'Tree',
      'Umbrella',
      'Violin',
      'Water',
      'Xylophone',
      'Yellow'
    ];

    print('📦 Loaded ${tasks.length} tasks.');
    print('👥 Available Providers: ${service.availableProviders.length}');
    print('🔄 Strategy: Round-Robin Dispatch + Cooldown Pool');
    print('------------------------------------------------');

    // Launch all tasks "concurrently"
    // The Scheduler should queue them and dispatch to available workers.
    final futures = tasks.asMap().entries.map((entry) async {
      final index = entry.key;
      final word = entry.value;

      // Stagger slightly to mimic real-world burst, or just blast them all.
      // Let's blast them all to test the queue logic.
      await Future.delayed(Duration(milliseconds: index * 50));

      try {
        final start = DateTime.now();
        print('➕ [Task #$index] Requesting: "$word"');

        final result = await service.translate(word, targetLanguage: 'zh-CN');

        final duration = DateTime.now().difference(start).inMilliseconds;
        print(
            '✅ [Task #$index] Completed in ${duration}ms: "$word" -> "$result"');
      } catch (e) {
        print('❌ [Task #$index] Failed: $e');
      }
    });

    await Future.wait(futures);

    print('------------------------------------------------');
    print('🎉 All tasks processed.');
    print('================================================');
  }, timeout: Timeout(Duration(minutes: 2)));
}
