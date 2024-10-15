import 'package:flutter/material.dart';
import '../../screens/homePage.dart';
import '../new_set_icons.dart';
import '../screens/callerID/callerid_customization_page.dart';
import '../screens/settings.dart';
import '../views/call_history/call_history.dart';
import '../views/contact/contact_main_page.dart';

// 定义 NavigationItem 类
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

// 定义 NavigationItem 列表 (全局)
final List<NavigationItem> navigationItems = [
  NavigationItem(icon: NewSet.home, label: 'Home', page: const MyHomePage()),
  NavigationItem(
      icon: NewSet.chat_history,
      label: 'History',
      page: const CallHistoryPage()),
  NavigationItem(
      icon: NewSet.contact, label: 'Contacts', page: const ContactsPage()),
  NavigationItem(
      icon: NewSet.apps,
      label: 'Service',
      page: const CallerIdCustomizationPage()),
  NavigationItem(
      icon: NewSet.settings, label: 'Settings', page: const SettingsPage()),
];

// 二次封装的底部导航栏组件
class CustomBottomNavigationBar extends StatefulWidget {
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double height;

  const CustomBottomNavigationBar({
    Key? key,
    this.backgroundColor = Colors.black,
    this.selectedItemColor = Colors.white,
    this.unselectedItemColor = Colors.grey,
    this.height = 60.0,
  }) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 使用 Offstage 管理页面
        for (var i = 0; i < navigationItems.length; i++)
          Offstage(
            offstage: i != _selectedPageIndex,
            child: navigationItems[i].page,
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: OldBottomNavigationBar(
            backgroundColor: widget.backgroundColor,
            selectedItemColor: widget.selectedItemColor,
            unselectedItemColor: widget.unselectedItemColor,
            height: widget.height,
            selectedPageIndex: _selectedPageIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedPageIndex = index;
              });
            },
      
          ),
        ),
      ],
    );
  }
}

// 原始的底部导航栏组件
class OldBottomNavigationBar extends StatelessWidget {
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double height;
  final Function(int) onItemSelected; // 添加回调函数
  final int selectedPageIndex;

  const OldBottomNavigationBar({
    super.key,
    this.backgroundColor = Colors.black,
    this.selectedItemColor = Colors.white,
    this.unselectedItemColor = Colors.grey,
    this.height = 60.0,
    required this.onItemSelected, // 必须传入回调函数
    required this.selectedPageIndex,
  });


@override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: navigationItems.map((item) {
          int index = navigationItems.indexOf(item);
          final itemWidth = MediaQuery.of(context).size.width / navigationItems.length; // 直接计算 itemWidth
          return InkWell(
            onTap: () {
              onItemSelected(index);
            },
            child: Container( // 使用 Container 替换 AnimatedContainer
              width: selectedPageIndex == index
                  ? itemWidth * 1.2
                  : itemWidth * 0.9,
              height: 40,
              decoration: BoxDecoration(
                color: selectedPageIndex == index
                    ? selectedItemColor
                    : const Color.fromARGB(0, 86, 85, 85),
                borderRadius: BorderRadius.circular(10),
              ),
              child: selectedPageIndex == index
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          color: Colors.black,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.label,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  : Icon(
                      item.icon,
                      color:unselectedItemColor,
                      size: 20,
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }
}




// 定义各个页面 (HomePage, SearchPage, OffersPage, etc.)...
// ... (各个页面的代码保持不变)