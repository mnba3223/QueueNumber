// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Customer_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
mixin _$Customer {
  int get id => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String get queueNum => throw _privateConstructorUsedError;
  String get checkinType => throw _privateConstructorUsedError;
  String get storeId => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String get checkTime => throw _privateConstructorUsedError;
  int? get queueType => throw _privateConstructorUsedError;
  int? get numberOfPeople => throw _privateConstructorUsedError;
  int? get numberOfChild => throw _privateConstructorUsedError;
  String? get queueNumTitle => throw _privateConstructorUsedError;
  int? get currentSort => throw _privateConstructorUsedError;
  String? get callingTime => throw _privateConstructorUsedError;
  String? get callingStatus => throw _privateConstructorUsedError;
  String get queueStatus => throw _privateConstructorUsedError;
  String? get needs => throw _privateConstructorUsedError;
  String get queueTypeName => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool? get notifyNewCustomer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res, Customer>;
  @useResult
  $Res call(
      {int id,
      String number,
      String queueNum,
      String checkinType,
      String storeId,
      String time,
      String checkTime,
      int? queueType,
      int? numberOfPeople,
      int? numberOfChild,
      String? queueNumTitle,
      int? currentSort,
      String? callingTime,
      String? callingStatus,
      String queueStatus,
      String? needs,
      String queueTypeName,
      @JsonKey(ignore: true) bool? notifyNewCustomer});
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res, $Val extends Customer>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? queueNum = null,
    Object? checkinType = null,
    Object? storeId = null,
    Object? time = null,
    Object? checkTime = null,
    Object? queueType = freezed,
    Object? numberOfPeople = freezed,
    Object? numberOfChild = freezed,
    Object? queueNumTitle = freezed,
    Object? currentSort = freezed,
    Object? callingTime = freezed,
    Object? callingStatus = freezed,
    Object? queueStatus = null,
    Object? needs = freezed,
    Object? queueTypeName = null,
    Object? notifyNewCustomer = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      queueNum: null == queueNum
          ? _value.queueNum
          : queueNum // ignore: cast_nullable_to_non_nullable
              as String,
      checkinType: null == checkinType
          ? _value.checkinType
          : checkinType // ignore: cast_nullable_to_non_nullable
              as String,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      checkTime: null == checkTime
          ? _value.checkTime
          : checkTime // ignore: cast_nullable_to_non_nullable
              as String,
      queueType: freezed == queueType
          ? _value.queueType
          : queueType // ignore: cast_nullable_to_non_nullable
              as int?,
      numberOfPeople: freezed == numberOfPeople
          ? _value.numberOfPeople
          : numberOfPeople // ignore: cast_nullable_to_non_nullable
              as int?,
      numberOfChild: freezed == numberOfChild
          ? _value.numberOfChild
          : numberOfChild // ignore: cast_nullable_to_non_nullable
              as int?,
      queueNumTitle: freezed == queueNumTitle
          ? _value.queueNumTitle
          : queueNumTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      currentSort: freezed == currentSort
          ? _value.currentSort
          : currentSort // ignore: cast_nullable_to_non_nullable
              as int?,
      callingTime: freezed == callingTime
          ? _value.callingTime
          : callingTime // ignore: cast_nullable_to_non_nullable
              as String?,
      callingStatus: freezed == callingStatus
          ? _value.callingStatus
          : callingStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      queueStatus: null == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as String,
      needs: freezed == needs
          ? _value.needs
          : needs // ignore: cast_nullable_to_non_nullable
              as String?,
      queueTypeName: null == queueTypeName
          ? _value.queueTypeName
          : queueTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      notifyNewCustomer: freezed == notifyNewCustomer
          ? _value.notifyNewCustomer
          : notifyNewCustomer // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerImplCopyWith<$Res>
    implements $CustomerCopyWith<$Res> {
  factory _$$CustomerImplCopyWith(
          _$CustomerImpl value, $Res Function(_$CustomerImpl) then) =
      __$$CustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String number,
      String queueNum,
      String checkinType,
      String storeId,
      String time,
      String checkTime,
      int? queueType,
      int? numberOfPeople,
      int? numberOfChild,
      String? queueNumTitle,
      int? currentSort,
      String? callingTime,
      String? callingStatus,
      String queueStatus,
      String? needs,
      String queueTypeName,
      @JsonKey(ignore: true) bool? notifyNewCustomer});
}

