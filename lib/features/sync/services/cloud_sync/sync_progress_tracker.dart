import 'dart:async';
import 'package:flutter/foundation.dart';

/// Enum representing different sync operation types
enum SyncOperationType {
  /// Initialization
  initialization,
  
  /// Rules sync
  rulesSync,
  
  /// Settings sync
  settingsSync,
  
  /// Notification history sync
  notificationSync,
  
  /// Device sync
  deviceSync,
  
  /// General sync
  generalSync,
  
  /// Finalization
  finalization
}

/// Class representing sync progress information
class SyncProgressInfo {
  /// Current operation type
  final SyncOperationType operationType;
  
  /// Progress percentage (0-100)
  final double progress;
  
  /// Current operation description
  final String message;
  
  /// Whether the operation has an error
  final bool hasError;
  
  /// Error message if any
  final String? errorMessage;
  
  /// Total items to process
  final int? totalItems;
  
  /// Current item being processed
  final int? currentItem;
  
  /// Constructor
  SyncProgressInfo({
    required this.operationType,
    required this.progress,
    required this.message,
    this.hasError = false,
    this.errorMessage,
    this.totalItems,
    this.currentItem,
  });
  
  /// Create a copy with updated values
  SyncProgressInfo copyWith({
    SyncOperationType? operationType,
    double? progress,
    String? message,
    bool? hasError,
    String? errorMessage,
    int? totalItems,
    int? currentItem,
  }) {
    return SyncProgressInfo(
      operationType: operationType ?? this.operationType,
      progress: progress ?? this.progress,
      message: message ?? this.message,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      totalItems: totalItems ?? this.totalItems,
      currentItem: currentItem ?? this.currentItem,
    );
  }
}

/// Class responsible for tracking and reporting sync progress
class SyncProgressTracker extends ChangeNotifier {
  /// Current progress information
  SyncProgressInfo _currentProgress = SyncProgressInfo(
    operationType: SyncOperationType.initialization,
    progress: 0,
    message: 'Initializing sync...',
  );
  
  /// Stream controller for progress updates
  final StreamController<SyncProgressInfo> _progressStreamController = 
      StreamController<SyncProgressInfo>.broadcast();
  
  /// Get current progress information
  SyncProgressInfo get currentProgress => _currentProgress;
  
  /// Get progress stream
  Stream<SyncProgressInfo> get progressStream => _progressStreamController.stream;
  
  /// Update progress information
  void updateProgress({
    SyncOperationType? operationType,
    double? progress,
    String? message,
    bool? hasError,
    String? errorMessage,
    int? totalItems,
    int? currentItem,
  }) {
    _currentProgress = _currentProgress.copyWith(
      operationType: operationType,
      progress: progress,
      message: message,
      hasError: hasError,
      errorMessage: errorMessage,
      totalItems: totalItems,
      currentItem: currentItem,
    );
    
    // Notify listeners
    notifyListeners();
    
    // Add to stream
    _progressStreamController.add(_currentProgress);
  }
  
  /// Update progress for a specific operation with item count
  void updateItemProgress({
    required SyncOperationType operationType,
    required int currentItem,
    required int totalItems,
    String? message,
  }) {
    final progress = totalItems > 0 ? (currentItem / totalItems * 100).toDouble() : 0.0;
    final defaultMessage = 'Processing $currentItem of $totalItems ${operationType.toString().split('.').last}';
    
    updateProgress(
      operationType: operationType,
      progress: progress,
      message: message ?? defaultMessage,
      totalItems: totalItems,
      currentItem: currentItem,
    );
  }
  
  /// Report an error
  void reportError({
    required String errorMessage,
    SyncOperationType? operationType,
  }) {
    updateProgress(
      operationType: operationType ?? _currentProgress.operationType,
      hasError: true,
      errorMessage: errorMessage,
    );
  }
  
  /// Reset progress tracker
  void reset() {
    _currentProgress = SyncProgressInfo(
      operationType: SyncOperationType.initialization,
      progress: 0,
      message: 'Initializing sync...',
    );
    notifyListeners();
    _progressStreamController.add(_currentProgress);
  }
  
  /// Mark sync as complete
  void markComplete() {
    updateProgress(
      operationType: SyncOperationType.finalization,
      progress: 100,
      message: 'Sync completed successfully',
    );
  }
  
  @override
  void dispose() {
    _progressStreamController.close();
    super.dispose();
  }
}