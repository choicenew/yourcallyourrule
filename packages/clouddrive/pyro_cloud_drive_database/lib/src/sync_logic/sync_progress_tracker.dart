import 'dart:async';

class SyncProgressTracker {
  final _controller = StreamController<double>.broadcast();
  double _currentProgress = 0.0;

  Stream<double> get progressStream => _controller.stream;
  double get currentProgress => _currentProgress;

  void updateProgress(double progress) {
    _currentProgress = progress.clamp(0.0, 1.0);
    _controller.add(_currentProgress);
  }

  void reset() {
    _currentProgress = 0.0;
    _controller.add(0.0);
  }

  void dispose() {
    _controller.close();
  }
}
