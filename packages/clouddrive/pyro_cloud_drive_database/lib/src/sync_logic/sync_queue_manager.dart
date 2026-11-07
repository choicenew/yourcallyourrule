import 'dart:async';
import '../models/sync_task.dart';

class SyncQueueManager {
  final List<SyncTask> _queue = [];
  bool _isProcessing = false;
  final _taskController = StreamController<SyncTask>.broadcast();

  Stream<SyncTask> get taskUpdates => _taskController.stream;
  List<SyncTask> get queuedTasks => List.unmodifiable(_queue);

  void enqueue(SyncTask task) {
    _queue.add(task);
    _taskController.add(task);
  }

  void updateTask(SyncTask task) {
    final idx = _queue.indexWhere((t) => t.id == task.id);
    if (idx != -1) {
      _queue[idx] = task;
      _taskController.add(task);
    }
  }

  SyncTask? dequeue() {
    if (_queue.isEmpty) return null;
    return _queue.removeAt(0);
  }

  bool get isProcessing => _isProcessing;
  set isProcessing(bool val) => _isProcessing = val;
}
