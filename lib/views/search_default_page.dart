import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import '../generated/l10n.dart';
import '../new_set_icons.dart';
import '../screens/appstate_provider.dart';
import '../services/allowed_blocked_service.dart';
import '../services/blacklist_whitelist_service.dart';
import '../services/caller_id_service.dart';
import '../services/label_service.dart';
import '../services/sms_blacklist_whitelist_service.dart';
import '../services/sms_text_service.dart';
import '../utils/ad_manager.dart';

import '../utils/language_provider.dart';
import '../utils/parse_phonenumber.dart';
import '../widgets/adwidgets/native_ads.dart';
import '../widgets/google_ad.dart';
import '../widgets/search_bar.dart';

import 'label/add_label.dart';

import 'public/isolated_widgets.dart';
import 'public/public_select_label.dart';

import 'subpage_style.dart';
import 'dart:core';

class Entry {
  String? phoneNumber;
  String? label;
  String? name;
  String? avatar;
  String? keyword;
  bool? isSubscribed; // 可选属性，根据需要添加
  int? count; // 可选属性，根据需要添加
  String? url; // 可选属性，根据需要添加

  Entry({
    this.phoneNumber,
    this.label,
    this.name,
    this.avatar,
    this.keyword,
    this.isSubscribed,
    this.count,
    this.url,
  });
}

class GeneralPage extends StatefulWidget {
  final SearchResult searchResult;

