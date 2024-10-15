import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
//import '../../models/subscription_model.dart';

import '../../services/sms_blacklist_whitelist_service.dart';
import '../../services/snackbar_service.dart';
import '../../utils/ad_manager.dart';
import '../../widgets/google_ad.dart';
import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../public/public_select_label.dart';
import '../subpage_style.dart';
import 'export_whitelists.dart';
import 'import_whitelists.dart';
import 'whitelist_page.dart';

/*
class AddSmsWhitelistPageView extends StatefulWidget {
  @override
  _AddSmsWhitelistPageViewState createState() => _AddSmsWhitelistPageViewState();
}

class _AddSmsWhitelistPageViewState extends State<AddSmsWhitelistPageView> {
  bool _isCollapsed = true; // 初始为折叠状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add SMS Whitelist Page"),
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
                      MaterialPageRoute(builder: (context) => SmsWhitelistPageView()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: OrientationBuilder(
                        builder: (context, orientation) {
                          final mediaQuery = MediaQuery.of(context);
                          final double cardRatio = 3 / 1.8;

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
                              child: createCard('SmsWhitelistPageView'),
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
                      padding: EdgeInsets.symmetric(vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExportSmsWhitelistsPageView(),
                                ),
                              );
                            },
                            icon: Icon(NewSet.upload),
                            label: Text('Export'),
                            style: Custom3ButtonStyle.style,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddSmsWhitelistPageView(),
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
                                  builder: (context) => ImportSmsWhitelistsPageView(),
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
            child: AddSmsWhitelistPage(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class AddSmsWhitelistPage extends StatefulWidget {
  @override
  _AddSmsWhitelistPageState createState() => _AddSmsWhitelistPageState();
}

class _AddSmsWhitelistPageState extends State<AddSmsWhitelistPage> {
  // 订阅名称控制器
  TextEditingController _whitelistNameController = TextEditingController();

  // 订阅链接控制器
  TextEditingController _phoneNumberController = TextEditingController();
  //bool _isBlocked = false;
  //bool _isAllowed = false;
  late SmsWhitelistService _smsWhitelistService;
  late String _selectedLabel;
  late SmsWhitelistEntry _entry;

  /*
  @override
  void initState() {
    super.initState();
    _entry = SmsWhitelistEntry(name: '', phoneNumber: '', label: '');
    _initServices();
  }

  Future<void> _initServices() async {
    // 打开 number_control_list.db 数据库
    final smsNumberControlDatabase = await openDatabase(
      path_helper.join(await getDatabasesPath(), 'sms_number_list.db'),
      onCreate: sbw.createDatabase,
      version: 1,
    );

    // 实例化服务
    _smsWhitelistService = SmsWhitelistService(smsNumberControlDatabase);
  }
*/


 @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _entry = SmsWhitelistEntry(name: '', phoneNumber: '', label: '');
    _smsWhitelistService = appState.smsWhitelistService;
  }


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

    final textFieldHeight = 48.0; // 设置文本字段的高度

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),


                child: Column(
                  children: <Widget>[


          Padding(
      padding: EdgeInsets.only(top: 16.0), // 添加的间距

                  child: Container(
                    child: TextField(
                        controller: _whitelistNameController,
                        decoration: inputDecoration.copyWith(
                          labelText: 'Name',
                          labelStyle: inputTextStyle,
                        ),
                      ),
                    ),
                  ),
        Padding(
      padding: EdgeInsets.only(top: 16.0), // 添加的间距
      child: Container(
        child: TextField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: inputDecoration.copyWith(
                          labelText: 'PhoneNumber',
                          labelStyle: inputTextStyle,
          ),
        ),
      ),
      ),

              SizedBox(height: 16.0),

              // 标签选择
              // Stateful widget to manage Entry name and label
              WhitelistLabels(entry: _entry),
              Divider(height: 1),
              const Spacer(),
                   // 广告
          GoogleAdWidget(adInfo: AdManager.bannerAd),


              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
/*
 Column(
  children: [
    SizedBox(height: 20), // Adjust height as needed
    Text(
      '如非必要请不要使用allowed 和blocked switch，保持默认关闭状态',
      style: TextStyle(color: Colors.grey, fontSize: 16), // Customize text style
    ),
    SizedBox(height: 20), // Adjust height as needed
    // Your existing SizedBox widgets here
  ],
),
              SizedBox(height: 16.0),
              // 允许和阻止名单
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: screenWidth * 0.83, // width set to 83% of screen width
                          height: textFieldHeight, // 设置为文本字段的高度
                          decoration: whiteBoxDecoration,
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Allowed名单',
                                style: whiteTextStyle,
                              ),
                              SizedBox(width: 8.0),
                             Theme(
                                data: shieldSwitchThemeData,
                                child: SwitchListTile(
                                  value: _isWhitelist,
                                  onChanged: (value) {
                                    setState(() {
                                      _isWhitelist = value;
                                      _isBlacklist = !value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: screenWidth * 0.83, // width set to 83% of screen width
                          height: textFieldHeight, // 设置为文本字段的高度
                          decoration: whiteBoxDecoration,
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Blocked名单',
                                style: whiteTextStyle,
                              ),
                              SizedBox(width: 8.0),
                              Theme(
                                data: shieldSwitchThemeData,
                                child: SwitchListTile(
                                  value: _isBlacklist,
                                  onChanged: (value) {
                                    setState(() {
                                      _isBlacklist = value;
                                      _isWhitelist = !value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
             */

              //居于屏幕右下角
               floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 5.0, right: 16.0),
        child: Align(
                alignment: Alignment.bottomRight,

                  child: ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Use minimum size
                      children: [
                        Icon(NewSet.add),
                        SizedBox(width: 8.0),
                        Text(
                              'Save',
                            ),
                          ],
                        ),
                        onPressed: () async {
                          // 检查订阅名称是否为空
                          if (_whitelistNameController.text.isEmpty) {
                            showErrorSnackBar(context, "名称不能为空");
                            return;
                          }

                          // 检查电话号码格式
                          if (_phoneNumberController.text.isEmpty) {
                            // 如果号码为空，显示错误消息
                            showErrorSnackBar(context, "请输入电话号码");
                            return;
                          }
                          final entry = SmsWhitelistEntry(
                            name: _whitelistNameController.text,
                            phoneNumber: _phoneNumberController.text,
                            label: _selectedLabel,
                          );

                          await _smsWhitelistService.editEntry(
                              entry); // Update database with updated entry
                          //  if (_isAllowed) {
                          //    await _allowedService.add(entry as AllowedEntry);
                          //  } else if (_isBlocked) {
                          //    await _blockedService.add(entry as BlockedEntry);
                          //   }
                        },
                        style: showmoreButtonStyle,
                  ),
        ),
      ),


    );
  }
}

