import 'package:flutter/material.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';

/// 来电频率拦截设置页面
/// 用于配置来电频率拦截服务的相关参数
class TimeInterceptorSettingsPage extends StatefulWidget {
  final TimeInterceptorService timeInterceptorService;
  final ConfigRepository configRepository;

  const TimeInterceptorSettingsPage({
    super.key,
    required this.timeInterceptorService,
    required this.configRepository,
  });

  @override
  TimeInterceptorSettingsPageState createState() => TimeInterceptorSettingsPageState();
}

class TimeInterceptorSettingsPageState extends State<TimeInterceptorSettingsPage> {
  // 配置参数
  bool _isEnabled = true;
  int _durationMinutes = 30;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// 加载设置
  Future<void> _loadSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 从服务中加载配置
      await widget.timeInterceptorService.loadConfig();
      final config = widget.timeInterceptorService.config;
      
      setState(() {
        _isEnabled = config.shouldIntercept;
        _durationMinutes = config.duration.inMinutes;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载设置失败: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 保存设置
  Future<void> _saveSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 更新服务配置
      await widget.timeInterceptorService.updateConfig(
        Duration(minutes: _durationMinutes),
        _isEnabled,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('设置已保存')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存设置失败: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('来电频率拦截设置'),
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveSettings,
              tooltip: '保存设置',
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildEnableSwitch(),
                const Divider(),
                _buildDurationSetting(),
                const SizedBox(height: 32),
                _buildExplanationCard(),
              ],
            ),
    );
  }

  /// 构建启用开关
  Widget _buildEnableSwitch() {
    return SwitchListTile(
      title: const Text('启用来电频率拦截'),
      subtitle: const Text('根据来电频率自动拦截可能的骚扰电话'),
      value: _isEnabled,
      onChanged: (value) {
        setState(() {
          _isEnabled = value;
        });
      },
    );
  }

  /// 构建时间窗口设置
  Widget _buildDurationSetting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('拦截时间窗口(分钟): $_durationMinutes', 
          style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Slider(
          value: _durationMinutes.toDouble(),
          min: 5,
          max: 120,
          divisions: 23,
          label: _durationMinutes.toString(),
          onChanged: (value) {
            setState(() {
              _durationMinutes = value.round();
            });
          },
        ),
        const Text('设置拦截重复来电的时间窗口大小，在此时间窗口内的重复来电将被拦截'),
      ],
    );
  }

  /// 构建说明卡片
  Widget _buildExplanationCard() {
    return const Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('来电频率拦截说明', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text('来电频率拦截功能通过分析来电频率，自动识别和拦截频繁骚扰电话。'),
            SizedBox(height: 8),
            Text('工作原理：'),
            Text('• 当同一号码在设定的时间窗口内多次呼叫时，系统会自动拦截'),
            Text('• 时间窗口越短，拦截越严格；时间窗口越长，拦截越宽松'),
            Text('• 系统会检查通话记录，判断是否为重复来电'),
            SizedBox(height: 8),
            Text('适用场景：'),
            Text('• 识别自动重拨的骚扰电话'),
            Text('• 拦截短时间内多次呼入的营销电话'),
            Text('• 防止电话轰炸和骚扰'),
            SizedBox(height: 8),
            Text('此功能与本地计数过滤器不同，它专注于短时间内的重复来电模式，而不是长期的标记次数。'),
          ],
        ),
      ),
    );
  }
}