  const GeneralPage({super.key, required this.searchResult});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> with WidgetsBindingObserver {
  late BlacklistService _blacklistService;
  late WhitelistService _whitelistService;
  late AllowedService _allowedService;
  late BlockedService _blockedService;
  late LabelService _labelService;
  late SmsBlacklistService _smsBlacklistService;
  late SmsWhitelistService _smsWhitelistService;
  late SmsTextBlacklistService _smsTextBlacklistService;
  late SmsTextWhitelistService _smsTextWhitelistService;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeServices();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _initializeServices() {
    final appState = Provider.of<AppState>(context, listen: false);
    _allowedService = appState.allowedService;
    _blockedService = appState.blockedService;
    _blacklistService = appState.blacklistService;
    _whitelistService = appState.whitelistService;

    _labelService = appState.labelService;
    _smsBlacklistService = appState.smsBlacklistService;
    _smsWhitelistService = appState.smsWhitelistService;
    _smsTextBlacklistService = appState.smsTextBlacklistService;
    _smsTextWhitelistService = appState.smsTextWhitelistService;
  }

  bool _isAllowed = false;
  bool _isBlocked = false;

  void _onSwitchChanged(bool newValue) {
    setState(() {
      if (_isAllowed == _isBlocked) {
        if (newValue) {
          if (_isAllowed != newValue) {
            _isAllowed = true;
            _isBlocked = false;
          } else {
            _isBlocked = true;
            _isAllowed = false;
          }
        }
      } else {
        if (newValue) {
          _isAllowed = !_isAllowed;
          _isBlocked = !_isBlocked;
        } else {
          _isAllowed = false;
          _isBlocked = false;
        }
      }
    });
  }

  bool _isWhitelist = true;
  bool _isBlacklist = false; // 默认设置为 true

  void _onBWSwitchChanged(bool newValue) {
    setState(() {
      if (_isWhitelist == _isBlacklist) {
        // 这种情况现在只会发生在两个都为 false 时
        if (newValue) {
          // 如果新值为 true，我们需要确定哪个开关被点击
          if (_isWhitelist != newValue) {
            _isWhitelist = true;
            _isBlacklist = false;
          } else {
            _isBlacklist = true;
            _isWhitelist = false;
          }
        }
        // 如果新值为 false，不需要做任何改变，因为两个开关已经是 false
      } else {
        // 当两个开关状态不同时（一个为 true，一个为 false）
        _isWhitelist = !_isWhitelist;
        _isBlacklist = !_isBlacklist;
      }
    });
  }

  final Map<String, bool> _expandedItems = {};
  CallerIdData? _callerIdData;

  @override
  Widget build(BuildContext context) {
    dynamic entry = getEntryByTableName(
        context, widget.searchResult.tableName, widget.searchResult.value);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchResult.value),
      ),
      body: entry != null
          ? _buildEntryDetails(entry)
          : _buildLabelWidget(context, widget.searchResult.value),
    );
  }

  Widget _buildEntryDetails(Future<dynamic> entryFuture) {
    return FutureBuilder<dynamic>(
      future: entryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final entry = snapshot.data;

          return Column(
            children: [
              _buildEntryCard(entry),
              nativeAdWidgetSmall(adWidth: 320, adHeight: 100),
            ],
          );
        }
      },
    );
  }

  Widget _buildEntryCard(dynamic entry) {
    final expansionTileKey =
        entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry
            ? entry.keyword
            : entry.phoneNumber;

    return Card(
      color: Colors.grey[100],
      margin: const EdgeInsets.all(10.0),
      child: ExpansionTile(
        // leading: AvatarWidget(avatar: entry.avatar, label: entry.label),
        leading: (entry is BlacklistEntry ||
                entry is WhitelistEntry ||
                entry is SmsBlacklistEntry ||
                entry is SmsWhitelistEntry ||
                entry is AllowedEntry ||
                entry is BlockedEntry ||
                entry is LabeledEntry)
            ? AvatarWidget(avatar: entry.avatar, label: entry.label)
            : null,
        title: entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry
            ? KeywordWidget(keyword: entry.keyword)
            : PhoneNumberWidget(phoneNumber: entry.phoneNumber),
        // subtitle 显示逻辑与 title 保持一致
        subtitle:
            entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry
                ? null
                : LabelAndNameWidget(label: entry.label, name: entry.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 使用三元运算符根据条件显示不同的 Widget
            entry is BlacklistEntry ||
                    entry is WhitelistEntry ||
                    entry is SmsBlacklistEntry ||
                    entry is SmsWhitelistEntry
                ? StatusIconWidget(isSubscribed: entry.isSubscribed)
                : (entry is SmsTextBlacklistEntry ||
                        entry is SmsTextWhitelistEntry
                    ? const TypeStatusIconWidget(isNumberType: false)
                    : const TypeStatusIconWidget(isNumberType: true)),

            const SizedBox(width: 8),
            DeleteButtonWidget(
                onPressed: () => _showDeleteConfirmation(context, entry)),
            /*
            ExpansionIconWidget(
                isExpanded:
                    _expandedItems[entry.phoneNumber ?? entry.keyword] == true),
                    */
            ExpansionIconWidget(
              isExpanded: _expandedItems[expansionTileKey] == true,
            ),
          ],
        ),
/*
        initiallyExpanded:
            _expandedItems[entry.phoneNumber ?? entry.keyword] ?? false,
        onExpansionChanged: (expanded) {
          setState(() {
            _expandedItems[entry.phoneNumber ?? entry.keyword] = expanded;
          });
*/

        initiallyExpanded: _expandedItems[expansionTileKey] ?? false,
        onExpansionChanged: (expanded) {
          setState(() {
            _expandedItems[expansionTileKey] = expanded; // 使用相同的键
          });
        },
        children: [
          SizedBox(
            height: 600,
            child: SingleChildScrollView(
              child: _buildExpandedContent(context, entry),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context, dynamic entry) {
    final screenWidth = MediaQuery.of(context).size.width;

    final TextEditingController nameController =
        TextEditingController(text: entry.name);
/*
    final TextEditingController avatarController =
        TextEditingController(text: entry.avatar);
*/

    final TextEditingController avatarController = TextEditingController(
      text: entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry
          ? '' // 或者一个默认值
          : entry.avatar,
    );

    final TextEditingController keywordController = TextEditingController(
        text: entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry
            ? entry.keyword
            : '' // 或者一个默认值
        );

    /*
    final TextEditingController keywordController =
        TextEditingController(text: entry.keyword);
*/

    // 根据 entry 类型设置 _isWhitelist 和 _isBlacklist 的初始值
    if (entry is SmsTextBlacklistEntry || entry is SmsBlacklistEntry) {
      _isWhitelist = false;
      _isBlacklist = true;
    } else if (entry is SmsTextWhitelistEntry || entry is SmsWhitelistEntry) {
      _isWhitelist = true;
      _isBlacklist = false;
    }

    final showAvatarEditing = entry is BlacklistEntry ||
        entry is AllowedEntry ||
        entry is BlockedEntry ||
        entry is SmsBlacklistEntry ||
        entry is SmsWhitelistEntry ||
        entry is WhitelistEntry ||
        entry is LabeledEntry;

    final showCallerIdData = entry is BlacklistEntry ||
        entry is WhitelistEntry ||
        entry is SmsBlacklistEntry ||
        entry is SmsWhitelistEntry ||
        entry is AllowedEntry ||
        entry is BlockedEntry ||
        entry is LabeledEntry;

    final showAllowBlockSwitches = entry is BlacklistEntry ||
        entry is AllowedEntry ||
        entry is BlockedEntry ||
        entry is WhitelistEntry ||
        entry is LabeledEntry;

    final showWhitelistBlacklistSwitches = entry is SmsTextBlacklistEntry ||
        entry is SmsTextWhitelistEntry ||
        entry is SmsBlacklistEntry ||
        entry is SmsWhitelistEntry;

    Widget labelsWidget = _getLabelsWidget(context, entry);

    String initialNameValue =
        entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry
            ? entry.keyword
            : entry.name ?? '';

    String labelText =
        entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry
            ? S.of(context).keyword
            : S.of(context).name;

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 10),

          if (showAvatarEditing)
            AvatarEditSectionWidget(
              avatar: entry.avatar,
              label: entry.label,
              onAvatarChanged: (newAvatarPath) {
                setState(() {
                  entry.avatar = newAvatarPath;
                  avatarController.text = newAvatarPath;
                });
              },
            ),
          if (showCallerIdData)
            _buildCallerIdDataWidget(
                context, entry.phoneNumber), // Conditionally displayed

          if (showAllowBlockSwitches)
            SwitchRowWidget(
              isAllowed: _isAllowed,
              isBlocked: _isBlocked,
              onSwitchChanged: _onSwitchChanged,
              allowedType: "Allowed", // 传入 "Whitelist"
              blockedType: "Blocked", // 传入 "Blacklist"
            ),
          if (showWhitelistBlacklistSwitches)
            SwitchRowWidget(
              isAllowed: _isWhitelist,
              isBlocked: _isBlacklist,
              onSwitchChanged: _onBWSwitchChanged,
              allowedType: "Whitelist", // 传入 "Whitelist"
              blockedType: "Whitelist", // 传入 "Blacklist"
            ),
          labelsWidget,
          const Divider(height: 1),
          const SizedBox(height: 16.0),
          if (!(entry is SmsTextBlacklistEntry ||
              entry is SmsTextWhitelistEntry))
            Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: NameInputWidget(nameController: nameController)),

          if (entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry)
            NameInputWidget(nameController: nameController),
          //Expanded(child: KeywordInputWidget(keywordController: keywordController)),

          const SizedBox(height: 16.0),

          _buildActionButtons(
              context,
              entry,
              nameController,
              showAvatarEditing
                  ? avatarController
                  : null, // 条件传递 avatarController
              /*
              entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry
                  ? keywordController
                  : null, // 条件传递 keywordController
                  */
              null,
              showAllowBlockSwitches ? _isAllowed : false, // 条件传递 _isAllowed
              showAllowBlockSwitches ? _isBlocked : false, // 条件传递 _isBlocked
              showWhitelistBlacklistSwitches
                  ? _isWhitelist
                  : false, // 条件传递 _isWhitelist
              showWhitelistBlacklistSwitches
                  ? _isBlacklist
                  : false // 条件传递 _isBlacklist
              ),
          if (entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry)
            nativeAdWidgetMedium(
                adWidth: 320, adHeight: 320), // 将广告 Widget 移到这里
        ],
      ),
    );
  }

  Widget _getLabelsWidget(BuildContext context, dynamic entry) {
    if (entry is BlacklistEntry) {
      return Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).blacklistService),
      );
    } else if (entry is WhitelistEntry) {
      return Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).whitelistService),
      );
    } else if (entry is AllowedEntry) {
      return Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).allowedService),
      );
    } else if (entry is BlockedEntry) {
      return Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).blockedService),
      );
    } else if (entry is SmsWhitelistEntry) {
      return Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).smsWhitelistService),
      );
    } else if (entry is SmsBlacklistEntry) {
      return Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).smsBlacklistService),
      );
    } else if (entry is LabeledEntry) {
      return Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).labelService),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildActionButtons(
      BuildContext context,
      dynamic entry,
      TextEditingController nameController, // nameController 总是存在
      TextEditingController? avatarController, // 可空
      TextEditingController? keywordController, // 可空
      bool isAllowed,
      bool isBlocked,
      bool isWhitelist,
      bool isBlacklist) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ActionButtonWidget(
            icon: NewSet.delete,
            label: S.of(context).delete,
            onPressed: () => _showDeleteConfirmation(context, entry),
            pressedColor: Colors.red,
          ),
        ),
        const SizedBox(width: 8.0),
        if (!(entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry))
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: NameInputWidget(nameController: nameController)),
          ),
        const SizedBox(width: 8.0),
        Expanded(
          child: ActionButtonWidget(
            icon: NewSet.check,
            label: S.of(context).save,
            onPressed: () => _saveEntry(
                context,
                entry,
                nameController.text,
                avatarController?.text, // 使用 ?. 访问 avatarController
                keywordController?.text, // 使用 ?. 访问 keywordController
                isAllowed,
                isBlocked,
                isWhitelist,
                isBlacklist),
          ),
        ),
      ],
    );
  }

  // 使用泛型 T 来处理不同类型的条目
  void _saveEntry(
      BuildContext context,
      dynamic entry,
      String name,
      String? avatar, // 可空
      String? keyword, // 可空
      bool isAllowed,
      bool isBlocked,
      bool isWhitelist,
      bool isBlacklist) async {
    // 更新 entry 的属性，例如 name，avatar，label 等
    // 创建一个新的 Entry 对象，只设置通用的属性
    final updatedEntry = Entry(
      name: name,
    );

    // 使用条件判断设置其他属性
    if (entry.phoneNumber != null) {
      updatedEntry.phoneNumber = entry.phoneNumber;
    }
    if (entry.label != null) {
      updatedEntry.label = entry.label;
    }
    if (entry.name != null) {
      updatedEntry.name = name;
    }

    if (entry.avatar != null) {
      updatedEntry.avatar =
          avatar ?? entry.avatar; // 使用传递的 avatar 或保留原有的 avatar
    }
    if (entry.keyword != null) {
      updatedEntry.keyword =
          keyword ?? entry.keyword; // 使用传递的 keyword 或保留原有的 keyword
    }
    if (entry.isSubscribed != null) {
      updatedEntry.isSubscribed = entry.isSubscribed;
    }
    if (entry.count != null) {
      updatedEntry.count = entry.count;
    }
    if (entry.url != null) {
      updatedEntry.url = entry.url;
    }

    final blacklistEntry = BlacklistEntry(
      phoneNumber: updatedEntry.phoneNumber!,
      label: updatedEntry.label!,
      name: updatedEntry.name,
      avatar: updatedEntry.avatar,
      isSubscribed: updatedEntry.isSubscribed!,
      count: updatedEntry.count,
      url: updatedEntry.url,
    );

    final whitelistEntry = WhitelistEntry(
      phoneNumber: updatedEntry.phoneNumber!,
      label: updatedEntry.label!,
      name: updatedEntry.name,
      avatar: updatedEntry.avatar,
      isSubscribed: updatedEntry.isSubscribed!,
      count: updatedEntry.count,
      url: updatedEntry.url,
    );

    final labeledEntry = LabeledEntry(
      phoneNumber: updatedEntry.phoneNumber!,
      label: updatedEntry.label!,
      name: updatedEntry.name,
      avatar: updatedEntry.avatar,
    );

    final smsBlacklistEntry = SmsBlacklistEntry(
      phoneNumber: updatedEntry.phoneNumber!,
      label: updatedEntry.label!,
      name: updatedEntry.name,
      avatar: updatedEntry.avatar,
      isSubscribed: updatedEntry.isSubscribed!,
      url: updatedEntry.url,
    );

    final smsWhitelistEntry = SmsWhitelistEntry(
      phoneNumber: updatedEntry.phoneNumber!,
      label: updatedEntry.label!,
      name: updatedEntry.name,
      avatar: updatedEntry.avatar,
      isSubscribed: updatedEntry.isSubscribed!,
      url: updatedEntry.url,
    );

    final allowedEntry = AllowedEntry(
      phoneNumber: updatedEntry.phoneNumber!,
      label: updatedEntry.label!,
      name: updatedEntry.name,
      avatar: updatedEntry.avatar,
    );

    final blockedEntry = BlockedEntry(
      phoneNumber: updatedEntry.phoneNumber!,
      label: updatedEntry.label!,
      name: updatedEntry.name,
      avatar: updatedEntry.avatar,
    );

    final smsTextWhitelistEntry = SmsTextWhitelistEntry(
      keyword: updatedEntry.keyword!,
      name: updatedEntry.name,
      isSubscribed: updatedEntry.isSubscribed!,
      url: updatedEntry.url,
    );

    final smsTextBlacklistEntry = SmsTextBlacklistEntry(
      keyword: updatedEntry.keyword!,
      name: updatedEntry.name,
      isSubscribed: updatedEntry.isSubscribed!,
      url: updatedEntry.url,
    );

    if (entry is BlacklistEntry) {
      await _blacklistService.addOrUpdate(blacklistEntry);
    } else if (entry is WhitelistEntry) {
      await _whitelistService.addOrUpdate(whitelistEntry);
    } else if (entry is AllowedEntry) {
      await _allowedService.addOrUpdate(allowedEntry);
    } else if (entry is BlockedEntry) {
      await _blockedService.addOrUpdate(blockedEntry);
    } else if (entry is SmsBlacklistEntry) {
      await _smsBlacklistService.addOrUpdate(smsBlacklistEntry);
    } else if (entry is SmsWhitelistEntry) {
      await _smsWhitelistService.addOrUpdate(smsWhitelistEntry);
    } else if (entry is SmsTextBlacklistEntry) {
      await _smsTextBlacklistService.addOrUpdate(smsTextBlacklistEntry);
    } else if (entry is SmsTextWhitelistEntry) {
      await _smsTextWhitelistService.addOrUpdate(smsTextWhitelistEntry);
    } else if (entry is LabeledEntry) {
      // 添加 LabeledEntry
      await _labelService.addOrUpdate(labeledEntry);
    }

    if (isAllowed) {
      // 使用传递的 isAllowed
      await _allowedService.addOrUpdate(allowedEntry);
      await _blockedService.remove(blockedEntry);
    } else if (isBlocked) {
      // 使用传递的 isBlocked
      await _blockedService.addOrUpdate(blockedEntry);
      await _allowedService.remove(allowedEntry);
    }

    if (isWhitelist) {
      // 使用传递的 isWhitelist

      await _smsTextBlacklistService.remove(smsTextBlacklistEntry);
    } else if (isBlacklist) {
      // 使用传递的 isBlacklist

      await _smsTextWhitelistService.remove(smsTextWhitelistEntry);
    }

    setState(() {
      _expandedItems[entry.phoneNumber ?? entry.keyword] = false;
    });
  }

