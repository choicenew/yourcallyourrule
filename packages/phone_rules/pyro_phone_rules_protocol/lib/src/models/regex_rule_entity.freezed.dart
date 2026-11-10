// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regex_rule_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it directly.');

RegexRuleEntity _$RegexRuleEntityFromJson(Map<String, dynamic> json) {
  return _RegexRuleEntity.fromJson(json);
}

/// @nodoc
mixin _$RegexRuleEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get pattern => throw _privateConstructorUsedError;
  String get actionType => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  String? get subscriptionId => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegexRuleEntityCopyWith<RegexRuleEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegexRuleEntityCopyWith<$Res> {
  factory $RegexRuleEntityCopyWith(
          RegexRuleEntity value, $Res Function(RegexRuleEntity) then) =
      _$RegexRuleEntityCopyWithImpl<$Res, RegexRuleEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String pattern,
      String actionType,
      int priority,
      String? subscriptionId,
      bool isEnabled});
}

/// @nodoc
class _$RegexRuleEntityCopyWithImpl<$Res, $Val extends RegexRuleEntity>
    implements $RegexRuleEntityCopyWith<$Res> {
  _$RegexRuleEntityCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pattern = null,
    Object? actionType = null,
    Object? priority = null,
    Object? subscriptionId = freezed,
    Object? isEnabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      subscriptionId: freezed == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegexRuleEntityImplCopyWith<$Res>
    implements $RegexRuleEntityCopyWith<$Res> {
  factory _$$RegexRuleEntityImplCopyWith(_$RegexRuleEntityImpl value,
          $Res Function(_$RegexRuleEntityImpl) then) =
      __$$RegexRuleEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String pattern,
      String actionType,
      int priority,
      String? subscriptionId,
      bool isEnabled});
}

/// @nodoc
class __$$RegexRuleEntityImplCopyWithImpl<$Res>
    extends _$RegexRuleEntityCopyWithImpl<$Res, _$RegexRuleEntityImpl>
    implements _$$RegexRuleEntityImplCopyWith<$Res> {
  __$$RegexRuleEntityImplCopyWithImpl(_$RegexRuleEntityImpl _value,
      $Res Function(_$RegexRuleEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pattern = null,
    Object? actionType = null,
    Object? priority = null,
    Object? subscriptionId = freezed,
    Object? isEnabled = null,
  }) {
    return _then(_$RegexRuleEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      subscriptionId: freezed == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegexRuleEntityImpl extends _RegexRuleEntity {
  const _$RegexRuleEntityImpl(
      {required this.id,
      required this.name,
      required this.pattern,
      this.actionType = 'block',
      this.priority = 100,
      this.subscriptionId,
      this.isEnabled = true})
      : super._();

  factory _$RegexRuleEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegexRuleEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String pattern;
  @override
  @JsonKey()
  final String actionType;
  @override
  @JsonKey()
  final int priority;
  @override
  final String? subscriptionId;
  @override
  @JsonKey()
  final bool isEnabled;

  @override
  String toString() {
    return 'RegexRuleEntity(id: $id, name: $name, pattern: $pattern, actionType: $actionType, priority: $priority, subscriptionId: $subscriptionId, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegexRuleEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pattern, pattern) || other.pattern == pattern) &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, pattern, actionType,
      priority, subscriptionId, isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegexRuleEntityImplCopyWith<_$RegexRuleEntityImpl> get copyWith =>
      __$$RegexRuleEntityImplCopyWithImpl<_$RegexRuleEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegexRuleEntityImplToJson(
      this,
    );
  }
}

abstract class _RegexRuleEntity extends RegexRuleEntity {
  const factory _RegexRuleEntity(
      {required final String id,
      required final String name,
      required final String pattern,
      final String actionType,
      final int priority,
      final String? subscriptionId,
      final bool isEnabled}) = _$RegexRuleEntityImpl;
  const _RegexRuleEntity._() : super._();

  factory _RegexRuleEntity.fromJson(Map<String, dynamic> json) =
      _$RegexRuleEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get pattern;
  @override
  String get actionType;
  @override
  int get priority;
  @override
  String? get subscriptionId;
  @override
  bool get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$RegexRuleEntityImplCopyWith<_$RegexRuleEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