/// @nodoc
class __$$CustomerImplCopyWithImpl<$Res>
    extends _$CustomerCopyWithImpl<$Res, _$CustomerImpl>
    implements _$$CustomerImplCopyWith<$Res> {
  __$$CustomerImplCopyWithImpl(
      _$CustomerImpl _value, $Res Function(_$CustomerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? queueNum = null,
    Object? checkinType = null,
    Object? storeId = null,
    Object? time = null,
    Object? checkTime = null,
    Object? queueType = freezed,
    Object? numberOfPeople = freezed,
    Object? numberOfChild = freezed,
    Object? queueNumTitle = freezed,
    Object? currentSort = freezed,
    Object? callingTime = freezed,
    Object? callingStatus = freezed,
    Object? queueStatus = null,
    Object? needs = freezed,
    Object? queueTypeName = null,
    Object? notifyNewCustomer = freezed,
  }) {
    return _then(_$CustomerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      queueNum: null == queueNum
          ? _value.queueNum
          : queueNum // ignore: cast_nullable_to_non_nullable
              as String,
      checkinType: null == checkinType
          ? _value.checkinType
          : checkinType // ignore: cast_nullable_to_non_nullable
              as String,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      checkTime: null == checkTime
          ? _value.checkTime
          : checkTime // ignore: cast_nullable_to_non_nullable
              as String,
      queueType: freezed == queueType
          ? _value.queueType
          : queueType // ignore: cast_nullable_to_non_nullable
              as int?,
      numberOfPeople: freezed == numberOfPeople
          ? _value.numberOfPeople
          : numberOfPeople // ignore: cast_nullable_to_non_nullable
              as int?,
      numberOfChild: freezed == numberOfChild
          ? _value.numberOfChild
          : numberOfChild // ignore: cast_nullable_to_non_nullable
              as int?,
      queueNumTitle: freezed == queueNumTitle
          ? _value.queueNumTitle
          : queueNumTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      currentSort: freezed == currentSort
          ? _value.currentSort
          : currentSort // ignore: cast_nullable_to_non_nullable
              as int?,
      callingTime: freezed == callingTime
          ? _value.callingTime
          : callingTime // ignore: cast_nullable_to_non_nullable
              as String?,
      callingStatus: freezed == callingStatus
          ? _value.callingStatus
          : callingStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      queueStatus: null == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as String,
      needs: freezed == needs
          ? _value.needs
          : needs // ignore: cast_nullable_to_non_nullable
              as String?,
      queueTypeName: null == queueTypeName
          ? _value.queueTypeName
          : queueTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      notifyNewCustomer: freezed == notifyNewCustomer
          ? _value.notifyNewCustomer
          : notifyNewCustomer // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerImpl extends _Customer {
  const _$CustomerImpl(
      {required this.id,
      required this.number,
      required this.queueNum,
      required this.checkinType,
      required this.storeId,
      required this.time,
      required this.checkTime,
      required this.queueType,
      this.numberOfPeople,
      this.numberOfChild,
      this.queueNumTitle,
      this.currentSort,
      this.callingTime,
      this.callingStatus,
      required this.queueStatus,
      this.needs,
      required this.queueTypeName,
      @JsonKey(ignore: true) this.notifyNewCustomer})
      : super._();

  factory _$CustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerImplFromJson(json);

  @override
  final int id;
  @override
  final String number;
  @override
  final String queueNum;
  @override
  final String checkinType;
  @override
  final String storeId;
  @override
  final String time;
  @override
  final String checkTime;
  @override
  final int? queueType;
  @override
  final int? numberOfPeople;
  @override
  final int? numberOfChild;
  @override
  final String? queueNumTitle;
  @override
  final int? currentSort;
  @override
  final String? callingTime;
  @override
  final String? callingStatus;
  @override
  final String queueStatus;
  @override
  final String? needs;
  @override
  final String queueTypeName;
  @override
  @JsonKey(ignore: true)
  final bool? notifyNewCustomer;

  @override
  String toString() {
    return 'Customer(id: $id, number: $number, queueNum: $queueNum, checkinType: $checkinType, storeId: $storeId, time: $time, checkTime: $checkTime, queueType: $queueType, numberOfPeople: $numberOfPeople, numberOfChild: $numberOfChild, queueNumTitle: $queueNumTitle, currentSort: $currentSort, callingTime: $callingTime, callingStatus: $callingStatus, queueStatus: $queueStatus, needs: $needs, queueTypeName: $queueTypeName, notifyNewCustomer: $notifyNewCustomer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.queueNum, queueNum) ||
                other.queueNum == queueNum) &&
            (identical(other.checkinType, checkinType) ||
                other.checkinType == checkinType) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.checkTime, checkTime) ||
                other.checkTime == checkTime) &&
            (identical(other.queueType, queueType) ||
                other.queueType == queueType) &&
            (identical(other.numberOfPeople, numberOfPeople) ||
                other.numberOfPeople == numberOfPeople) &&
            (identical(other.numberOfChild, numberOfChild) ||
                other.numberOfChild == numberOfChild) &&
            (identical(other.queueNumTitle, queueNumTitle) ||
                other.queueNumTitle == queueNumTitle) &&
            (identical(other.currentSort, currentSort) ||
                other.currentSort == currentSort) &&
            (identical(other.callingTime, callingTime) ||
                other.callingTime == callingTime) &&
            (identical(other.callingStatus, callingStatus) ||
                other.callingStatus == callingStatus) &&
            (identical(other.queueStatus, queueStatus) ||
                other.queueStatus == queueStatus) &&
            (identical(other.needs, needs) || other.needs == needs) &&
            (identical(other.queueTypeName, queueTypeName) ||
                other.queueTypeName == queueTypeName) &&
            (identical(other.notifyNewCustomer, notifyNewCustomer) ||
                other.notifyNewCustomer == notifyNewCustomer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      number,
      queueNum,
      checkinType,
      storeId,
      time,
      checkTime,
      queueType,
      numberOfPeople,
      numberOfChild,
      queueNumTitle,
      currentSort,
      callingTime,
      callingStatus,
      queueStatus,
      needs,
      queueTypeName,
      notifyNewCustomer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      __$$CustomerImplCopyWithImpl<_$CustomerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerImplToJson(
      this,
    );
  }
}

