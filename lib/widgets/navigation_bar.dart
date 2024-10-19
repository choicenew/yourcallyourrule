import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../generated/l10n.dart';
import '../new_set_icons.dart';
import '../screens/callerID/callerid_customization_page.dart';
import '../screens/settings.dart';
import '../views/call_history/call_history.dart';
import '../views/contact/contact_main_page.dart';

// 定义全局变量，并初始化为 0
int selectedPageIndex = 0;

// 自定义底部导航栏组件
class CustomBottomNavigationBar extends StatefulWidget {
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double height;

  const CustomBottomNavigationBar({
    super.key,
    this.backgroundColor = Colors.black,
    this.selectedItemColor = Colors.black,
    this.unselectedItemColor = Colors.grey,
    this.height = 60.0,
  });

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  // 定义底部导航栏项目和对应的页面
  final List<NavigationItem> _navigationItems = [
    NavigationItem(
        icon: NewSet.home,
        label: S.current.home,
        page: const MyHomePage()),
    NavigationItem(
        icon: NewSet.chat_history,
        label: S.current.history,
        page: const CallHistoryPage()),
    NavigationItem(
        icon: NewSet.contact,
        label: S.current.contacts,
        page: const ContactsPage()),
    NavigationItem(
        icon: NewSet.apps,
        label: S.current.service,
        page: const CallerIdCustomizationPage()),
    NavigationItem(
        icon: NewSet.settings,
        label: S.current.settings,
        page: const SettingsPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double itemWidth =
              constraints.maxWidth / _navigationItems.length;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _navigationItems.map((item) {
              int index = _navigationItems.indexOf(item);
              return InkWell(
                onTap: () {
                  // 更新全局变量 selectedPageIndex
                  setState(() {
                    selectedPageIndex = index;
                  });
                  // 使用 Navigator.push 跳转到新页面
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          item.page,
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: selectedPageIndex == index
                      ? itemWidth * 1.2
                      : itemWidth * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    color: selectedPageIndex == index
                        ? widget.selectedItemColor
                        : const Color.fromARGB(0, 86, 85, 85),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: selectedPageIndex == index
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item.icon,
                              color: const Color.fromARGB(255, 201, 201, 201),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.label,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 201, 201, 201),
                              ),
                            ),
                          ],
                        )
                      : Icon(
                          item.icon,
                          color: widget.unselectedItemColor,
                          size: 20,
                        ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

// 定义页面信息和对应页面的类
class NavigationItem {
  final IconData icon;
  final String label;
  final Widget page;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.page,
  });
}

// 定义各个页面 (HomePage, SearchPage, OffersPage, etc.)...
// ... (各个页面的代码保持不变)