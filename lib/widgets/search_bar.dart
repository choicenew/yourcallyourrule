import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/appstate_provider.dart';
import '../views/search_default_page.dart';
import 'search_bar_ui.dart';

class CustomSearchBar extends StatefulWidget {
  final Color backgroundColor;
  final BorderRadius borderRadius;

  const CustomSearchBar({
    super.key,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
  });

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  List<SearchResult> _searchResults = [];
  bool _showResults = false;

  Future<void> _onSearch(String query) async {
    if (query.isNotEmpty) {
      final results =
          await SearchService.search(query, context); // 传入 context 参数
      setState(() {
        _searchResults = results;
        _showResults = true;
      });
    } else {
      setState(() {
        _searchResults = [];
        _showResults = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: widget.borderRadius,
          ),
          child: SearchBarUI(onSearch: _onSearch),
        ),
        if (_showResults)
          SizedBox(
            height: 350,
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return ListTile(
                  title: Text(result.value),
                  subtitle: Text(result.tableName),
                  onTap: () => _navigateToResult(context, result),
                );
              },
            ),
          ),
      ],
    );
  }

  // 导航到通用页面
  void _navigateToResult(BuildContext context, SearchResult result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GeneralPage(searchResult: result),
      ),
    );
  }
}

class SearchResult {
  final String tableName;
  final String value;

  SearchResult({required this.tableName, required this.value});
}

class SearchService {
  static const String _dbName = 'call_rule_database.db';

  static Future<List<SearchResult>> search(
      String query, BuildContext context) async {
    // 添加 context 参数
    final appState =
        Provider.of<AppState>(context, listen: false); // 获取 AppState 对象
    final db = appState.callRuleDatabase; // 使用 AppState 中的数据库对象

    List<SearchResult> results = [];

    try {
      // 获取所有表名
      final List<Map<String, dynamic>> tableMaps = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
      final tableNames = tableMaps.map((map) => map['name'] as String).toList();

      // 遍历所有表
      for (final tableName in tableNames) {
        // 检查表是否包含 phoneNumber, keyword 或 phone_numbers 列
        final List<Map<String, dynamic>> columnMaps =
            await db.rawQuery("PRAGMA table_info('$tableName')");
        final columnNames =
            columnMaps.map((map) => map['name'] as String).toList();

        if (columnNames.contains('phoneNumber') ||
            columnNames.contains('keyword') ||
            columnNames.contains('phone_numbers')) {
          // 构建 where 子句和 whereArgs
          String whereClause = '';
          List<String> whereArgs = [];
          if (columnNames.contains('phoneNumber')) {
            whereClause += 'phoneNumber LIKE ? OR ';
            whereArgs.add('%$query%');
          }
          if (columnNames.contains('keyword')) {
            whereClause += 'keyword LIKE ? OR ';
            whereArgs.add('%$query%');
          }
          if (columnNames.contains('phone_numbers')) {
            whereClause += 'phone_numbers LIKE ? OR ';
            whereArgs.add('%$query%');
          }

          // 移除最后的 "OR "
          if (whereClause.isNotEmpty) {
            whereClause = whereClause.substring(0, whereClause.length - 4);
          }

          // 执行查询
          if (whereClause.isNotEmpty) {
            final List<Map<String, dynamic>> maps = await db.query(
              tableName,
              where: whereClause,
              whereArgs: whereArgs,
            );

            results.addAll(maps
                .map((map) => SearchResult(
                      tableName: tableName,
                      value: map['phoneNumber'] != null
                          ? map['phoneNumber'] as String
                          : map['keyword'] != null
                              ? map['keyword'] as String
                              : map['phone_numbers'] as String,
                    ))
                .toList());
          }
        }
      }
      // 在循环外添加以下代码：
      if (results.isEmpty) {
        // 如果没有找到匹配的结果
        results.add(SearchResult(
            tableName: '', value: query)); // 添加一个 tableName 为空的 SearchResult
      }
    } finally {
      // 不需要关闭数据库，因为数据库将在应用程序关闭时关闭
    }

    return results;
  }
}
