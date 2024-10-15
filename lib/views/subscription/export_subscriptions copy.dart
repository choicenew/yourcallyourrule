import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';

import '../../new_set_icons.dart';
//import '../../services/blacklist_whitelist_service.dart';
import '../../screens/appstate_provider.dart';
import '../../services/snackbar_service.dart';
//import 'dart:io';
import '../../services/subscription_service.dart';
//import '../../services/subscription_service.dart' as su;
import '../../utils/ad_manager.dart';
import '../../utils/create_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/navigation_bar.dart';
//import '../../models/subscription_model.dart';
//import '../../views/first_page_style.dart';
//import '../../views/shield_switch_style.dart';
import '../Custom_3Button_Style.dart';
import '../subpage_style.dart';
import 'add_subscription.dart';
//import '../../views/subscription/subscription_page.dart';
import 'import_subscriptions.dart';
import 'subscription_dialog.dart';
import 'subscription_page.dart';


class ExportSubscriptionsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Export Subscriptions Page"),
      body: Column(
        children: [
          // Top Navigation Bar (placeholder for now)
          const SizedBox(height: 10), // Placeholder for navigation bar height

          // 导航到子目录主page
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubscriptionListView()),
              );
            },
            
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
           
                child: OrientationBuilder( // 添加 OrientationBuilder
                  builder: (context, orientation) {
                    // 计算 maxWidth
                    final mediaQuery = MediaQuery.of(context);
                    final double cardRatio = 3 / 1.8;

                    final cardWidth = mediaQuery.size.width < 600
                        ? mediaQuery.size.width * 0.4
                        : mediaQuery.size.width < 900
                            ? mediaQuery.size.width * 0.2
                            : mediaQuery.size.width * 0.1;
                    final cardHeight = cardWidth / cardRatio;

                    return Container( // 添加 Container 限制
                      constraints: BoxConstraints(
                        maxWidth: cardWidth,
                        maxHeight: cardHeight,
                      ),
                      child: AspectRatio(
                        aspectRatio: 3.1 / 1.3,
                        child: createCard('SubscriptionListView'),
                      ),
                    );
                  },
                ),



              ),
            ),
          ),
const SizedBox(height: 10),
          // Row for export, add, import buttons
          Padding( // 使用 Padding 
  padding: const EdgeInsets.only(top: 16.0,),
  child: SizedBox(  // 将 Container 放在 Padding 外面
    height: 50, // 设置 Container 的高度为 80
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Export button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExportSubscriptionsPageView(),
                        ),
                      );
                    },
                    icon: Icon(NewSet.upload),
                    label: Text('Export'),
                    style:
                        Custom3ButtonStyle.style, // Apply the extracted style
                  ),

                  // Add button (similar structure with optional MaterialStateProperty)
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddSubscriptionPageView(),
                        ),
                      );
                    },
                    icon: Icon(NewSet.add),
                    label: Text('Add'),
                    style:
                        Custom3ButtonStyle.style, // Apply the extracted style
                  ),

                  // Import button (similar structure with optional MaterialStateProperty)
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImportSubscriptionsPageView(),
                        ),
                      );
                    },
                    icon: Icon(NewSet.download),
                    label: Text('Import'),
                    style:
                        Custom3ButtonStyle.style, // Apply the extracted style
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
              // 只有在广告加载成功时才返回广告
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return snapshot.data!;
              } else {
                // 其他情况下不返回任何内容
                return const SizedBox.shrink();
              }
            },
          ),
          // Construct subscription list
          Expanded(
            child: ExportSubscriptionsPage(),
          ),
        ],
      ),
     bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class ExportSubscriptionsPage extends StatefulWidget {
  @override
  _ExportSubscriptionsPageState createState() =>
      _ExportSubscriptionsPageState();
}

class _ExportSubscriptionsPageState extends State<ExportSubscriptionsPage> {
  final _subscriptions = <SubscriptionModel>[];
  late SubscriptionService _subscriptionService;
  List<SubscriptionModel>? _selectedSubscriptions;

  /*
  @override
  void initState() {
    super.initState();
    _initServices();
    _selectedSubscriptions = []; // 初始化为空列表
  }

  Future<void> _initServices() async {
    // 打开 subscription_models.db 数据库
    final subscriptionDatabase = await openDatabase(
      join(await getDatabasesPath(), 'subscription_models.db'),
      onCreate: su.createDatabase,
      version: 1,
    );

    // 实例化服务

    _subscriptionService = SubscriptionService(subscriptionDatabase);
  }
*/



