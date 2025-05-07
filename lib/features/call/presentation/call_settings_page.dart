import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/label/label_entry.dart';
import 'package:yourcallyourrule/features/common/services/label_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/labeled_service_card.dart';

/// 来电设置页面
/// 展示如何使用可复用的标签组件和服务卡片
class CallSettingsPage extends StatefulWidget {
  const CallSettingsPage({super.key});

  @override
  State<CallSettingsPage> createState() => _CallSettingsPageState();
}

class _CallSettingsPageState extends State<CallSettingsPage> {
  bool _isCallerIdEnabled = true;
  bool _isCallFilterEnabled = true;
  bool _isTimeInterceptorEnabled = false;

  @override
  Widget build(BuildContext context) {
    // 构建服务卡片列表
    final serviceCards = [
      // 来电识别服务卡片
      LabelServiceComponent(
        serviceTitle: '来电识别',
        serviceDescription: '识别未知来电，标记骚扰电话和诈骗电话',
        serviceIcon: Icons.phone,
        serviceGradientColors: const [Color(0xFF64B5F6), Color(0xFF2196F3)],
        isEnabled: _isCallerIdEnabled,
        onLabelSelected: (LabelEntry label) {
          _handleCallerIdLabelSelected(label);
        },
      ),
      const SizedBox(height: 16),

      // 来电过滤服务卡片
      LabelServiceComponent(
        serviceTitle: '来电过滤',
        serviceDescription: '自动拦截骚扰电话和诈骗电话',
        serviceIcon: Icons.block,
        serviceGradientColors: const [Color(0xFFFFB74D), Color(0xFFFF9800)],
        isEnabled: _isCallFilterEnabled,
        onLabelSelected: (LabelEntry label) {
          _handleCallFilterLabelSelected(label);
        },
      ),
      const SizedBox(height: 16),

      // 时间拦截服务卡片
      LabeledServiceCard(
        title: '时间拦截',
        description: '在指定时间段内自动拦截所有来电',
        labels: const ['工作时间', '睡眠时间', '会议时间'],
        icon: Icons.access_time,
        onTap: () => _toggleTimeInterceptor(),
        gradientColors: const [Color(0xFF81C784), Color(0xFF4CAF50)],
        isEnabled: _isTimeInterceptorEnabled,
        trailing: Switch(
          value: _isTimeInterceptorEnabled,
          onChanged: (value) => _toggleTimeInterceptor(),
          activeColor: Colors.white,
        ),
      ),
      const SizedBox(height: 16),

      // 添加更多服务卡片
      LabeledServiceCard(
        title: '标签管理',
        description: '管理所有标签，添加、编辑和删除标签',
        labels: const ['标签管理', '自定义标签'],
        icon: Icons.label,
        onTap: () => _navigateToLabelServicePage(),
        gradientColors: const [Color(0xFF9575CD), Color(0xFF673AB7)],
        isEnabled: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('来电设置'),
        backgroundColor: const Color(0xFFF5A623),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFE3F2FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              ...serviceCards,
            ],
          ),
        ),
      ),
    );
  }

  // 处理来电识别标签选择
  void _handleCallerIdLabelSelected(LabelEntry label) {
    setState(() {
      _isCallerIdEnabled = true;
    });

    // 显示成功提示
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('已将 ${label.phoneNumber} 标记为 ${label.label}'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8),
    ));
  }

  // 处理来电过滤标签选择
  void _handleCallFilterLabelSelected(LabelEntry label) {
    setState(() {
      _isCallFilterEnabled = true;
    });

    // 显示成功提示
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('已将 ${label.phoneNumber} 添加到 ${label.label} 过滤列表'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8),
    ));
  }

  // 切换时间拦截器状态
  void _toggleTimeInterceptor() {
    setState(() {
      _isTimeInterceptorEnabled = !_isTimeInterceptorEnabled;
    });

    // 显示状态提示
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(_isTimeInterceptorEnabled ? '时间拦截已启用' : '时间拦截已禁用'),
      backgroundColor: _isTimeInterceptorEnabled ? Colors.green : Colors.orange,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8),
    ));
  }

  // 导航到标签服务页面
  void _navigateToLabelServicePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LabelServicePage()),
    );
  }
}

/// 短信设置页面
/// 展示如何使用可复用的标签组件和服务卡片
class SmsSettingsPage extends StatefulWidget {
  const SmsSettingsPage({Key? key}) : super(key: key);

  @override
  State<SmsSettingsPage> createState() => _SmsSettingsPageState();
}

class _SmsSettingsPageState extends State<SmsSettingsPage> {
  bool _isSmsFilterEnabled = true;
  bool _isKeywordFilterEnabled = false;

  @override
  Widget build(BuildContext context) {
    // 构建服务卡片列表
    final serviceCards = [
      // 短信过滤服务卡片
      LabelServiceComponent(
        serviceTitle: '短信过滤',
        serviceDescription: '自动拦截垃圾短信和诈骗短信',
        serviceIcon: Icons.sms,
        serviceGradientColors: const [Color(0xFFFFB74D), Color(0xFFFF9800)],
        isEnabled: _isSmsFilterEnabled,
        onLabelSelected: (LabelEntry label) {
          _handleSmsFilterLabelSelected(label);
        },
      ),
      const SizedBox(height: 16),

      // 关键词过滤服务卡片
      LabeledServiceCard(
        title: '关键词过滤',
        description: '根据关键词自动拦截短信',
        labels: const ['贷款', '中奖', '发票', '验证码'],
        icon: Icons.filter_list,
        onTap: () => _toggleKeywordFilter(),
        gradientColors: const [Color(0xFF81C784), Color(0xFF4CAF50)],
        isEnabled: _isKeywordFilterEnabled,
        trailing: Switch(
          value: _isKeywordFilterEnabled,
          onChanged: (value) => _toggleKeywordFilter(),
          activeColor: Colors.white,
        ),
      ),
      const SizedBox(height: 16),

      // 添加更多服务卡片
      LabeledServiceCard(
        title: '标签管理',
        description: '管理所有标签，添加、编辑和删除标签',
        labels: const ['标签管理', '自定义标签'],
        icon: Icons.label,
        onTap: () => _navigateToLabelServicePage(),
        gradientColors: const [Color(0xFF9575CD), Color(0xFF673AB7)],
        isEnabled: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('短信设置'),
        backgroundColor: const Color(0xFFF5A623),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFFFF3E0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              ...serviceCards,
            ],
          ),
        ),
      ),
    );
  }

  // 处理短信过滤标签选择
  void _handleSmsFilterLabelSelected(LabelEntry label) {
    setState(() {
      _isSmsFilterEnabled = true;
    });

    // 显示成功提示
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('已将 ${label.phoneNumber} 添加到短信过滤列表'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8),
    ));
  }

  // 切换关键词过滤状态
  void _toggleKeywordFilter() {
    setState(() {
      _isKeywordFilterEnabled = !_isKeywordFilterEnabled;
    });

    // 显示状态提示
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(_isKeywordFilterEnabled ? '关键词过滤已启用' : '关键词过滤已禁用'),
      backgroundColor: _isKeywordFilterEnabled ? Colors.green : Colors.orange,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8),
    ));
  }

  // 导航到标签服务页面
  void _navigateToLabelServicePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LabelServicePage()),
    );
  }
}