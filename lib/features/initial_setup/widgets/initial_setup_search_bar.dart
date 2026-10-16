import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';

/// 搜索与批量选择控制条组件：支持海量规则实时模糊匹配与一键全选/取消全选
class InitialSetupSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final bool isAllSelected;
  final bool isAnySelected;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final VoidCallback onToggleSelectAll;

  const InitialSetupSearchBar({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.isAllSelected,
    required this.isAnySelected,
    required this.onSearchChanged,
    required this.onClearSearch,
    required this.onToggleSelectAll,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: EliteDopamineTheme.slateBorder),
              ),
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: l10n.initialSetupSearchHint,
                  hintStyle: const TextStyle(fontSize: 12, color: EliteDopamineTheme.textMuted),
                  prefixIcon: const Icon(Icons.search_rounded, size: 18, color: EliteDopamineTheme.textSecondary),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 16),
                          onPressed: onClearSearch,
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: Text(
              isAllSelected ? l10n.initialSetupDeselectAll : l10n.initialSetupSelectAll,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            selected: isAnySelected,
            onSelected: (_) => onToggleSelectAll(),
          ),
        ],
      ),
    );
  }
}
