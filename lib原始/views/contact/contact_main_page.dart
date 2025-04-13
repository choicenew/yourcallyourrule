import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinyin/pinyin.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/contact_service.dart';
import '../../services/instant_app_service.dart';
import '../../utils/ad_state.dart';
import '../../widgets/adwidgets/native_ads.dart';
import '../../widgets/navigation_bar.dart';
import '../subpage_style.dart';
import 'contact_details_page.dart';
import 'contact_form_page.dart';

import 'contact_setting_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  // Add a static method to obtain the _ContactsPageState
  static ContactsPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<ContactsPageState>();

  @override
  ContactsPageState createState() => ContactsPageState();
}

class ContactsPageState extends State<ContactsPage>
    with WidgetsBindingObserver {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  final ScrollController _scrollController = ScrollController();

  late ContactService _contactService;
  bool _showWhatsApp = true;
  bool _showTelegram = true;
  bool _isLoading = false;
  bool _isSearching = false;

  static double contactItemHeight = 72.0;


  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _contactService = appState.contactService;

    WidgetsBinding.instance.addObserver(this);
    _initServices();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _fetchContacts(); // 在应用从后台回到前台时重新获取通话
    }
  }

  Future<void> _initServices() async {
    final appState = Provider.of<AppState>(context, listen: false);
    _contactService = appState.contactService;
    await _loadPreferences();
    // Fetch contacts
    await _fetchContacts();
  }

  Future<void> _loadPreferences() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

    _showWhatsApp = await asyncPrefs.getBool('show_whatsapp') ?? true;
    _showTelegram = await asyncPrefs.getBool('show_telegram') ?? true;
    setState(() {});
  }

  Future<void> _fetchContacts() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final fetchedContacts = await _contactService.getAllContacts();
      setState(() {
        _contacts = fetchedContacts;
        _filteredContacts = fetchedContacts;
        _sortContacts();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _sortContacts() {
    _filteredContacts.sort(
        (a, b) => _getFirstLetter(a.name).compareTo(_getFirstLetter(b.name)));
  }

  void _filterContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredContacts = _contacts;
        _isSearching = false;
      } else {
        _filteredContacts = _contacts
            .where((contact) =>
                contact.name.toLowerCase().contains(query.toLowerCase()) ||
                contact.phoneNumbers.any((phoneNumber) =>
                    phoneNumber.toLowerCase().contains(query.toLowerCase())))
            .toList();
        _isSearching = true;
      }
      _sortContacts();
    });
  }

void _scrollToAlphabet(String alphabet) {
  final adState = Provider.of<AdState>(context, listen: false);

  // 获取每行的 item 数量
  final mediaQuery = MediaQuery.of(context);
  final int contactsPerRow = mediaQuery.orientation == Orientation.portrait
      ? (mediaQuery.size.width > 900 ? 2 : 1)
      : (mediaQuery.size.width > 1000 ? 4 : 2);

  double offset = 0.0;
  int adCount = 0; // 广告数量
  int headerCount = 0; // 字母标题数量
  String? lastInitial; // 记录上一个联系人的首字母
  int currentRow = 0; // 当前行数

  // 遍历过滤后的联系人列表
  for (int index = 0; index < _filteredContacts.length; index++) {
    // 判断是否是广告项
    if ((index + 1) % 4 == 0 && adState.isAdEnabled) {
      adCount++;
      offset += 90.0 + 5; // 广告项高度 + 垂直间距
      currentRow++; // 广告占一行
      continue;
    }

    final contact = _filteredContacts[index];
    final firstLetter = _getFirstLetter(contact.name).toUpperCase();

    // 判断是否需要显示字母标题
    if (lastInitial != firstLetter && !_isSearching) {
      headerCount++;
      offset += 30.0 + 5; // 字母标题项高度 + 垂直间距
      currentRow++; // 字母标题占一行
    }
    lastInitial = firstLetter; // 更新 lastInitial

    // 累加联系人项高度和垂直间距
    offset += contactItemHeight + 5;

    // 计算水平间距
    if ((index - adCount - headerCount) % contactsPerRow != 0) { // 不是每行的第一个 item
      offset += 5; // 水平间距
    }

    // 判断是否换行
    if ((index - adCount - headerCount + 1) % contactsPerRow == 0) {
      currentRow++;
    }
  }

  // 计算总的 offset，包括广告和字母标题
  offset += currentRow * 5; // 加上所有行的垂直间距


  // 找到目标字母的索引
  int targetIndex = _filteredContacts.indexWhere(
    (contact) => _getFirstLetter(contact.name).toUpperCase() == alphabet,
  );

  // 如果找到目标字母
  if (targetIndex != -1) {
    // 重置 offset 和相关计数器
    offset = 0.0;
    adCount = 0;
    headerCount = 0;
    lastInitial = null;
    currentRow = 0;

    // 遍历到目标字母之前的联系人
    for (int index = 0; index <= targetIndex; index++) {
      // 判断是否是广告项
      if ((index + 1) % 4 == 0 && adState.isAdEnabled) {
        adCount++;
        offset += 90.0 + 5; // 广告项高度 + 垂直间距
        currentRow++; // 广告占一行
        continue;
      }

      final contact = _filteredContacts[index];
      final firstLetter = _getFirstLetter(contact.name).toUpperCase();

      // 判断是否需要显示字母标题
      if (lastInitial != firstLetter && !_isSearching) {
        headerCount++;
        offset += 30.0 + 5; // 字母标题项高度 + 垂直间距
        currentRow++; // 字母标题占一行
      }
      lastInitial = firstLetter; // 更新 lastInitial

      // 累加联系人项高度和垂直间距
      offset += contactItemHeight + 5;

      // 计算水平间距
      if ((index - adCount - headerCount) % contactsPerRow != 0) { // 不是每行的第一个 item
        offset += 5; // 水平间距
      }

      // 判断是否换行
      if ((index - adCount - headerCount + 1) % contactsPerRow == 0) {
        currentRow++;
      }
    }

    // 计算目标字母之前的 offset，包括广告和字母标题
    offset += currentRow * 5+90; // 加上所有行的垂直间距
  }

  // 平滑滚动到目标位置
  _scrollController.animateTo(
    offset,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
}


  String _getFirstLetter(String name) {
    if (name.isEmpty) return '#';
    final firstChar = name[0];
    if (RegExp(r'[A-Za-z]').hasMatch(firstChar)) {
      return firstChar.toUpperCase();
    } else if (RegExp(r'[\u4e00-\u9fa5]').hasMatch(firstChar)) {
      // Use pinyin library to get the first letter
      try {
        String pinyin = PinyinHelper.getPinyinE(firstChar,
            format: PinyinFormat.WITHOUT_TONE);
        return pinyin.substring(0, 1).toUpperCase();
      } catch (e) {
        // If conversion fails, return '#'
        return '#';
      }
    } else {
      return '#';
    }
  }

  void _openContactDetails(BuildContext context, Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ContactDetailsPage(contact: contact)),
    );
  }

