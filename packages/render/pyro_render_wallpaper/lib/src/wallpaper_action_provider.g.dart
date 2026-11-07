// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WallpaperActions)
const wallpaperActionsProvider = WallpaperActionsFamily._();

final class WallpaperActionsProvider
    extends $NotifierProvider<WallpaperActions, List<UserAction>> {
  const WallpaperActionsProvider._(
      {required WallpaperActionsFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'wallpaperActionsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wallpaperActionsHash();

  @override
  String toString() {
    return r'wallpaperActionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  WallpaperActions create() => WallpaperActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserAction>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WallpaperActionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wallpaperActionsHash() => r'03b57df342fccdcfd6b891f350c5686808bf643c';

final class WallpaperActionsFamily extends $Family
    with
        $ClassFamilyOverride<WallpaperActions, List<UserAction>,
            List<UserAction>, List<UserAction>, String> {
  const WallpaperActionsFamily._()
      : super(
          retry: null,
          name: r'wallpaperActionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  WallpaperActionsProvider call(
    String contentId,
  ) =>
      WallpaperActionsProvider._(argument: contentId, from: this);

  @override
  String toString() => r'wallpaperActionsProvider';
}

abstract class _$WallpaperActions extends $Notifier<List<UserAction>> {
  late final _$args = ref.$arg as String;
  String get contentId => _$args;

  List<UserAction> build(
    String contentId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<List<UserAction>, List<UserAction>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<UserAction>, List<UserAction>>,
        List<UserAction>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