// 删除对话框
  void _showDeleteConfirmation(BuildContext context, dynamic entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).confirmDeletion),
        content: Text(
            '${S.of(context).areYouSureYouWantToDeleteTheItem} ${_getEntryDisplayName(entry)} ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();

              // 根据 entry 类型执行不同的删除操作
              if (entry is BlacklistEntry) {
                await _blacklistService.remove(entry);
              } else if (entry is AllowedEntry) {
                await _allowedService.remove(entry);
              } else if (entry is BlockedEntry) {
                await _blockedService.remove(entry);
              } else if (entry is LabeledEntry) {
                await _labelService.remove(entry);
              } else if (entry is SmsBlacklistEntry) {
                await _smsBlacklistService.remove(entry);
              } else if (entry is SmsWhitelistEntry) {
                await _smsWhitelistService.remove(entry);
              } else if (entry is SmsTextBlacklistEntry) {
                await _smsTextBlacklistService.remove(entry);
              } else if (entry is SmsTextWhitelistEntry) {
                await _smsTextWhitelistService.remove(entry);
              } else if (entry is WhitelistEntry) {
                await _whitelistService.remove(entry);
              }

              setState(() {}); // 更新 UI
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        '${S.of(context).deleted} ${_getEntryDisplayName(entry)} ${S.of(context).successfully}')),
              );
            },
            child: Text(S.of(context).ok),
          ),
        ],
      ),
    );
  }

  // 定义 CallerIdDataWidget
  CountryCode? selectedCountryCode;

