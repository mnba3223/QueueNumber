// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) {
  return _Configuration.fromJson(json);
}

/// @nodoc
mixin _$Configuration {
  int get id => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  String get categoryRange => throw _privateConstructorUsedError;
  String get queueStatus => throw _privateConstructorUsedError;
  int get waitTime => throw _privateConstructorUsedError;
  int get multiGroupWaitTime => throw _privateConstructorUsedError;
  bool get hasRange => throw _privateConstructorUsedError;
  String get queueName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigurationCopyWith<Configuration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigurationCopyWith<$Res> {
  factory $ConfigurationCopyWith(
          Configuration value, $Res Function(Configuration) then) =
      _$ConfigurationCopyWithImpl<$Res, Configuration>;
  @useResult
  $Res call(
      {int id,
      String categoryName,
      String categoryRange,
      String queueStatus,
      int waitTime,
      int multiGroupWaitTime,
      bool hasRange,
      String queueName});
}

/// @nodoc
class _$ConfigurationCopyWithImpl<$Res, $Val extends Configuration>
    implements $ConfigurationCopyWith<$Res> {
  _$ConfigurationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryName = null,
    Object? categoryRange = null,
    Object? queueStatus = null,
    Object? waitTime = null,
    Object? multiGroupWaitTime = null,
    Object? hasRange = null,
    Object? queueName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryRange: null == categoryRange
          ? _value.categoryRange
          : categoryRange // ignore: cast_nullable_to_non_nullable
              as String,
      queueStatus: null == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as String,
      waitTime: null == waitTime
          ? _value.waitTime
          : waitTime // ignore: cast_nullable_to_non_nullable
              as int,
      multiGroupWaitTime: null == multiGroupWaitTime
          ? _value.multiGroupWaitTime
          : multiGroupWaitTime // ignore: cast_nullable_to_non_nullable
              as int,
      hasRange: null == hasRange
          ? _value.hasRange
          : hasRange // ignore: cast_nullable_to_non_nullable
              as bool,
      queueName: null == queueName
          ? _value.queueName
          : queueName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigurationImplCopyWith<$Res>
    implements $ConfigurationCopyWith<$Res> {
  factory _$$ConfigurationImplCopyWith(
          _$ConfigurationImpl value, $Res Function(_$ConfigurationImpl) then) =
      __$$ConfigurationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String categoryName,
      String categoryRange,
      String queueStatus,
      int waitTime,
      int multiGroupWaitTime,
      bool hasRange,
      String queueName});
}

/// @nodoc
class __$$ConfigurationImplCopyWithImpl<$Res>
    extends _$ConfigurationCopyWithImpl<$Res, _$ConfigurationImpl>
    implements _$$ConfigurationImplCopyWith<$Res> {
  __$$ConfigurationImplCopyWithImpl(
      _$ConfigurationImpl _value, $Res Function(_$ConfigurationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryName = null,
    Object? categoryRange = null,
    Object? queueStatus = null,
    Object? waitTime = null,
    Object? multiGroupWaitTime = null,
    Object? hasRange = null,
    Object? queueName = null,
  }) {
    return _then(_$ConfigurationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryRange: null == categoryRange
          ? _value.categoryRange
          : categoryRange // ignore: cast_nullable_to_non_nullable
              as String,
      queueStatus: null == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as String,
      waitTime: null == waitTime
          ? _value.waitTime
          : waitTime // ignore: cast_nullable_to_non_nullable
              as int,
      multiGroupWaitTime: null == multiGroupWaitTime
          ? _value.multiGroupWaitTime
          : multiGroupWaitTime // ignore: cast_nullable_to_non_nullable
              as int,
      hasRange: null == hasRange
          ? _value.hasRange
          : hasRange // ignore: cast_nullable_to_non_nullable
              as bool,
      queueName: null == queueName
          ? _value.queueName
          : queueName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigurationImpl implements _Configuration {
  const _$ConfigurationImpl(
      {required this.id,
      required this.categoryName,
      required this.categoryRange,
      required this.queueStatus,
      required this.waitTime,
      required this.multiGroupWaitTime,
      required this.hasRange,
      required this.queueName});

  factory _$ConfigurationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigurationImplFromJson(json);

  @override
  final int id;
  @override
  final String categoryName;
  @override
  final String categoryRange;
  @override
  final String queueStatus;
  @override
  final int waitTime;
  @override
  final int multiGroupWaitTime;
  @override
  final bool hasRange;
  @override
  final String queueName;

  @override
  String toString() {
    return 'Configuration(id: $id, categoryName: $categoryName, categoryRange: $categoryRange, queueStatus: $queueStatus, waitTime: $waitTime, multiGroupWaitTime: $multiGroupWaitTime, hasRange: $hasRange, queueName: $queueName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigurationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryRange, categoryRange) ||
                other.categoryRange == categoryRange) &&
            (identical(other.queueStatus, queueStatus) ||
                other.queueStatus == queueStatus) &&
            (identical(other.waitTime, waitTime) ||
                other.waitTime == waitTime) &&
            (identical(other.multiGroupWaitTime, multiGroupWaitTime) ||
                other.multiGroupWaitTime == multiGroupWaitTime) &&
            (identical(other.hasRange, hasRange) ||
                other.hasRange == hasRange) &&
            (identical(other.queueName, queueName) ||
                other.queueName == queueName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, categoryName, categoryRange,
      queueStatus, waitTime, multiGroupWaitTime, hasRange, queueName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigurationImplCopyWith<_$ConfigurationImpl> get copyWith =>
      __$$ConfigurationImplCopyWithImpl<_$ConfigurationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigurationImplToJson(
      this,
    );
  }
}

abstract class _Configuration implements Configuration {
  const factory _Configuration(
      {required final int id,
      required final String categoryName,
      required final String categoryRange,
      required final String queueStatus,
      required final int waitTime,
      required final int multiGroupWaitTime,
      required final bool hasRange,
      required final String queueName}) = _$ConfigurationImpl;

  factory _Configuration.fromJson(Map<String, dynamic> json) =
      _$ConfigurationImpl.fromJson;

  @override
  int get id;
  @override
  String get categoryName;
  @override
  String get categoryRange;
  @override
  String get queueStatus;
  @override
  int get waitTime;
  @override
  int get multiGroupWaitTime;
  @override
  bool get hasRange;
  @override
  String get queueName;
  @override
  @JsonKey(ignore: true)
  _$$ConfigurationImplCopyWith<_$ConfigurationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
