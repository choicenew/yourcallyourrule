/// Workmanager 后台离线任务标识常量表
class BackgroundTaskKeys {
  BackgroundTaskKeys._();

  /// 通话记录同步任务键名 ('syncCallLogTask')
  static const String syncCallLogTask = 'syncCallLogTask';

  /// 规则与插件自动更新任务键名 ('autoUpdateTask')
  static const String autoUpdateTask = 'autoUpdateTask';

  /// 增量数据同步任务键名 ('dataSyncTask')
  static const String dataSyncTask = 'dataSyncTask';

  /// 后台同步统一 Tag 标识 ('com.yourcallyourrule.sync')
  static const String syncTaskTag = 'com.yourcallyourrule.sync';

  /// 通话记录周期任务注册 ID ('1')
  static const String callLogTaskId = '1';

  /// 规则自动更新周期任务注册 ID ('2')
  static const String autoUpdateTaskId = '2';
}
