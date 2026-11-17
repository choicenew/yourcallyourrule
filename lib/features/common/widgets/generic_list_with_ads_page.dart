export 'generic_list_page.dart';
import 'generic_list_page.dart';

class GenericListWithAdsPage<T> extends GenericListPage<T> {
  const GenericListWithAdsPage({
    super.key,
    required super.title,
    required super.items,
    required super.itemBuilder,
    required super.getItemId,
    required super.emptyText,
    required super.adBuilder,
    super.isLoading,
    super.headerContent,
    super.onRefresh,
    super.onAdd,
    super.onMoreOptions,
    super.onSearchChanged,
    super.searchHintText,
    super.emptyIcon,
    super.emptyActionButton,
    super.themeColor,
    super.adInterval,
    super.isMultiSelectMode,
    super.selectedItemIds,
    super.onToggleMultiSelectMode,
    super.onDeleteSelected,
    super.onToggleItemSelection,
    super.actions,
    super.customActions,
    super.onMultiSelect,
  });
}