// 主 Widget，包含国家代码选择器和 Caller ID 数据显示
  Widget _buildCallerIdDataWidget(BuildContext context, String phoneNumber) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 国家代码选择器
            _buildCountryCodeSelector(context, (countryCode) {
              // 更新外部的 selectedCountryCode
              setState(() {
                selectedCountryCode = countryCode;
              });
            }),
            Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Text(S.of(context).ifThereIsAnErrorSelectACountry)),

            // Caller ID 数据显示 (直接使用 FutureBuilder)
            FutureBuilder<CallerIdData>(
              key: ValueKey(selectedCountryCode), // 使用 countryCode 作为 Key
              future:
                  generateCallerIdData(phoneNumber, selectedCountryCode?.code),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final callerIdData = snapshot.data!;
                  return _buildCallerIdDataTable(callerIdData);
                } else {
                  return Text(S.of(context).noDataAvailable);
                }
              },
            ),
          ],
        );
      },
    );
  }

// ... 其他代码保持不变 ...

// 构建 CallerIdData 的 Table
  Widget _buildCallerIdDataTable(CallerIdData callerIdData) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1), // 冒号前占据 1/3 的空间
        1: FlexColumnWidth(2), // 冒号后占据 2/3 的空间
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle, // 垂直居中对齐
      children: [
        TableRow(
          children: [
            Text(
              S.of(context).country,
              style: callerlocationTextStyle,
            ),
            Text(
              callerIdData.countryName,
              style: callerlocationTextStyle,
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              S.of(context).region,
              style: callerlocationTextStyle,
            ),
            Text(
              callerIdData.region ?? '',
              style: callerlocationTextStyle,
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              S.of(context).carrier,
              style: callerlocationTextStyle,
            ),
            Text(
              callerIdData.carrier ?? '',
              style: callerlocationTextStyle,
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              S.of(context).label,
              style: callerlocationTextStyle,
            ),
            Text(
              callerIdData.labels.first.label,
              style: callerlocationTextStyle,
            ),
          ],
        ),
      ],
    );
  }

