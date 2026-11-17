export 'generic_timeline_page.dart';
import 'generic_timeline_page.dart';

class GenericTimelineListWithAdsPage<T> extends GenericTimelinePage<T> {
  const GenericTimelineListWithAdsPage({
    super.key,
    required super.title,
    required super.items,
    required super.itemBuilder,
    required super.adBuilder,
    super.adInterval,
    required super.emptyText,
    super.emptyIcon,
    super.emptyActionButton,
    super.themeColor,
    super.isLoading,
    super.onRefresh,
    super.onAdd,
    super.onMoreOptions,
    super.actions,
    super.headerContent,
    super.onMultiSelect,
    super.getItemId,
    super.isMultiSelectMode,
    super.selectedItemIds,
  });
}
