// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outbound_blocked_labels_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 去电/外呼重定向与防诈标签拦截集合配置 Notifier

@ProviderFor(OutboundBlockedLabels)
final outboundBlockedLabelsProvider = OutboundBlockedLabelsProvider._();

/// 去电/外呼重定向与防诈标签拦截集合配置 Notifier
final class OutboundBlockedLabelsProvider
    extends $NotifierProvider<OutboundBlockedLabels, Set<String>> {
  /// 去电/外呼重定向与防诈标签拦截集合配置 Notifier
  OutboundBlockedLabelsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'outboundBlockedLabelsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$outboundBlockedLabelsHash();

  @$internal
  @override
  OutboundBlockedLabels create() => OutboundBlockedLabels();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$outboundBlockedLabelsHash() =>
    r'ffdc824eb4917271355492ac47ecffc26c743bcb';

/// 去电/外呼重定向与防诈标签拦截集合配置 Notifier

abstract class _$OutboundBlockedLabels extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
