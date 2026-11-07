import 'dart:async';
import 'dart:collection';
import 'dart:isolate';

import 'package:pyro_api_translate/src/translation_service.dart';

import '../../providers/translation_provider.dart';
import '../../utils/language_mapper.dart';
import 'provider_state.dart';

/// A scheduled task awaiting execution.
class _Task {
  final String text;
  final String sourceLanguage;
  final String targetLanguage;
  final Completer<String> completer;
  int attempts = 0;
  final Set<String> failedProviders = {};

  _Task(this.text, this.completer, this.sourceLanguage, this.targetLanguage);
}

/// The Brain of the Translation Mesh.
/// Distributes tasks to providers using Round-Robin scheduling and manages the Worker Pool.
class TranslationScheduler {
  final List<ProviderState> _workers = [];
  final Queue<_Task> _jobQueue = Queue<_Task>();
  final Map<String, String> _providerCsvKeys;
  final Map<String, Future<String>> _inFlightRequests = {};

  // Timer for periodical dispatch checks (heartbeat)
  Timer? _heartbeat;

  TranslationScheduler(
    Map<String, TranslationProvider> providers,
    this._providerCsvKeys,
  ) {
    // Initialize workers from the provider map
    providers.forEach((name, provider) {
      _workers.add(ProviderState(
        name: name,
        provider: provider,
        // We can differentiate base cooldowns here if needed
        baseCooldown: const Duration(seconds: 1),
      ));
    });

    // 事件驱动触发：闲置时零 Timer 驻留，拒绝无意义心跳轮询 CPU
  }

  String _buildCacheKey(String text, String sourceLanguage, String targetLanguage) {
    final cleaned = text.trim();
    final src = sourceLanguage.toLowerCase();
    final tgt = targetLanguage.toLowerCase();
    if (cleaned.length <= 100) {
      return '$src->$tgt:$cleaned';
    } else {
      return '$src->$tgt:${cleaned.hashCode}';
    }
  }

  /// Schedule a translation task with In-Flight Deduplication.
  /// Returns a Future that completes when any provider successfully translates the text.
  Future<String> schedule(String text,
      {String sourceLanguage = 'auto', String targetLanguage = 'en'}) {
    final cacheKey = _buildCacheKey(text, sourceLanguage, targetLanguage);

    // 1. In-Flight Deduplication: If identical request is already running, reuse its Future directly!
    if (_inFlightRequests.containsKey(cacheKey)) {
      print('⚡ [TranslationScheduler] In-Flight Deduplication HIT for key: "$cacheKey". Sharing running Future.');
      return _inFlightRequests[cacheKey]!;
    }

    final completer = Completer<String>();
    final future = completer.future;

    _inFlightRequests[cacheKey] = future;
    future.whenComplete(() {
      _inFlightRequests.remove(cacheKey);
    });

    // Add to queue
    _jobQueue.add(_Task(text, completer, sourceLanguage, targetLanguage));

    // Trigger immediate dispatch attempt
    _dispatch();

    return future;
  }

