// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_text_screen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoreTextScreenResponse _$StoreTextScreenResponseFromJson(
    Map<String, dynamic> json) {
  return _StoreTextScreenResponse.fromJson(json);
}

/// @nodoc
mixin _$StoreTextScreenResponse {
  int get id => throw _privateConstructorUsedError;
  String get storeId => throw _privateConstructorUsedError;
  String get noOneQueuing => throw _privateConstructorUsedError;
  String get someOneQueuing => throw _privateConstructorUsedError;
  String get stopTakeNumber => throw _privateConstructorUsedError;
  String get limitTakeNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoreTextScreenResponseCopyWith<StoreTextScreenResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreTextScreenResponseCopyWith<$Res> {
  factory $StoreTextScreenResponseCopyWith(StoreTextScreenResponse value,
          $Res Function(StoreTextScreenResponse) then) =
      _$StoreTextScreenResponseCopyWithImpl<$Res, StoreTextScreenResponse>;
  @useResult
  $Res call(
      {int id,
      String storeId,
      String noOneQueuing,
      String someOneQueuing,
      String stopTakeNumber,
      String limitTakeNumber});
}

/// @nodoc
class _$StoreTextScreenResponseCopyWithImpl<$Res,
        $Val extends StoreTextScreenResponse>
    implements $StoreTextScreenResponseCopyWith<$Res> {
  _$StoreTextScreenResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? noOneQueuing = null,
    Object? someOneQueuing = null,
    Object? stopTakeNumber = null,
    Object? limitTakeNumber = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String,
      noOneQueuing: null == noOneQueuing
          ? _value.noOneQueuing
          : noOneQueuing // ignore: cast_nullable_to_non_nullable
              as String,
      someOneQueuing: null == someOneQueuing
          ? _value.someOneQueuing
          : someOneQueuing // ignore: cast_nullable_to_non_nullable
              as String,
      stopTakeNumber: null == stopTakeNumber
          ? _value.stopTakeNumber
          : stopTakeNumber // ignore: cast_nullable_to_non_nullable
              as String,
      limitTakeNumber: null == limitTakeNumber
          ? _value.limitTakeNumber
          : limitTakeNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoreTextScreenResponseImplCopyWith<$Res>
    implements $StoreTextScreenResponseCopyWith<$Res> {
  factory _$$StoreTextScreenResponseImplCopyWith(
          _$StoreTextScreenResponseImpl value,
          $Res Function(_$StoreTextScreenResponseImpl) then) =
      __$$StoreTextScreenResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String storeId,
      String noOneQueuing,
      String someOneQueuing,
      String stopTakeNumber,
      String limitTakeNumber});
}

/// @nodoc
class __$$StoreTextScreenResponseImplCopyWithImpl<$Res>
    extends _$StoreTextScreenResponseCopyWithImpl<$Res,
        _$StoreTextScreenResponseImpl>
    implements _$$StoreTextScreenResponseImplCopyWith<$Res> {
  __$$StoreTextScreenResponseImplCopyWithImpl(
      _$StoreTextScreenResponseImpl _value,
      $Res Function(_$StoreTextScreenResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? noOneQueuing = null,
    Object? someOneQueuing = null,
    Object? stopTakeNumber = null,
    Object? limitTakeNumber = null,
  }) {
    return _then(_$StoreTextScreenResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String,
      noOneQueuing: null == noOneQueuing
          ? _value.noOneQueuing
          : noOneQueuing // ignore: cast_nullable_to_non_nullable
              as String,
      someOneQueuing: null == someOneQueuing
          ? _value.someOneQueuing
          : someOneQueuing // ignore: cast_nullable_to_non_nullable
              as String,
      stopTakeNumber: null == stopTakeNumber
          ? _value.stopTakeNumber
          : stopTakeNumber // ignore: cast_nullable_to_non_nullable
              as String,
      limitTakeNumber: null == limitTakeNumber
          ? _value.limitTakeNumber
          : limitTakeNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreTextScreenResponseImpl implements _StoreTextScreenResponse {
  _$StoreTextScreenResponseImpl(
      {required this.id,
      required this.storeId,
      required this.noOneQueuing,
      required this.someOneQueuing,
      required this.stopTakeNumber,
      required this.limitTakeNumber});

  factory _$StoreTextScreenResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreTextScreenResponseImplFromJson(json);

  @override
  final int id;
  @override
  final String storeId;
  @override
  final String noOneQueuing;
  @override
  final String someOneQueuing;
  @override
  final String stopTakeNumber;
  @override
  final String limitTakeNumber;

  @override
  String toString() {
    return 'StoreTextScreenResponse(id: $id, storeId: $storeId, noOneQueuing: $noOneQueuing, someOneQueuing: $someOneQueuing, stopTakeNumber: $stopTakeNumber, limitTakeNumber: $limitTakeNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreTextScreenResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.noOneQueuing, noOneQueuing) ||
                other.noOneQueuing == noOneQueuing) &&
            (identical(other.someOneQueuing, someOneQueuing) ||
                other.someOneQueuing == someOneQueuing) &&
            (identical(other.stopTakeNumber, stopTakeNumber) ||
                other.stopTakeNumber == stopTakeNumber) &&
            (identical(other.limitTakeNumber, limitTakeNumber) ||
                other.limitTakeNumber == limitTakeNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, storeId, noOneQueuing,
      someOneQueuing, stopTakeNumber, limitTakeNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreTextScreenResponseImplCopyWith<_$StoreTextScreenResponseImpl>
      get copyWith => __$$StoreTextScreenResponseImplCopyWithImpl<
          _$StoreTextScreenResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreTextScreenResponseImplToJson(
      this,
    );
  }
}

abstract class _StoreTextScreenResponse implements StoreTextScreenResponse {
  factory _StoreTextScreenResponse(
      {required final int id,
      required final String storeId,
      required final String noOneQueuing,
      required final String someOneQueuing,
      required final String stopTakeNumber,
      required final String limitTakeNumber}) = _$StoreTextScreenResponseImpl;

  factory _StoreTextScreenResponse.fromJson(Map<String, dynamic> json) =
      _$StoreTextScreenResponseImpl.fromJson;

  @override
  int get id;
  @override
  String get storeId;
  @override
  String get noOneQueuing;
  @override
  String get someOneQueuing;
  @override
  String get stopTakeNumber;
  @override
  String get limitTakeNumber;
  @override
  @JsonKey(ignore: true)
  _$$StoreTextScreenResponseImplCopyWith<_$StoreTextScreenResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
