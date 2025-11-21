import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/provider/providers/device_id_service_provider.dart';
import 'package:yourcallyourrule/data/database/sync/api_service.dart';

/// 一个独立的测试按钮 Widget，用于手动触发一次 PUSH 同步测试。
///
/// 使用方法：
/// 1. 将此 Widget 放置在您想测试的页面的任意位置。
/// 2. 确保您的项目中有一个 `deviceIdServiceProvider`。
/// 3. 点击按钮，观察 Debug Console 的日志和按钮下方的状态文本。
class TestSyncButton extends ConsumerStatefulWidget {
  const TestSyncButton({super.key});

  @override
  ConsumerState<TestSyncButton> createState() => _TestSyncButtonState();
}

class _TestSyncButtonState extends ConsumerState<TestSyncButton> {
  bool _isLoading = false;
  String _statusMessage = 'Ready to test PUSH';

  // --- 核心测试函数 ---
  Future<void> _runTest() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Test in progress...';
    });

    debugPrint("--- [MANUAL TEST STARTED] ---");

    try {
      // 1. 准备依赖
      final apiService = ApiService();
      final deviceIdService = ref.read(deviceIdServiceProvider);
      final deviceId = await deviceIdService.getDeviceId();

      // 2. 准备 PROPOSE_DELETION 测试数据
      // 这个数据结构现在与 worker.js 的期望完全匹配
      final testOperations = [
        {
          "id": "test-proposal-op-${DateTime.now().millisecondsSinceEpoch}",
          "entityId": "+19998887777", // 每次测试都用一个全新的号码以避免冲突
          "operation": "PROPOSE_DELETION",
          "timestamp": DateTime.now().toUtc().toIso8601String(),
          "payload": {
            "report": {
              "finalRisk": "Low",
              "isNumberMatch": false,
              "deviceId": deviceId,
              "reason": "This is a final and correct manual test proposal."
            },
            "timestamp": DateTime.now().toUtc().toIso8601String()
          }
        }
      ];

      debugPrint("--- [MANUAL TEST] Pushing CORRECT proposal data to worker...");
      debugPrint("--- [MANUAL TEST] Data: $testOperations");

      // 3. 调用 pushChanges 方法
      final bool success = await apiService.pushChanges(
        changes: testOperations,
        deviceId: deviceId,
      );

      debugPrint("--- [MANUAL TEST FINISHED] --- Push success: $success");

      setState(() {
        _statusMessage = success
            ? '✅ SUCCESS! Check deletion_proposals table on D1.'
            : '❌ FAILED. Check logs for API response.';
      });

    } catch (e, stackTrace) {
      debugPrint("--- [MANUAL TEST FAILED WITH EXCEPTION] ---");
      debugPrint("EXCEPTION: $e");
      debugPrint("STACK TRACE: $stackTrace");
      setState(() {
        _statusMessage = '🔥 EXCEPTION! Check logs for details.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.deepPurple.shade100),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Backend Sync Test',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.cloud_upload),
            label: const Text('Test PROPOSE_DELETION'),
            onPressed: _isLoading ? null : _runTest,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isLoading ? Colors.grey : Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _statusMessage,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}