// 构建选择国际区号的控件
  Widget _buildCountryCodeSelector(
    BuildContext context,
    Function(CountryCode?) onCountryCodeSelected,
  ) {
    const countryPicker = FlCountryCodePicker();
    final localeProvider = Provider.of<LocaleProvider>(context);

    return GestureDetector(
      onTap: () async {
        final picked = await countryPicker.showPicker(
          context: context,
          // initialSelectedLocale 设置为 null
          initialSelectedLocale: null,
        );
        // 将选择的国家代码传递给回调函数，并在 _buildCallerIdDataWidget 中触发重新构建
        onCountryCodeSelected(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 使用 localeProvider.locale.countryCode 获取默认的国家代码和国家名称
            Text(
              selectedCountryCode != null
                  ? '${selectedCountryCode!.dialCode} ${selectedCountryCode!.name} (${selectedCountryCode!.code})'
                  : S.of(context).selectCountryCodeOptional,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 8.0),
            const Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
      ),
    );
  }

//自定义添加labelpage 跳转
  Widget _buildLabelWidget(BuildContext context, String phoneNumber) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        // 使用 Align 组件
        alignment: Alignment.topCenter, // 设置顶部对齐
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCallerIdDataWidget(context, phoneNumber),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddLabelPage(initialPhoneNumber: phoneNumber),
                  ),
                );
              },
              child: Text(S.of(context).addToLabel),
            ),
            const SizedBox(height: 16),
            nativeAdWidgetMedium(adWidth: 320, adHeight: 400),
            const GoogleAdWidget(adInfo: AdManager.bannerAd),
          ],
        ),
      ),
    );
  }

