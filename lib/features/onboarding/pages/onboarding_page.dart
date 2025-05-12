import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/services/permission_service.dart';

/// 应用引导页面
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 6;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // 最后一页，跳转到主页
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFB74D), Color(0xFFFF7043)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 顶部进度条和跳过按钮
              _buildTopBar(),
              
              // 页面内容
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    _buildWelcomePage(),
                    _buildLanguagePage(),
                    _buildFeaturePage1(),
                    _buildFeaturePage2(),
                    _buildPermissionsPage(),
                    _buildCompletePage(),
                  ],
                ),
              ),
              
              // 底部导航按钮
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          // 进度条
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (_currentPage + 1) / _totalPages,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          
          // 跳过按钮
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextButton(
                onPressed: _skipOnboarding,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  '跳过',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 上一步按钮
          _currentPage > 0
              ? ElevatedButton(
                  onPressed: _previousPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFFFB74D),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('上一步', style: TextStyle(fontSize: 16)),
                )
              : const SizedBox(width: 100),
          
          // 下一步按钮
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFFFB74D),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              _currentPage == _totalPages - 1 ? '开始使用' : '下一步',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _totalPages; i++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == _currentPage ? Colors.white : Colors.white.withOpacity(0.3),
          ),
        ),
      );
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: indicators);
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.shield,
              size: 60,
              color: Color(0xFFFFB74D),
            ),
          ),
          const SizedBox(height: 40),
          
          // 标题
          const Text(
            '欢迎使用',
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // 副标题
          const Text(
            'Your Call Your Rule',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24),
          
          // 描述
          Text(
            '您的来电管理专家，为您提供全方位的来电识别与拦截服务',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
          ),
          const SizedBox(height: 40),
          
          // 页面指示器
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildLanguagePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF039BE5),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.language,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          
          // 标题
          const Text(
            '选择您的语言',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          
          // 语言选择器
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: '简体中文',
                icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFFFB74D)),
                items: const [
                  DropdownMenuItem(value: '简体中文', child: Text('简体中文')),
                  DropdownMenuItem(value: 'English', child: Text('English')),
                  DropdownMenuItem(value: '日本語', child: Text('日本語')),
                  DropdownMenuItem(value: '한국어', child: Text('한국어')),
                  DropdownMenuItem(value: 'Français', child: Text('Français')),
                  DropdownMenuItem(value: 'Deutsch', child: Text('Deutsch')),
                  DropdownMenuItem(value: 'Español', child: Text('Español')),
                ],
                onChanged: (value) {
                  // 更改语言
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // 描述
          Text(
            '选择您偏好的语言以获得最佳体验',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
          ),
          const SizedBox(height: 40),
          
          // 页面指示器
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildFeaturePage1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFFF7043),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.contact_phone,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          
          // 标题
          const Text(
            '智能来电识别',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          // 功能图片
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(
                Icons.phone_callback,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // 描述
          Text(
            '自动识别未知来电，标记可疑号码，保护您的通话安全',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
          ),
          const SizedBox(height: 40),
          
          // 页面指示器
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildFeaturePage2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFE53935),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.block,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          
          // 标题
          const Text(
            '强力骚扰拦截',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          // 功能图片
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(
                Icons.phonelink_erase,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // 描述
          Text(
            '一键拦截骚扰电话和短信，自定义拦截规则，还您一个安静的环境',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
          ),
          const SizedBox(height: 40),
          
          // 页面指示器
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildPermissionsPage() {
    final permissionService = Provider.of<PermissionService>(context, listen: false);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF43A047),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.verified_user,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          
          // 标题
          const Text(
            '授予必要权限',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // 描述
          Text(
            '为了提供完整的服务，我们需要以下权限：',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
          ),
          const SizedBox(height: 30),
          
          // 权限列表
          _buildPermissionItem(
            icon: Icons.phone,
            title: '电话权限',
            description: '用于识别和拦截来电',
            color: const Color(0xFFFFB74D),
          ),
          const SizedBox(height: 16),
          
          _buildPermissionItem(
            icon: Icons.sms,
            title: '短信权限',
            description: '用于过滤垃圾短信',
            color: const Color(0xFF039BE5),
          ),
          const SizedBox(height: 16),
          
          _buildPermissionItem(
            icon: Icons.contacts,
            title: '通讯录权限',
            description: '用于识别联系人来电',
            color: const Color(0xFF43A047),
          ),
          const SizedBox(height: 30),
          
          // 授权按钮
          ElevatedButton(
            onPressed: () async {
              // 请求所有必要权限
              final permissions = ['call', 'sms', 'contacts'];
              final results = await permissionService.requestPermissions(permissions);
              
              // 检查权限结果
              final allGranted = results.values.every((granted) => granted);
              if (!allGranted && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('部分权限未授予，可能会影响应用功能'),
                ));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFFFB74D),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('授予权限', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 30),
          
          // 页面指示器
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildPermissionItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFFFB74D),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.rocket_launch,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          
          // 标题
          const Text(
            '准备就绪！',
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          // 成功提示
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF43A047).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: const [
                Icon(
                  Icons.check_circle,
                  color: Color(0xFF43A047),
                  size: 40,
                ),
                SizedBox(height: 8),
                Text(
                  '所有设置已完成',
                  style: TextStyle(color: Color(0xFF43A047), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // 描述
          Text(
            '您的电话安全管家已准备就绪，开始享受安全通话体验吧！',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
          ),
          const SizedBox(height: 40),
          
          // 页面指示器
          _buildPageIndicator(),
        ],
      ),
    );
  }
}