//显示头像，可展示网络头像
  ImageProvider? _buildAvatarImage(Contact contact) {
    if (contact.avatar != null && contact.avatar!.isNotEmpty) {
      if (contact.avatar!.startsWith('http')) {
        return NetworkImage(contact.avatar!);
      } else {
        return AssetImage(contact.avatar!);
      }
    } else {
      return null; // 没有头像路径时返回 null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).contactsPage),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the tertiary page for adding a new contact
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SettingsPage(contactService: _contactService)));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _initServices,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ContactSearchBar(onSearch: _filterContacts),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _build(context)),
                        AlphabetIndexBar(
                          onSelectLetter: _scrollToAlphabet,
                          contacts: _filteredContacts,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigate to the tertiary page for adding a new contact
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ContactFormPage()));
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  // 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    final adState = Provider.of<AdState>(context);
    return OrientationBuilder(
      builder: (context, orientation) {
        final mediaQuery = MediaQuery.of(context);

        // 根据屏幕方向和宽度设置每行卡片数
        final int contactsPerRow = orientation == Orientation.portrait
            ? (mediaQuery.size.width > 900 ? 2 : 1)
            : (mediaQuery.size.width > 1000 ? 4 : 2);

        // 根据屏幕宽度设置水平 padding
        final double functionEntryHorizontalPadding =
            mediaQuery.size.width > 900 ? 24.0 : 9.0;

        // 计算卡片宽度
        final double contactWidth = (mediaQuery.size.width -
                2 * functionEntryHorizontalPadding -
                (contactsPerRow - 1) * 10) /
            contactsPerRow;

        // 记录上一个联系人的首字母
        String? lastInitial;

        return ListView(
          controller: _scrollController,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: functionEntryHorizontalPadding,
              ),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                alignment: WrapAlignment.spaceBetween,
                // 使用 adState.isAdEnabled
                children: List.generate(
                    _filteredContacts.length +
                        (adState.isAdEnabled
                            ? _filteredContacts.length ~/ 3
                            : 0), (index) {
                  if ((index + 1) % 4 == 0 && adState.isAdEnabled) {
                    return nativeAdWidgetSmall(
                        adWidth: contactWidth, adHeight: 90);
                  } else {
                    final adjustedIndex = index - (index ~/ 4);
                    final contacts = _filteredContacts[adjustedIndex];

                    // 计算 previousContact，考虑用户搜索情况
                    final previousContactIndex =
                        adjustedIndex > 0 ? adjustedIndex - 1 : null;
                    final previousContact = previousContactIndex != null
                        ? _filteredContacts[previousContactIndex]
                        : null;

                    // 判断是否需要显示字母标题
                    final showAlphabetHeader =
                        lastInitial != _getFirstLetter(contacts.name);
                    if (showAlphabetHeader) {
                      lastInitial = _getFirstLetter(contacts.name);
                    }

                    return SizedBox(
                      // 使用 SizedBox 限制 Column 的宽度
                      width: contactWidth, // 设置 SizedBox 的宽度为 contactWidth
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showAlphabetHeader && !_isSearching)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 16.0),
                              child: Text(
                                // contacts.name[0].toUpperCase(),
                                lastInitial!.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          _buildContactItem(contacts, contactWidth),
                        ],
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        );
      },
    );
  }

