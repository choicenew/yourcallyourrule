import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:world_flags/world_flags.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart' as dlibphone;
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/features/search/widgets/search_result_item.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';

/// 搜索页面
/// 用于搜索本地和远程数据库中的号码
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// 执行搜索
  Future<void> _performSearch() async {
    final searchText = _searchController.text.trim();
    if (searchText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入搜索内容')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    try {
      final searchService = Provider.of<SearchService>(context, listen: false);
      final results = await searchService.searchPhoneNumber(searchText);

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });

      // 如果没有找到结果，显示提示
      if (results.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('未找到匹配的号码')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('搜索出错: $e')),
      );
    }
  }

  /// 处理搜索结果项点击
  void _handleResultTap(SearchResult result) {
    if (result.type == SearchResultType.remoteNumber) {
      _showCallerIdDialog(context, result.phoneNumber);
    } else if (result.type == SearchResultType.notFound) {
      _showCountrySelectionDialog(context, result.phoneNumber);
    }
  }

  // 显示国家选择对话框
  void _showCountrySelectionDialog(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('选择国家', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: WorldCountry.list.length,
                  itemBuilder: (context, index) {
                    final country = WorldCountry.list[index];
                    return ListTile(
                      leading: CountryFlag.simplified(
                        country,
                        height: 24,
                      ),
                      title: Text(country.internationalName),
                      subtitle: Text(country.namesNative.first.common),
                      onTap: () {
                        Navigator.pop(context);
                        _showCallerIdDialog(
                          context,
                          phoneNumber,
                          countryCode: country.code,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 显示来电显示信息对话框
  void _showCallerIdDialog(BuildContext context, String phoneNumber, {String? countryCode}) async {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final callerIdService = Provider.of<CallerIdService>(context, listen: false);

    // 创建 dlibphone.Locale
    final dlibLocale = dlibphone.Locale(
      language: localeProvider.locale.languageCode,
      country: countryCode ?? localeProvider.locale.countryCode ?? 'US',
    );

    try {
      // 显示加载对话框
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 获取来电显示信息
      final callerIdData = await callerIdService.getCallerId(phoneNumber, dlibLocale);

      // 关闭加载对话框
      Navigator.pop(context);

      // 显示结果对话框
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('号码: ${callerIdData.phoneNumber}'),
                const SizedBox(height: 8),
                Text('名称: ${callerIdData.name}'),
                if (callerIdData.countryName != null) ...[                  
                  const SizedBox(height: 8),
                  Text('国家: ${callerIdData.countryName}'),
                ],
                if (callerIdData.region != null) ...[                  
                  const SizedBox(height: 8),
                  Text('地区: ${callerIdData.region}'),
                ],
                if (callerIdData.carrier != null) ...[                  
                  const SizedBox(height: 8),
                  Text('运营商: ${callerIdData.carrier}'),
                ],
                if (callerIdData.labels != null) ...[                  
                  const SizedBox(height: 8),
                  Text('标签: ${callerIdData.labels!.map((l) => l.label).join(', ')}'),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('关闭'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      // 关闭加载对话框
      Navigator.pop(context);
      // 显示错误信息
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('获取来电显示信息失败: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('号码搜索'),
      ),
      body: Column(
        children: [
          // 搜索框
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: '输入电话号码',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    onSubmitted: (_) => _performSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _performSearch,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('搜索'),
                ),
              ],
            ),
          ),

          // 搜索结果
          Expanded(
            child: _hasSearched
                ? _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _searchResults.isEmpty
                        ? const Center(child: Text('未找到匹配的号码'))
                        : ListView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              final result = _searchResults[index];
                              return SearchResultItem(
                                result: result,
                                onTap: () => _handleResultTap(result),
                              );
                            },
                          )
                : const Center(
                    child: Text('输入电话号码开始搜索'),
                  ),
          ),
        ],
      ),
    );
  }
}