// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VideoActions)
const videoActionsProvider = VideoActionsFamily._();

final class VideoActionsProvider
    extends $NotifierProvider<VideoActions, List<UserAction>> {
  const VideoActionsProvider._(
      {required VideoActionsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'videoActionsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$videoActionsHash();

  @override
  String toString() {
    return r'videoActionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VideoActions create() => VideoActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserAction>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VideoActionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$videoActionsHash() => r'1619a27a302316d41c730da0c08a4793cbb543bb';

final class VideoActionsFamily extends $Family
    with
        $ClassFamilyOverride<VideoActions, List<UserAction>, List<UserAction>,
            List<UserAction>, String> {
  const VideoActionsFamily._()
      : super(
          retry: null,
          name: r'videoActionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  VideoActionsProvider call(
    String contentId,
  ) =>
      VideoActionsProvider._(argument: contentId, from: this);

  @override
  String toString() => r'videoActionsProvider';
}

abstract class _$VideoActions extends $Notifier<List<UserAction>> {
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