abstract class _Customer extends Customer {
  const factory _Customer(
      {required final int id,
      required final String number,
      required final String queueNum,
      required final String checkinType,
      required final String storeId,
      required final String time,
      required final String checkTime,
      required final int? queueType,
      final int? numberOfPeople,
      final int? numberOfChild,
      final String? queueNumTitle,
      final int? currentSort,
      final String? callingTime,
      final String? callingStatus,
      required final String queueStatus,
      final String? needs,
      required final String queueTypeName,
      @JsonKey(ignore: true) final bool? notifyNewCustomer}) = _$CustomerImpl;
  const _Customer._() : super._();

  factory _Customer.fromJson(Map<String, dynamic> json) =
      _$CustomerImpl.fromJson;

  @override
  int get id;
  @override
  String get number;
  @override
  String get queueNum;
  @override
  String get checkinType;
  @override
  String get storeId;
  @override
  String get time;
  @override
  String get checkTime;
  @override
  int? get queueType;
  @override
  int? get numberOfPeople;
  @override
  int? get numberOfChild;
  @override
  String? get queueNumTitle;
  @override
  int? get currentSort;
  @override
  String? get callingTime;
  @override
  String? get callingStatus;
  @override
  String get queueStatus;
  @override
  String? get needs;
  @override
  String get queueTypeName;
  @override
  @JsonKey(ignore: true)
  bool? get notifyNewCustomer;
  @override
  @JsonKey(ignore: true)
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
