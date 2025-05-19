import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';

class CallStatisticsService {
  // 获取总拦截数量
  int getTotalBlockedCount(List<CallLog> callLogs) {
    // 计算被拦截的通话数量 - 使用labelIds判断是否被拦截
    return callLogs.where((log) => 
      log.labelIds != null && log.labelIds!.isNotEmpty
    ).length;
  }

  // 获取本周拦截电话数量
  int getWeeklyBlockedCallsCount(List<CallLog> callLogs) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekStartTimestamp = DateTime(weekStart.year, weekStart.month, weekStart.day);

    return callLogs.where((log) => 
      log.labelIds != null && 
      log.labelIds!.isNotEmpty && 
      log.timestamp.isAfter(weekStartTimestamp)
    ).length;
  }

  // 获取本周过滤短信数量
  int getWeeklyFilteredSmsCount(List<CallLog> callLogs) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekStartTimestamp = DateTime(weekStart.year, weekStart.month, weekStart.day);

    // 通过标签ID判断是否为短信拦截
    return callLogs.where((log) => 
      log.labelIds != null && 
      log.labelIds!.any((id) => id.contains('sms')) && 
      log.timestamp.isAfter(weekStartTimestamp)
    ).length;
  }

  // 获取白名单规则数量
  int getWhitelistRulesCount(List<RuleBase> rules) {
    return rules.where((rule) => 
      rule.action == RuleAction.allow && 
      rule.isEnabled
    ).length;
  }

  // 获取黑名单规则数量
  int getBlacklistRulesCount(List<RuleBase> rules) {
    return rules.where((rule) => 
      rule.action == RuleAction.block && 
      rule.isEnabled
    ).length;
  }
  
  // 获取时间规则数量 - 通过检查TimeInterceptorConfig配置判断
  Future<int> getTimeRulesCount(ConfigRepository configRepository) async {
    // 时间拦截器规则在time_interceptor目录下单独实现，不是通过RuleBase子类实现
    // 需要通过配置仓库检查是否启用了时间拦截功能
    int rulesCount = 0;
    
    // 检查全局时间拦截配置
    final configMap = await configRepository.getConfig('time_interceptor');
    if (configMap != null && configMap['shouldIntercept'] == true) {
      rulesCount++; // 如果全局时间拦截功能已启用，计为1条规则
    }
    
    // 检查各个SIM卡的时间拦截配置
    final simConfigMap = await configRepository.getConfig('sim_time_interceptor');
    if (simConfigMap != null) {
      // 遍历所有SIM卡配置
      for (var entry in simConfigMap.entries) {
        // 检查每个SIM卡的时间拦截配置是否启用
        if (entry.value is Map && entry.value['shouldIntercept'] == true) {
          rulesCount++; // 如果该SIM卡的时间拦截功能已启用，计数加1
        }
      }
    }
    
    return rulesCount; // 返回所有启用的时间拦截规则数量
  }

  // 计算拦截类型分析
  Map<String, double> getBlockTypeAnalysis(List<CallLog> callLogs) {
    final Map<String, int> typeCounts = {};
    int totalBlocked = 0;
    
    // 统计各类型拦截数量 - 使用labelIds判断
    for (final log in callLogs) {
      if (log.labelIds != null && log.labelIds!.isNotEmpty) {
        final type = _getBlockType(log);
        typeCounts[type] = (typeCounts[type] ?? 0) + 1;
        totalBlocked++;
      }
    }
    
    // 计算百分比
    final Map<String, double> typePercentages = {};
    if (totalBlocked > 0) {
      typeCounts.forEach((type, count) {
        typePercentages[type] = (count / totalBlocked) * 100;
      });
    }
    
    return typePercentages;
  }
  
  // 根据通话记录判断拦截类型
  String _getBlockType(CallLog log) {
    // 使用标签ID作为类型标识，这样可以通过LabelTextUtils.getLabelTextById获取本地化文本
    if (log.labelIds != null && log.labelIds!.isNotEmpty) {
      // 直接返回标签ID，由UI层负责获取对应的显示文本
      return log.labelIds!.first;
    }
    
    // 如果没有标签ID，返回默认类型
    return 'unknown'; // 使用标准化的标签ID
  }
  
  // 获取所有拦截类型的标签ID列表
  List<String> getAllBlockTypes(List<CallLog> callLogs) {
    final Set<String> types = {};
    
    for (final log in callLogs) {
      if (log.labelIds != null && log.labelIds!.isNotEmpty) {
        types.add(_getBlockType(log));
      }
    }
    
    return types.toList();
  }
  
  // 计算月度增长率
  double calculateMonthlyGrowthRate(List<CallLog> callLogs) {
    final now = DateTime.now();
    final currentMonthStart = DateTime(now.year, now.month, 1);
    final lastMonthStart = DateTime(now.year, now.month - 1, 1);
    
    final currentMonthBlocked = callLogs.where((log) => 
      log.labelIds != null && 
      log.labelIds!.isNotEmpty && 
      log.timestamp.isAfter(currentMonthStart)
    ).length;
    
    final lastMonthBlocked = callLogs.where((log) => 
      log.labelIds != null && 
      log.labelIds!.isNotEmpty && 
      log.timestamp.isAfter(lastMonthStart) &&
      log.timestamp.isBefore(currentMonthStart)
    ).length;
    
    if (lastMonthBlocked == 0) {
      return currentMonthBlocked > 0 ? 100.0 : 0.0;
    }
    
    return ((currentMonthBlocked - lastMonthBlocked) / lastMonthBlocked) * 100;
  }
  
  // 获取按日期分组的拦截数据
  Map<DateTime, int> getBlockedCallsByDate(List<CallLog> callLogs, String period) {
    final Map<DateTime, int> result = {};
    final now = DateTime.now();
    
    // 根据周期确定日期范围
    DateTime startDate;
    if (period == '周') {
      startDate = now.subtract(const Duration(days: 7));
    } else if (period == '月') {
      startDate = DateTime(now.year, now.month - 1, now.day);
    } else { // 年
      startDate = DateTime(now.year - 1, now.month, now.day);
    }
    
    // 筛选并按日期分组
    for (final log in callLogs) {
      if (log.labelIds != null && 
          log.labelIds!.isNotEmpty && 
          log.timestamp.isAfter(startDate)) {
        // 根据周期确定分组键
        DateTime key;
        if (period == '周' || period == '月') {
          // 按天分组
          key = DateTime(log.timestamp.year, log.timestamp.month, log.timestamp.day);
        } else {
          // 按月分组
          key = DateTime(log.timestamp.year, log.timestamp.month, 1);
        }
        
        result[key] = (result[key] ?? 0) + 1;
      }
    }
    
    return result;
  }
}