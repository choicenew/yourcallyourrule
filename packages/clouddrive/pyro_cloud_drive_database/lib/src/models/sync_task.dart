enum SyncTaskType { uploadBackup, downloadBackup, syncTables, syncFiles }
enum SyncTaskStatus { pending, inProgress, completed, failed, cancelled }

class SyncTask {
  final String id;
  final SyncTaskType type;
  final SyncTaskStatus status;
  final double progress;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime? completedAt;

  const SyncTask({
    required this.id,
    required this.type,
    this.status = SyncTaskStatus.pending,
    this.progress = 0.0,
    this.errorMessage,
    required this.createdAt,
    this.completedAt,
  });

  SyncTask copyWith({
    SyncTaskStatus? status,
    double? progress,
    String? errorMessage,
    DateTime? completedAt,
  }) => SyncTask(
    id: id,
    type: type,
    status: status ?? this.status,
    progress: progress ?? this.progress,
    errorMessage: errorMessage ?? this.errorMessage,
    createdAt: createdAt,
    completedAt: completedAt ?? this.completedAt,
  );
}
