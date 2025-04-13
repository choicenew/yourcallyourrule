import 'package:flutter/material.dart';

/// 页面基类
/// 所有页面都应该继承自这个基类
abstract class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);
  
  /// 页面标题
  String get title;
  
  /// 构建页面内容
  Widget buildContent(BuildContext context);
  
  /// 构建AppBar
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }
  
  /// 构建底部导航栏
  Widget? buildBottomNavigationBar(BuildContext context) {
    return null;
  }
  
  /// 构建浮动按钮
  Widget? buildFloatingActionButton(BuildContext context) {
    return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildContent(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }
}

/// 有状态页面基类
/// 所有有状态页面都应该继承自这个基类
abstract class BaseStatefulPage extends StatefulWidget {
  const BaseStatefulPage({Key? key}) : super(key: key);
}

/// 有状态页面状态基类
abstract class BaseStatefulPageState<T extends BaseStatefulPage> extends State<T> {
  /// 页面标题
  String get title;
  
  /// 构建页面内容
  Widget buildContent(BuildContext context);
  
  /// 构建AppBar
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }
  
  /// 构建底部导航栏
  Widget? buildBottomNavigationBar(BuildContext context) {
    return null;
  }
  
  /// 构建浮动按钮
  Widget? buildFloatingActionButton(BuildContext context) {
    return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildContent(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }
}