// 获取 entry 的显示名称
  String _getEntryDisplayName(dynamic entry) {
    if (entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry) {
      return '${entry.keyword}';
    } else if (entry is LabeledEntry) {
      return entry.name ?? entry.phoneNumber;
    } else {
      return '${entry.phoneNumber}';
    }
  }

// ... (其他代码)

  // 根据 SearchResult 的 tableName 和 value 获取对应的 Entry 对象
  dynamic getEntryByTableName(
      BuildContext context, String tableName, String value) {
    switch (tableName) {
      case 'blacklist_phonenumber':
        return Provider.of<AppState>(context, listen: false)
            .blacklistService
            .getEntryByPhoneNumber(value);
      case 'whitelist_phonenumber':
        return Provider.of<AppState>(context, listen: false)
            .whitelistService
            .getEntryByPhoneNumber(value);

      case 'allowed_phonenumber':
        return Provider.of<AppState>(context, listen: false)
            .allowedService
            .getEntryByPhoneNumber(value);
      case 'blocked_phonenumber':
        return Provider.of<AppState>(context, listen: false)
            .blockedService
            .getEntryByPhoneNumber(value);
      case 'label_calls':
        return Provider.of<AppState>(context, listen: false)
            .labelService
            .getEntryByPhoneNumber(value);

      case 'sms_blacklisted':
        return Provider.of<AppState>(context, listen: false)
            .smsBlacklistService
            .getEntryByPhoneNumber(value);
      case 'sms_whitelisted':
        return Provider.of<AppState>(context, listen: false)
            .smsWhitelistService
            .getEntryByPhoneNumber(value);
      case 'sms_text_blacklisted':
        return Provider.of<AppState>(context, listen: false)
            .smsTextBlacklistService
            .getEntryByKeyword(value);
      case 'sms_text_whitelisted':
        return Provider.of<AppState>(context, listen: false)
            .smsTextWhitelistService
            .getEntryByKeyword(value);

      default:
        return null; // 在找不到匹配的表名时返回 null
    }
  }

  Future<CallerIdData> generateCallerIdData(String phoneNumber,
      [String? countryCode]) async {
    // 解析号码 (使用提取出的函数)

    final parsedData = countryCode != null
        ? await parsePhoneNumberWithIso(
            phoneNumber, countryCode) // 使用传入的 countryCode 解析
        : await parsePhoneNumberWithoutIso(phoneNumber, null); // 使用默认逻辑解析


    final countryCodeFromParsedData = parsedData['countryCode']!;
    final e164Number = parsedData['e164Number']!;

    // 使用 Provider 获取当前的 Locale
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;

    final languageCode = currentLocale.languageCode;

    // 创建 dlibphonenumber 的 Locale
    final dlibLocale = dlibphone.Locale(
      language: languageCode,
      country: (countryCodeFromParsedData).toUpperCase(), // 使用 toUpperCase() 方法
    );

    final appState = Provider.of<AppState>(context, listen: false);
    final callerIdService = appState.callerIdService;

    CallerIdData callerIdData =
        await callerIdService.getCallerId(e164Number, dlibLocale);

    return callerIdData;
  }
}
