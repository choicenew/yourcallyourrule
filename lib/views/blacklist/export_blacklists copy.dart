//import 'dart:io';
import 'dart:core';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//import 'dart:convert';
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';

import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/blacklist_whitelist_service.dart';
import '../../services/snackbar_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/create_card.dart';
//import '../../views/blacklist/blacklist_page.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/navigation_bar.dart';
//import '../../models/subscription_model.dart';
//import '../../views/first_page_style.dart';
//import '../../views/shield_switch_style.dart';
//import '../switch_style.dart';

//import '../../services/allowed_blocked_service.dart';
import '../public/build_page_switch.dart';
import '../subpage_style.dart';
//import 'package:csv/csv.dart';
//import 'package:http/http.dart' as http;
//import 'package:file_picker/file_picker.dart';
//import 'package:dlibphonenumber/dlibphonenumber.dart'; // 用于解析电话号码

import 'add_blacklist.dart';
import 'blacklist_dialog.dart';
import 'blacklist_page.dart';
//import '../../views/blacklist/export_blacklists.dart';
import 'import_blacklists.dart';

/*

class ExportBlacklistsPageView extends StatefulWidget {
  const ExportBlacklistsPageView({super.key});

  @override
  _ExportBlacklistsPageViewState createState() => _ExportBlacklistsPageViewState();
}

class _ExportBlacklistsPageViewState extends State<ExportBlacklistsPageView> {
  bool _isCollapsed = true; // 初始为折叠状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Export Blacklists Page"),
      body: Column(
        children: [
          // Toggle button for collapsing/expanding content
          IconButton(
            icon: Icon(_isCollapsed ? Icons.expand_more : Icons.expand_less),
            onPressed: () {
              setState(() {
                _isCollapsed = !_isCollapsed;
              });
            },
          ),

          // Collapsible content
          Visibility(
            visible: !_isCollapsed,
            child: Column(
              children: [
                // 导航到 SubscriptionListView 的 GestureDetector
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BlacklistPageView()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: OrientationBuilder(
                        builder: (context, orientation) {
                          final mediaQuery = MediaQuery.of(context);
                          const double cardRatio = 3 / 1.8;

                          final cardWidth = mediaQuery.size.width < 600
                              ? mediaQuery.size.width * 0.4
                              : mediaQuery.size.width < 900
                                  ? mediaQuery.size.width * 0.2
                                  : mediaQuery.size.width * 0.1;
                          final cardHeight = cardWidth / cardRatio;

                          return Container(
                            constraints: BoxConstraints(
                              maxWidth: cardWidth,
                              maxHeight: cardHeight,
                            ),
                            child: AspectRatio(
                              aspectRatio: 3.1 / 1.3,
                              child: createCard('BlacklistPageView'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ExportBlacklistsPageView(),
                                ),
                              );
                            },
                            icon: const Icon(NewSet.upload),
                            label: const Text('Export'),
                            style: Custom3ButtonStyle.style,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddBlacklistPageView(),
                                ),
                              );
                            },
                            icon: Icon(NewSet.add),
                            label: Text('Add'),
                            style: Custom3ButtonStyle.style,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImportBlacklistsPageView(),
                                ),
                              );
                            },
                            icon: Icon(NewSet.download),
                            label: Text('Import'),
                            style: Custom3ButtonStyle.style,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder<Widget>(
                  future: Future.value(GoogleAdWidget(adInfo: AdManager.bannerAd)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ExportBlacklistsPage(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
*/

class ExportBlacklistsPageView extends StatelessWidget {
  const ExportBlacklistsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      Intl.message("Export Blacklist Page"), // 当前页面标题
      Intl.message("BlacklistPageView"), // 这个不要修改-卡片标题=点击卡片导航到的页面
      const BlacklistPageView(), // create card卡片导航到的页面
      const ExportBlacklistsPage(), // 当前页面主要内容
      exportPage: const ExportBlacklistsPageView(), // 导出页面
      exportLabel: Intl.message("Export"), // 自定义导出按钮文字//不要动
      addPage: const AddBlacklistPageView(), // 添加页面
      addLabel: Intl.message("Add"), // 自定义 add 按钮文字 //不要动
      importPage: const ImportBlacklistsPageView(), // 导入页面
      importLabel: Intl.message("Import"), // 自定义导入按钮文字 //不要动
    );
  }
}


class ExportBlacklistsPage extends StatefulWidget {
  const ExportBlacklistsPage({super.key});

  @override
  ExportBlacklistsPageState createState() => ExportBlacklistsPageState();
}

class ExportBlacklistsPageState extends State<ExportBlacklistsPage> {
  final _entries = <BlacklistEntry>[];
  late BlacklistService _blacklistService;
  List<BlacklistEntry>? _selectedEntries;

  /*
  @override
  void initState() {
    super.initState();
    _initServices();
    _selectedEntries = []; // 初始化为空列表
  }

  Future<void> _initServices() async {
    // 打开 subscription_models.db 数据库
    final entryDatabase = await openDatabase(
      join(await getDatabasesPath(), 'number_control_list.db'),
      onCreate: createDatabase,
      version: 1,
    );

    // 实例化服务

    _blacklistService = BlacklistService(entryDatabase);
  }
*/