class WhitelistLabels extends StatefulWidget {
  final SmsWhitelistEntry entry;

  const WhitelistLabels({Key? key, required this.entry}) : super(key: key);

  @override
  State<WhitelistLabels> createState() => _WhitelistLabelsState();
}

class _WhitelistLabelsState extends State<WhitelistLabels> {
  late SmsWhitelistService _smsWhitelistService;
  String? _selectedLabel;
  List<String> _labels = [];
/*
  @override
  void initState() {
    super.initState();
    _initServices();
  }

  Future<void> _initServices() async {
    // 打开 number_control_list.db 数据库
    final smsNumberControlDatabase = await openDatabase(
      path_helper.join(await getDatabasesPath(), 'sms_number_list.db'),
      onCreate: sbw.createDatabase,
      version: 1,
    );

    // 实例化服务
    _smsWhitelistService = SmsWhitelistService(smsNumberControlDatabase);

    // 获取所有标签
    final labels = await _smsWhitelistService.getAllLabels();
    if (labels.isEmpty) {
      await _smsWhitelistService.insertPredefinedLabelsIfNotExists();
    }

    // 获取当前号码的标签
    final currentLabel =
        await _smsWhitelistService.getLabelByPhoneNumber(widget.entry);

    setState(() {
      _labels = labels;
      _selectedLabel = currentLabel;
    });
  }
*/
  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
       _smsWhitelistService = appState.smsWhitelistService;
    _initLabels();
  }

  Future<void> _initLabels() async {


    // 获取所有标签
    final labels = await _smsWhitelistService.getAllLabels();
    if (labels.isEmpty) {
      await _smsWhitelistService
          .insertPredefinedLabelsIfNotExists(_smsWhitelistService.database);
    }

    // 获取当前号码的标签
    final currentLabel =
        await _smsWhitelistService.getLabelByPhoneNumber(widget.entry.phoneNumber);

    setState(() {
      _labels = labels;
      _selectedLabel = currentLabel;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a label:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: _labels.map((label) {
            // 判断当前标签是否为选中状态
            final translatedLabel = Intl.message(label); // 翻译标签
            final isSelected = label == _selectedLabel; // 判断是否选中
            // final isSelected = label == _selectedLabel;
            return ChoiceChip(
              label: Text(translatedLabel),
              // 根据是否选中设置不同的样式
              selected: isSelected,
              // 点击标签时触发的回调函数
              onSelected: (_) async {
                setState(() {
                  // 更新选中的标签
                  _selectedLabel = label;
                });
                // 更新黑名单条目的标签
                widget.entry.label = label;
                try {
                  // 将更改保存到数据库
                  await _smsWhitelistService.editEntry(widget.entry);
                } catch (e) {
                  // 保存失败时,恢复之前的选中状态
                  setState(() {
                    _selectedLabel = widget.entry.label;
                    widget.entry.label = _selectedLabel!;
                  });
                  // 显示错误消息
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update label: $e')),
                  );
                }
              },
              // 选中的标签显示蓝色
              selectedColor: Colors.blue,
              // 未选中的标签显示灰色
              backgroundColor: Colors.grey[300],
            );
          }).toList(),
        ),
        // 如果有选中的标签,显示选中的标签
        if (_selectedLabel != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selected Label: $_selectedLabel',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
      ],
    );
  }
}
*/