 @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _selectedSubscriptions = []; // 初始化为空列表  
    _subscriptionService = appState.subscriptionService;
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
           return Center(child: CircularProgressIndicator()); // 显示加载界面
        } else {
          return _build(context); // 显示主界面
        }
      },
    );
  }


  // 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    final textFieldHeight = 14.0; // 设置文本字段的高度
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // name subscriptions
          Padding(
      padding: EdgeInsets.only(top: 16.0), // 添加的间距
      
                  child: Container(
                    child: TextField(
                    enabled: false,
                    decoration: inputDecoration.copyWith(
                      labelText: 'Search Name',
                      labelStyle: inputTextStyle,
           ),
        ),
      ),
      ),
              SizedBox(height: 16.0),

              // Select subscriptions button
              GestureDetector(
                child: Container(
             
                  height: textFieldHeight, // 设置为文本字段的高度
                  decoration: inputBoxDecoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                                            Padding(
          padding: EdgeInsets.all(16.0),  // 设置文本的padding值
          child: Text(
                        'Select subscriptions to export',
                    style: inputTextStyle,
          ),
        ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(NewSet.folder_pen, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                // 设置点击区域为整个容器区域
                onTap: () async {
                  // Show select subscriptions popup
                  final subscriptions =
                      await _subscriptionService.getAllSubscriptions();
                  _selectedSubscriptions =
                      await showDialog<List<SubscriptionModel>>(
                    context: context,
                    builder: (BuildContext context) {
                      return SelectSubscriptionsDialog(
                        subscriptions: subscriptions,
                      );
                    },
                  );
                  setState(() {});
                },
              ),

              SizedBox(height: 16.0),

              // Export file path
              GestureDetector(
                child: Container(
               
                  height: textFieldHeight, // 设置为文本字段的高度
                  decoration: inputBoxDecoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                                      Padding(
          padding: EdgeInsets.all(16.0),  // 设置文本的padding值
          child: Text(
                        _filePath ?? 'selecting export folder',
                             style: inputTextStyle,
          ),
        ),
                      Padding(
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

              SizedBox(height: 16.0),
              // Select export format (optional)
              GestureDetector(
                child: Container(
                        height: textFieldHeight, // 设置为文本字段的高度
                  decoration: inputBoxDecoration,
                  child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
          padding: EdgeInsets.all(16.0),  // 设置文本的padding值
          child: Text(
            'export format:',
            style: inputTextStyle,
          ),
        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(NewSet.folder_pen, color: Colors.blue),
                        ),

                      DropdownButton<String>(
                        value: _selectedType,
                        items: [
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
          GoogleAdWidget(adInfo: AdManager.bannerAd), 
             

              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),

              // 导出按钮
              //居于屏幕右下角
                floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 5.0, right: 16.0),
        child: Align(
                alignment: Alignment.bottomRight,
          
                  child: ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Use minimum size
                      children: [
                        Icon(NewSet.check),
                        SizedBox(width: 8.0),
                        Text(
                          'Export',
                        ),
                      ],
                    ),
                    onPressed: () async {
                      if (_filePath == null || _filePath!.isEmpty) {
                        showErrorSnackBar(context, '请选择导出文件夹');
                        return;
                      }

                      if (_selectedSubscriptions == null ||
                          _selectedSubscriptions!.isEmpty) {
                        showErrorSnackBar(context, '请选择要导出的订阅');
                        return;
                      }

                      // Export subscriptions based on selected format
                      try {
                        switch (_selectedType) {
                          case 'csv':
                            await _subscriptionService.exportSubscriptionsToCsv(
                                _subscriptions, _filePath!);
                            showSuccessSnackBar(context, '导出成功');
                            break;
                          case 'json':
                            await _subscriptionService
                                .exportSubscriptionsToJson(
                                    _subscriptions, _filePath!);
                            showSuccessSnackBar(context, '导出成功');
                            break;
                          // Add additional cases for other formats
                        }
                      } catch (e) {
                        print('Error exporting: $e');
                        showErrorSnackBar(context, '导出失败');
                      }
                    },
                    style: addButtonStyle,
                  ),
        ),
      ),
      
      
    );
  }
}

/*
class SelectSubscriptionsDialog extends StatefulWidget {
  final List<SubscriptionModel> subscriptions;

  SelectSubscriptionsDialog({required this.subscriptions});

  @override
  _SelectSubscriptionsDialogState createState() =>
      _SelectSubscriptionsDialogState();
}


class _SelectSubscriptionsDialogState extends State<SelectSubscriptionsDialog> {
  final Set<SubscriptionModel> _selectedSubscriptions =
      Set<SubscriptionModel>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Subscriptions'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.subscriptions
              .map(
                (subscription) => CheckboxListTile(
                  title: Text(subscription.name),
                  value: _selectedSubscriptions.contains(subscription),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value) {
                        _selectedSubscriptions.add(subscription);
                      } else {
                        _selectedSubscriptions.remove(subscription);
                      }
                    });
                  },
                ),
              )
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedSubscriptions.toList());
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
*/
