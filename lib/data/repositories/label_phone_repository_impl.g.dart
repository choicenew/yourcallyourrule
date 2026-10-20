// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_phone_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 电话标签仓库提供者

@ProviderFor(labelPhoneRepository)
final labelPhoneRepositoryProvider = LabelPhoneRepositoryProvider._();

/// 电话标签仓库提供者

final class LabelPhoneRepositoryProvider
    extends
        $FunctionalProvider<
          LabelPhoneRepository,
          LabelPhoneRepository,
          LabelPhoneRepository
        >
    with $Provider<LabelPhoneRepository> {
  /// 电话标签仓库提供者
  LabelPhoneRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelPhoneRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelPhoneRepositoryHash();

  @$internal
  @override
  $ProviderElement<LabelPhoneRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LabelPhoneRepository create(Ref ref) {
    return labelPhoneRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabelPhoneRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabelPhoneRepository>(value),
    );
  }
}

String _$labelPhoneRepositoryHash() =>
    r'1fde3123b58aecd287764150d60d72ba3e04f151';