//

class AddSmsWhitelistPageView extends StatelessWidget {
  const AddSmsWhitelistPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).addSmsWhitelistPage, // 页面标题
      'SmsWhitelistPageView', // 卡片标题=点击卡片导航到的页面
      const SmsWhitelistPageView(), // 点击卡片导航到的页面
      const AddSmsWhitelistPage(), // 当前页面主要内容
      exportPage: const ExportSmsWhitelistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsWhitelistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsWhitelistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class AddSmsWhitelistPage extends StatefulWidget {
  const AddSmsWhitelistPage({super.key});

  @override
  AddSmsWhitelistPageState createState() => AddSmsWhitelistPageState();
}

class AddSmsWhitelistPageState extends State<AddSmsWhitelistPage> {
  // 订阅名称控制器

  TextEditingController _nameController = TextEditingController();

  // 订阅链接控制器
  TextEditingController _phoneNumberController = TextEditingController();
  //bool _isBlocked = false;
  //bool _isAllowed = false;
  late SmsWhitelistService _smsWhitelistService;
  //late String _selectedLabel;
  late SmsWhitelistEntry _entry;
  bool _isSubscribed = false;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _entry = SmsWhitelistEntry(name: '', phoneNumber: '', label: '');
    _smsWhitelistService = appState.smsWhitelistService;
  }

  @override
  Widget build(BuildContext context) {
    return _build(context); // 直接调用 _build(context)
  }

  // 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              /*
              Padding(
                padding: const EdgeInsets.only(top: 16.0), // 添加的间距

                child: TextField(
                  controller: _nameController,
                  decoration: inputDecoration.copyWith(
                    labelText: Intl.message('Name'),
                    labelStyle: inputTextStyle,
                  ),
                ),
              ),

              const SizedBox(width: 16.0),
              Padding(
                padding: const EdgeInsets.only(top: 16.0), // 添加的间距
                child: TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: inputDecoration.copyWith(
                    labelText: Intl.message('PhoneNumber'),
                    labelStyle: inputTextStyle,
                  ),
                ),
              ),



              const SizedBox(height: 16.0),




         Theme(
                  data: shieldSwitchThemeData,
                  child: SwitchListTile(
                    title: Text(
                        _isSubscribed
                            ? Intl.message('is Subscribed')
                            : Intl.message('is not Subscribed'),
                        style: whiteTextStyle),
                    value: _isSubscribed,
                    onChanged: (value) {
                      setState(() {
                        _isSubscribed = value;
                      });
                    },
                  ),
                ),
   */

              // 使用 NameInputWidget
              NameInputWidget(nameController: _nameController),

              const SizedBox(height: 16.0),
              // 使用 UrlInputWidget
              PhoneNumberInputWidget(
                  phoneNumberController: _phoneNumberController),

              const SizedBox(height: 16.0),
              // 使用 SubscribedSwitchWidget
              SubscribedSwitchWidget(
                isSubscribed: _isSubscribed,
                onChanged: (value) {
                  setState(() {
                    _isSubscribed = value;
                  });
                },
              ),

              Labels(
                onLabelChanged: (label) {
                  _entry.label = label;
                },
                selectLabelService: ListServiceAdapter(
                    Provider.of<AppState>(context, listen: false)
                        .smsWhitelistService),
              ),

              const SizedBox(height: 16.0),

              const Divider(height: 1),
              const SizedBox(height: 16.0),
              // 广告
              const GoogleAdWidget(adInfo: AdManager.bannerAd),

              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),

      //居于屏幕右下角
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 16.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () async {
              // 检查订阅名称是否为空
              if (_nameController.text.isEmpty) {
                showErrorSnackBar(context, S.of(context).nameCannotBeEmpty);
                return;
              }
              // 检查电话号码是否为空
              if (_phoneNumberController.text.isEmpty) {
                showErrorSnackBar(
                    context, S.of(context).pleaseEnterAPhoneNumber);
                return;
              }
              if (_entry.label.isEmpty) {
                showErrorSnackBar(context, S.of(context).pleaseSelectALabel);
                return;
              }

              final entry = SmsWhitelistEntry(
                phoneNumber: _phoneNumberController.text,
                label: _entry.label,
                name: _nameController.text,
                isSubscribed: _isSubscribed,
              );

              try {
                await _smsWhitelistService.addOrUpdate(entry);

                var result = await _smsWhitelistService
                    .getEntryByPhoneNumber(_phoneNumberController.text);

                _nameController.clear();
                _phoneNumberController.clear();
                setState(() {
                  _entry =
                      SmsWhitelistEntry(name: '', phoneNumber: '', label: '');
                });
                if (mounted) {
                  showSuccessSnackBar(context, S.of(context).addedSuccessfully);
                }
              } catch (e) {
                if (mounted) {
                  showErrorSnackBar(context, '${S.of(context).failedToAdd} $e');
                }
              }
              // Update database with updated entry
              //  if (_isAllowed) {
              //    await _allowedService.add(entry as AllowedEntry);
              //  } else if (_isBlocked) {
              //    await _blockedService.add(entry as BlockedEntry);
              //   }
            },
            style: floatingButtonStyle,
            child: Row(
              mainAxisSize: MainAxisSize.min, // Use minimum size
              children: [
                const Icon(NewSet.add),
                const SizedBox(width: 8.0),
                Text(
                  S.of(context).save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