// 构建单个订阅项，并传入卡片宽度参数
  Widget _buildContactItem(Contact contact, double contactWidth) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green, width: 2),
            image: contact.avatar != null && contact.avatar!.isNotEmpty
                ? DecorationImage(
                    image: _buildAvatarImage(contact)!,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: contact.avatar == null || contact.avatar!.isEmpty
              ? Center(
                  child: Text(
                    _contactService.getAvatarInitial(contact),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : null,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.name,
              style: entryTitleStyle,
            ),
            Text(
              contact.phoneNumbers.first,
              style: entryNameStyle,
            ),
          ],
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Add this line
          children: [
            if (_showWhatsApp)
              IconButton(
                icon: const Icon(NewSet.whatsapp, size: 20),
                onPressed: () => openWhatsApp(
                  context: context,
                  phoneNumber: contact.phoneNumbers.first,
                ),
              ),
            if (_showTelegram)
              IconButton(
                icon: const Icon(Icons.telegram, size: 20),
                onPressed: () => openTelegram(
                  context: context,
                  phoneNumber: contact.phoneNumbers.first,
                ),
              ),
          ],
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              icon: const Icon(NewSet.phone, size: 20),
              onPressed: () => openPhoneDialer(contact.phoneNumbers.first),
            ),
            IconButton(
              icon: const Icon(NewSet.sms, size: 20),
              onPressed: () => openSMSMessage(contact.phoneNumbers.first),
            ),
            IconButton(
              icon: const Icon(NewSet.more, size: 20),
              onPressed: () => _openContactDetails(context, contact),
            ),
          ],
        ),
      ),
    );
  }
}

class AlphabetIndexBar extends StatefulWidget {
  final Function(String) onSelectLetter;
  final List<Contact> contacts;

  const AlphabetIndexBar({
    super.key,
    required this.onSelectLetter,
    required this.contacts,
  });

  @override
  AlphabetIndexBarState createState() => AlphabetIndexBarState();
}

class AlphabetIndexBarState extends State<AlphabetIndexBar> {
  String? _selectedLetter;
  Timer? _hideTimer;

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _selectLetter(String letter) {
    
    setState(() {
      _selectedLetter = letter;
    });
    widget.onSelectLetter(letter);
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 1), () {
      setState(() {
        _selectedLetter = null;
      });
    });
  }

  String _getFirstLetter(String name) {
    if (name.isEmpty) return '#';
    final firstChar = name[0];
    if (RegExp(r'[A-Za-z]').hasMatch(firstChar)) {
      return firstChar.toUpperCase();
    } else if (RegExp(r'[\u4e00-\u9fa5]').hasMatch(firstChar)) {
      // Use pinyin library to get the first letter
      try {
        String pinyin = PinyinHelper.getPinyinE(firstChar,
            format: PinyinFormat.WITHOUT_TONE);
        return pinyin.substring(0, 1).toUpperCase();
      } catch (e) {
        // If conversion fails, return '#'
        return '#';
      }
    } else {
      return '#';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Set<String> uniqueLetters =
        widget.contacts.map((contact) => _getFirstLetter(contact.name)).toSet();
    final List<String> sortedLetters = uniqueLetters.toList()..sort();

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 35,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              final RenderBox box = context.findRenderObject() as RenderBox;
              final localPosition = box.globalToLocal(details.globalPosition);
              final index =
                  (localPosition.dy / box.size.height * sortedLetters.length)
                      .floor();
              if (index >= 0 && index < sortedLetters.length) {
                _selectLetter(sortedLetters[index]);
              }
            },
            child: ListView.builder(
              itemCount: sortedLetters.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _selectLetter(sortedLetters[index]),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      sortedLetters[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (_selectedLetter != null)
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _selectedLetter!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ContactSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const ContactSearchBar({super.key, required this.onSearch});

  @override
  ContactSearchBarState createState() => ContactSearchBarState();
}

class ContactSearchBarState extends State<ContactSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: S.of(context).searchContacts,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _isSearching
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      widget.onSearch('');
                      setState(() {
                        _isSearching = false;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {
            widget.onSearch(value);
            setState(() {
              _isSearching = value.isNotEmpty;
            });
          },
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            FocusScope.of(context).unfocus();
          },
        ),
        if (_isSearching)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${S.of(context).showingResultsFor} "${_searchController.text}"',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
      ],
    );
  }
}