 @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _selectedEntries = []; // 初始化为空列表
     _blacklistService = appState.blacklistService; 
  }

  String? _filePath;
  String _selectedType = 'csv'; // Default export format (CSV)
  
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return FutureBuilder(
      future: appState.ensureServicesInitialized(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
           return const Center(child: CircularProgressIndicator()); // 显示加载界面
        } else {
          return _build(context); // 显示主界面
        }
      },
    );
  }


  // 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    final textFieldHeight = 68.0; // 设置文本字段的高度

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),


                child: Column(
                  children: <Widget>[





              // Select entries button
              GestureDetector(
                  child: Container(
                   
                       
                    height: textFieldHeight, // 设置为文本字段的高度
   decoration: inputBoxDecoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
          padding: const EdgeInsets.all(16.0),  // 设置文本的padding值
          child: Text(
                        Intl.message('Select entries to export'),
                        style: inputTextStyle,
          ),
        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(NewSet.folder_pen, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                // 设置点击区域为整个容器区域
                onTap: () async {
                  // Show select entries popup
                  final entries = await _blacklistService.getEntries();
                  _selectedEntries = await showDialog<List<BlacklistEntry>>(
                    context: context,
                    builder: (BuildContext context) {
                      return SelectBlacklistEntriesDialog(
                        entries: entries,
                      );
                    },
                  );
                  setState(() {});
                },
              ),

              const SizedBox(height: 16.0),

              // Export file path
              GestureDetector(
                  child: Container(
                   
                       
                    height: textFieldHeight, // 设置为文本字段的高度
   decoration: inputBoxDecoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
          padding: const EdgeInsets.all(16.0),  // 设置文本的padding值
          child: Text(
                        //_filePath ?? 
                        Intl.message('selecting export folder'),
                        style: inputTextStyle,
          ),
        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(NewSet.folder_pen, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                // 设置点击区域为整个容器区域
                onTap: () async {
                  // Open file  export directory
                  String? selectedDirectory =
                      await FilePicker.platform.getDirectoryPath();
                  if (selectedDirectory != null) {
                    setState(() {
                      _filePath = selectedDirectory;
                    });
                  }
                },
              ),
                  const SizedBox(height: 16.0),
                  // 添加显示文件路径的 Text 组件

            
if (_filePath != null)
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal, // 设置水平滚动
      child: Expanded(
        child: Text(
          _filePath!, // 使用感叹号(!)断言 filePath 不为 null
          //overflow: TextOverflow.ellipsis, // 设置文本溢出时使用省略号
          //maxLines: 1, // 设置最大行数为 1
        ),
      ),
    ),
  ),
              const SizedBox(height: 16.0),
              // Select export format (optional)
              GestureDetector(
                          child: Container(
                   
                       
                    height: textFieldHeight, // 设置为文本字段的高度
   decoration: inputBoxDecoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
          padding: const EdgeInsets.all(16.0),  // 设置文本的padding值
          child: Text(
                        Intl.message('export format:'), 
                                        style: inputTextStyle          
                        ),
        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(NewSet.folder_pen, color: Colors.blue),
                        ),
  
                      DropdownButton<String>(
                        value: _selectedType,
                        items: const [
                          DropdownMenuItem(
                            value: 'csv',
                            child: Text('CSV'),
                          ),
                          DropdownMenuItem(
                            value: 'json',
                            child: Text('JSON'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value!;
                          });
                        },
                      ),
                   
                                     ],
                    ),
                  ),
               
              ),
         // 广告            
          const GoogleAdWidget(adInfo: AdManager.bannerAd), 
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
              // 导出按钮
              //居于屏幕右下角
               floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 16.0),
        child: Align(
                alignment: Alignment.bottomRight,
          
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_filePath == null || _filePath!.isEmpty) {
                        showErrorSnackBar(context, Intl.message('Please select an export folder'));
                        return;
                      }

                      if (_selectedEntries == null ||
                          _selectedEntries!.isEmpty) {
                        showErrorSnackBar(context, Intl.message('Please select entries to export'));
                        return;
                      }

                      // Export entries based on selected format
                      try {
                        switch (_selectedType) {
                          case 'csv':
                            await _blacklistService.exportToCsv(_selectedEntries!, _filePath!);
                            print('Selected entries: $_selectedEntries');
                            print('File path: $_filePath');
                            print('数据写入成功！');
                            showSuccessSnackBar(context, Intl.message('Export successful'));
                            break;
                          case 'json':
                            await _blacklistService.exportToJson(_selectedEntries!, _filePath!);
                            showSuccessSnackBar(context, Intl.message('Export successful'));
                            break;
                          // Add additional cases for other formats
                        }
                      } catch (e) {
                        print('Error exporting: $e');
                        showErrorSnackBar(context, '导出失败');
                      }
                    },
                    style: addButtonStyle,
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Use minimum size
                      children: [
                        const Icon(NewSet.check),
                        const SizedBox(width: 8.0),
                        Text(
                          Intl.message('Export'),
                        ),
                      ],
                    ),
                  ),
        ),
      ),
      
      
    );
  }
}