  /// Core Dispatch Loop.
  /// Assigns pending tasks to READY workers.
  void _dispatch() {
    if (_jobQueue.isEmpty) {
      _heartbeat?.cancel();
      _heartbeat = null;
      return;
    }

    while (_jobQueue.isNotEmpty) {
      final task = _jobQueue.first;
      final isAuto = task.sourceLanguage == 'auto';

      // 1. Calculate eligible workers that support this task configuration
      final eligibleWorkers = _workers.where((w) {
        if (isAuto && !w.provider.supportsAuto) {
          return false;
        }
        return true;
      }).toList();

      if (eligibleWorkers.isEmpty) {
        // No workers support auto or the requested task config
        _jobQueue.removeFirst();
        if (!task.completer.isCompleted) {
          task.completer.completeError(
            Exception(
              'No available providers support sourceLanguage="${task.sourceLanguage}"',
            ),
          );
        }
        continue;
      }

      // 2. Fast-Fail Check: If ALL eligible workers are in OPEN circuit state and not ready
      final allOpenCircuit = eligibleWorkers.every(
          (w) => w.circuitState == CircuitState.open && !w.isReady);

      if (allOpenCircuit) {
        _jobQueue.removeFirst();
        if (!task.completer.isCompleted) {
          task.completer.completeError(
            Exception(
              'All eligible translation providers are currently isolated by Circuit Breaker (OPEN). Fast-failing task.',
            ),
          );
        }
        continue;
      }

      // 3. Check if all eligible workers have already failed for this task
      final failedEligibleCount = eligibleWorkers
          .where((w) => task.failedProviders.contains(w.name))
          .length;

      if (failedEligibleCount >= eligibleWorkers.length ||
          task.attempts >= eligibleWorkers.length * 2) {
        _jobQueue.removeFirst();
        if (!task.completer.isCompleted) {
          task.completer.completeError(
            Exception(
              'All eligible translation providers failed: [${task.failedProviders.join(', ')}]',
            ),
          );
        }
        continue;
      }

      // 4. Find the first worker that is READY AND eligible
      final workerIndex = _workers.indexWhere((w) {
        if (!w.isReady) return false;
        if (isAuto && !w.provider.supportsAuto) {
          return false;
        }
        return true;
      });

      if (workerIndex == -1) {
        // 挂起状态：全量 Worker 处于冷却/熔断中，仅在有任务时开启一次性 Timer 恢复响应，队列清空即销毁
        if (_heartbeat == null || !_heartbeat!.isActive) {
          _heartbeat = Timer(const Duration(milliseconds: 500), _dispatch);
        }
        return;
      }

      // Found a ready worker
      final worker = _workers[workerIndex];
      _jobQueue.removeFirst();

      _assignTask(worker, task, eligibleWorkers.length);

      // Mandatory Round Skip logic:
      // Move this worker to the end of the line so others get a chance.
      _workers.removeAt(workerIndex);
      _workers.add(worker);
    }
  }

  /// Execute the task on the specific worker.
  Future<void> _assignTask(
      ProviderState worker, _Task task, int eligibleCount) async {
    worker.markBusy();
    task.attempts++;

    try {
      // 1. Prepare Languages
      final csvKey = _providerCsvKeys[worker.name] ?? 'google';
      final mappedTarget = LanguageMapper.getCode(csvKey, task.targetLanguage);
      final mappedSource = task.sourceLanguage == 'auto'
          ? 'auto'
          : LanguageMapper.getCode(csvKey, task.sourceLanguage);

      final workerName = worker.name;
      final textToTranslate = task.text;

      // 直接主线程非阻塞异步调度，规避后台 Isolate 丢失 rootBundle 资产与创建/销毁线程开销
      final result = await worker.provider.translate(
        textToTranslate,
        sourceLanguage: mappedSource,
        targetLanguage: mappedTarget,
      );

      if (result.isNotEmpty) {
        // Success!
        worker.markFinished(success: true);
        if (!task.completer.isCompleted) {
          task.completer.complete(result);
        }
      } else {
        throw Exception('Provider ${worker.name} returned empty result');
      }
    } catch (e) {
      // Failure
      worker.markFinished(success: false);
      task.failedProviders.add(worker.name);
      print('[Scheduler] Provider "${worker.name}" failed: $e');

      // 智能熔断级联风暴：最多尝试 3 个 Provider 代理，防止无解问题引发全部 10+ 渠道链式爆炸
      final maxAllowedFailures = eligibleCount < 3 ? eligibleCount : 3;

      if (task.failedProviders.length >= maxAllowedFailures ||
          task.attempts >= maxAllowedFailures * 2) {
        if (!task.completer.isCompleted) {
          task.completer.completeError(
            Exception(
              'All eligible translation providers failed: [${task.failedProviders.join(', ')}] - last error: $e',
            ),
          );
        }
      } else {
        // Re-queue the task at the HEAD (High Priority)
        if (!task.completer.isCompleted) {
          _jobQueue.addFirst(task);
        }
      }
    } finally {
      // Trigger dispatch again to pick up new tasks or re-queued tasks
      _dispatch();
    }
  }

  void dispose() {
    _heartbeat?.cancel();
  }
}
