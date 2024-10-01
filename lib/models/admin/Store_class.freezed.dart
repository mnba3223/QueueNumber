// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Store_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Store _$StoreFromJson(Map<String, dynamic> json) {
  return _Store.fromJson(json);
}

/// @nodoc
mixin _$Store {
  int get id => throw _privateConstructorUsedError;

  ///ID
  String get storeId => throw _privateConstructorUsedError;

  ///店鋪名稱
  String get storeName => throw _privateConstructorUsedError;

  ///通知使用者
  String? get contactUser => throw _privateConstructorUsedError;

  ///聯絡信箱
  String? get contactEmail => throw _privateConstructorUsedError;

  ///聯絡電話
  String? get contactPhone => throw _privateConstructorUsedError;

  ///店鋪地址
  String? get storeAdd => throw _privateConstructorUsedError;

  ///開始時間
  String? get openingTime => throw _privateConstructorUsedError;

  ///重置排隊編號時間
  String? get resetQueueNumberTime => throw _privateConstructorUsedError;

  ///網路取號
  String? get webGetNumber => throw _privateConstructorUsedError;

  ///人數
  String? get numberOfPeople => throw _privateConstructorUsedError;

  ///使用筆記
  String? get useNotepad => throw _privateConstructorUsedError;

  ///成人和兒童
  String? get adultsAndChildren => throw _privateConstructorUsedError;

  ///自動取號
  String? get autoTakeNumber => throw _privateConstructorUsedError;

  ///延長模式
  String? get extendedMode => throw _privateConstructorUsedError;

  ///差對
  String? get cuttingInLine => throw _privateConstructorUsedError;

  ///停止排隊 或者關店的意思
  String? get stopTakingNumbers => throw _privateConstructorUsedError;

  ///前端關閉 停止一切東西?
  String? get frontEndClosed => throw _privateConstructorUsedError;

  ///通知接待員
  String? get notifyTheReceptionist => throw _privateConstructorUsedError;

  ///通知客戶取消
  String? get notifyCustomerCancellation => throw _privateConstructorUsedError;

  ///接待聲音
  String? get receptionSound => throw _privateConstructorUsedError;

  ///等待螢幕畫面
  String? get screenSaver => throw _privateConstructorUsedError;

  ///排隊重置時間
  String? get queueResetTime => throw _privateConstructorUsedError;

  /// 跳過確認頁面
  String? get skipConfirmationScreen => throw _privateConstructorUsedError;

  ///顯示排隊警告
  String? get showWaitingAlerts => throw _privateConstructorUsedError;

  ///排隊時間
  String? get queueTimeSettingAll => throw _privateConstructorUsedError;

  ///顯示組數或人數開關
  String? get showGroupsOrPeople => throw _privateConstructorUsedError;

  ///Y的話僅計算未呼叫人數
// @JsonKey(fromJson: _stringToBool, toJson: _boolToString)
  String? get useNoCallToCalculate => throw _privateConstructorUsedError;
  int? get highlightOverTime => throw _privateConstructorUsedError;

  ///排隊時間
  int? get queueTimeSettingAllWaitingTime => throw _privateConstructorUsedError;
  int? get queueTimeSettingAllIntervalTime =>
      throw _privateConstructorUsedError;

  /// action  "'earliest','last','total'" 顯示組數或人數
  String? get allWaitingTimeDisplayed => throw _privateConstructorUsedError;

  ///等待時間
  String? get businessHoursTime => throw _privateConstructorUsedError;

  ///顯示等待時間
  String? get showWaitingTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoreCopyWith<Store> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreCopyWith<$Res> {
  factory $StoreCopyWith(Store value, $Res Function(Store) then) =
      _$StoreCopyWithImpl<$Res, Store>;
  @useResult
  $Res call(
      {int id,
      String storeId,
      String storeName,
      String? contactUser,
      String? contactEmail,
      String? contactPhone,
      String? storeAdd,
      String? openingTime,
      String? resetQueueNumberTime,
      String? webGetNumber,
      String? numberOfPeople,
      String? useNotepad,
      String? adultsAndChildren,
      String? autoTakeNumber,
      String? extendedMode,
      String? cuttingInLine,
      String? stopTakingNumbers,
      String? frontEndClosed,
      String? notifyTheReceptionist,
      String? notifyCustomerCancellation,
      String? receptionSound,
      String? screenSaver,
      String? queueResetTime,
      String? skipConfirmationScreen,
      String? showWaitingAlerts,
      String? queueTimeSettingAll,
      String? showGroupsOrPeople,
      String? useNoCallToCalculate,
      int? highlightOverTime,
      int? queueTimeSettingAllWaitingTime,
      int? queueTimeSettingAllIntervalTime,
      String? allWaitingTimeDisplayed,
      String? businessHoursTime,
      String? showWaitingTime});
}

/// @nodoc
class _$StoreCopyWithImpl<$Res, $Val extends Store>
    implements $StoreCopyWith<$Res> {
  _$StoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? storeName = null,
    Object? contactUser = freezed,
    Object? contactEmail = freezed,
    Object? contactPhone = freezed,
    Object? storeAdd = freezed,
    Object? openingTime = freezed,
    Object? resetQueueNumberTime = freezed,
    Object? webGetNumber = freezed,
    Object? numberOfPeople = freezed,
    Object? useNotepad = freezed,
    Object? adultsAndChildren = freezed,
    Object? autoTakeNumber = freezed,
    Object? extendedMode = freezed,
    Object? cuttingInLine = freezed,
    Object? stopTakingNumbers = freezed,
    Object? frontEndClosed = freezed,
    Object? notifyTheReceptionist = freezed,
    Object? notifyCustomerCancellation = freezed,
    Object? receptionSound = freezed,
    Object? screenSaver = freezed,
    Object? queueResetTime = freezed,
    Object? skipConfirmationScreen = freezed,
    Object? showWaitingAlerts = freezed,
    Object? queueTimeSettingAll = freezed,
    Object? showGroupsOrPeople = freezed,
    Object? useNoCallToCalculate = freezed,
    Object? highlightOverTime = freezed,
    Object? queueTimeSettingAllWaitingTime = freezed,
    Object? queueTimeSettingAllIntervalTime = freezed,
    Object? allWaitingTimeDisplayed = freezed,
    Object? businessHoursTime = freezed,
    Object? showWaitingTime = freezed,
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
      storeName: null == storeName
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      contactUser: freezed == contactUser
          ? _value.contactUser
          : contactUser // ignore: cast_nullable_to_non_nullable
              as String?,
      contactEmail: freezed == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhone: freezed == contactPhone
          ? _value.contactPhone
          : contactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      storeAdd: freezed == storeAdd
          ? _value.storeAdd
          : storeAdd // ignore: cast_nullable_to_non_nullable
              as String?,
      openingTime: freezed == openingTime
          ? _value.openingTime
          : openingTime // ignore: cast_nullable_to_non_nullable
              as String?,
      resetQueueNumberTime: freezed == resetQueueNumberTime
          ? _value.resetQueueNumberTime
          : resetQueueNumberTime // ignore: cast_nullable_to_non_nullable
              as String?,
      webGetNumber: freezed == webGetNumber
          ? _value.webGetNumber
          : webGetNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfPeople: freezed == numberOfPeople
          ? _value.numberOfPeople
          : numberOfPeople // ignore: cast_nullable_to_non_nullable
              as String?,
      useNotepad: freezed == useNotepad
          ? _value.useNotepad
          : useNotepad // ignore: cast_nullable_to_non_nullable
              as String?,
      adultsAndChildren: freezed == adultsAndChildren
          ? _value.adultsAndChildren
          : adultsAndChildren // ignore: cast_nullable_to_non_nullable
              as String?,
      autoTakeNumber: freezed == autoTakeNumber
          ? _value.autoTakeNumber
          : autoTakeNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      extendedMode: freezed == extendedMode
          ? _value.extendedMode
          : extendedMode // ignore: cast_nullable_to_non_nullable
              as String?,
      cuttingInLine: freezed == cuttingInLine
          ? _value.cuttingInLine
          : cuttingInLine // ignore: cast_nullable_to_non_nullable
              as String?,
      stopTakingNumbers: freezed == stopTakingNumbers
          ? _value.stopTakingNumbers
          : stopTakingNumbers // ignore: cast_nullable_to_non_nullable
              as String?,
      frontEndClosed: freezed == frontEndClosed
          ? _value.frontEndClosed
          : frontEndClosed // ignore: cast_nullable_to_non_nullable
              as String?,
      notifyTheReceptionist: freezed == notifyTheReceptionist
          ? _value.notifyTheReceptionist
          : notifyTheReceptionist // ignore: cast_nullable_to_non_nullable
              as String?,
      notifyCustomerCancellation: freezed == notifyCustomerCancellation
          ? _value.notifyCustomerCancellation
          : notifyCustomerCancellation // ignore: cast_nullable_to_non_nullable
              as String?,
      receptionSound: freezed == receptionSound
          ? _value.receptionSound
          : receptionSound // ignore: cast_nullable_to_non_nullable
              as String?,
      screenSaver: freezed == screenSaver
          ? _value.screenSaver
          : screenSaver // ignore: cast_nullable_to_non_nullable
              as String?,
      queueResetTime: freezed == queueResetTime
          ? _value.queueResetTime
          : queueResetTime // ignore: cast_nullable_to_non_nullable
              as String?,
      skipConfirmationScreen: freezed == skipConfirmationScreen
          ? _value.skipConfirmationScreen
          : skipConfirmationScreen // ignore: cast_nullable_to_non_nullable
              as String?,
      showWaitingAlerts: freezed == showWaitingAlerts
          ? _value.showWaitingAlerts
          : showWaitingAlerts // ignore: cast_nullable_to_non_nullable
              as String?,
      queueTimeSettingAll: freezed == queueTimeSettingAll
          ? _value.queueTimeSettingAll
          : queueTimeSettingAll // ignore: cast_nullable_to_non_nullable
              as String?,
      showGroupsOrPeople: freezed == showGroupsOrPeople
          ? _value.showGroupsOrPeople
          : showGroupsOrPeople // ignore: cast_nullable_to_non_nullable
              as String?,
      useNoCallToCalculate: freezed == useNoCallToCalculate
          ? _value.useNoCallToCalculate
          : useNoCallToCalculate // ignore: cast_nullable_to_non_nullable
              as String?,
      highlightOverTime: freezed == highlightOverTime
          ? _value.highlightOverTime
          : highlightOverTime // ignore: cast_nullable_to_non_nullable
              as int?,
      queueTimeSettingAllWaitingTime: freezed == queueTimeSettingAllWaitingTime
          ? _value.queueTimeSettingAllWaitingTime
          : queueTimeSettingAllWaitingTime // ignore: cast_nullable_to_non_nullable
              as int?,
      queueTimeSettingAllIntervalTime: freezed ==
              queueTimeSettingAllIntervalTime
          ? _value.queueTimeSettingAllIntervalTime
          : queueTimeSettingAllIntervalTime // ignore: cast_nullable_to_non_nullable
              as int?,
      allWaitingTimeDisplayed: freezed == allWaitingTimeDisplayed
          ? _value.allWaitingTimeDisplayed
          : allWaitingTimeDisplayed // ignore: cast_nullable_to_non_nullable
              as String?,
      businessHoursTime: freezed == businessHoursTime
          ? _value.businessHoursTime
          : businessHoursTime // ignore: cast_nullable_to_non_nullable
              as String?,
      showWaitingTime: freezed == showWaitingTime
          ? _value.showWaitingTime
          : showWaitingTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoreImplCopyWith<$Res> implements $StoreCopyWith<$Res> {
  factory _$$StoreImplCopyWith(
          _$StoreImpl value, $Res Function(_$StoreImpl) then) =
      __$$StoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String storeId,
      String storeName,
      String? contactUser,
      String? contactEmail,
      String? contactPhone,
      String? storeAdd,
      String? openingTime,
      String? resetQueueNumberTime,
      String? webGetNumber,
      String? numberOfPeople,
      String? useNotepad,
      String? adultsAndChildren,
      String? autoTakeNumber,
      String? extendedMode,
      String? cuttingInLine,
      String? stopTakingNumbers,
      String? frontEndClosed,
      String? notifyTheReceptionist,
      String? notifyCustomerCancellation,
      String? receptionSound,
      String? screenSaver,
      String? queueResetTime,
      String? skipConfirmationScreen,
      String? showWaitingAlerts,
      String? queueTimeSettingAll,
      String? showGroupsOrPeople,
      String? useNoCallToCalculate,
      int? highlightOverTime,
      int? queueTimeSettingAllWaitingTime,
      int? queueTimeSettingAllIntervalTime,
      String? allWaitingTimeDisplayed,
      String? businessHoursTime,
      String? showWaitingTime});
}

/// @nodoc
class __$$StoreImplCopyWithImpl<$Res>
    extends _$StoreCopyWithImpl<$Res, _$StoreImpl>
    implements _$$StoreImplCopyWith<$Res> {
  __$$StoreImplCopyWithImpl(
      _$StoreImpl _value, $Res Function(_$StoreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? storeName = null,
    Object? contactUser = freezed,
    Object? contactEmail = freezed,
    Object? contactPhone = freezed,
    Object? storeAdd = freezed,
    Object? openingTime = freezed,
    Object? resetQueueNumberTime = freezed,
    Object? webGetNumber = freezed,
    Object? numberOfPeople = freezed,
    Object? useNotepad = freezed,
    Object? adultsAndChildren = freezed,
    Object? autoTakeNumber = freezed,
    Object? extendedMode = freezed,
    Object? cuttingInLine = freezed,
    Object? stopTakingNumbers = freezed,
    Object? frontEndClosed = freezed,
    Object? notifyTheReceptionist = freezed,
    Object? notifyCustomerCancellation = freezed,
    Object? receptionSound = freezed,
    Object? screenSaver = freezed,
    Object? queueResetTime = freezed,
    Object? skipConfirmationScreen = freezed,
    Object? showWaitingAlerts = freezed,
    Object? queueTimeSettingAll = freezed,
    Object? showGroupsOrPeople = freezed,
    Object? useNoCallToCalculate = freezed,
    Object? highlightOverTime = freezed,
    Object? queueTimeSettingAllWaitingTime = freezed,
    Object? queueTimeSettingAllIntervalTime = freezed,
    Object? allWaitingTimeDisplayed = freezed,
    Object? businessHoursTime = freezed,
    Object? showWaitingTime = freezed,
  }) {
    return _then(_$StoreImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String,
      storeName: null == storeName
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      contactUser: freezed == contactUser
          ? _value.contactUser
          : contactUser // ignore: cast_nullable_to_non_nullable
              as String?,
      contactEmail: freezed == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhone: freezed == contactPhone
          ? _value.contactPhone
          : contactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      storeAdd: freezed == storeAdd
          ? _value.storeAdd
          : storeAdd // ignore: cast_nullable_to_non_nullable
              as String?,
      openingTime: freezed == openingTime
          ? _value.openingTime
          : openingTime // ignore: cast_nullable_to_non_nullable
              as String?,
      resetQueueNumberTime: freezed == resetQueueNumberTime
          ? _value.resetQueueNumberTime
          : resetQueueNumberTime // ignore: cast_nullable_to_non_nullable
              as String?,
      webGetNumber: freezed == webGetNumber
          ? _value.webGetNumber
          : webGetNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfPeople: freezed == numberOfPeople
          ? _value.numberOfPeople
          : numberOfPeople // ignore: cast_nullable_to_non_nullable
              as String?,
      useNotepad: freezed == useNotepad
          ? _value.useNotepad
          : useNotepad // ignore: cast_nullable_to_non_nullable
              as String?,
      adultsAndChildren: freezed == adultsAndChildren
          ? _value.adultsAndChildren
          : adultsAndChildren // ignore: cast_nullable_to_non_nullable
              as String?,
      autoTakeNumber: freezed == autoTakeNumber
          ? _value.autoTakeNumber
          : autoTakeNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      extendedMode: freezed == extendedMode
          ? _value.extendedMode
          : extendedMode // ignore: cast_nullable_to_non_nullable
              as String?,
      cuttingInLine: freezed == cuttingInLine
          ? _value.cuttingInLine
          : cuttingInLine // ignore: cast_nullable_to_non_nullable
              as String?,
      stopTakingNumbers: freezed == stopTakingNumbers
          ? _value.stopTakingNumbers
          : stopTakingNumbers // ignore: cast_nullable_to_non_nullable
              as String?,
      frontEndClosed: freezed == frontEndClosed
          ? _value.frontEndClosed
          : frontEndClosed // ignore: cast_nullable_to_non_nullable
              as String?,
      notifyTheReceptionist: freezed == notifyTheReceptionist
          ? _value.notifyTheReceptionist
          : notifyTheReceptionist // ignore: cast_nullable_to_non_nullable
              as String?,
      notifyCustomerCancellation: freezed == notifyCustomerCancellation
          ? _value.notifyCustomerCancellation
          : notifyCustomerCancellation // ignore: cast_nullable_to_non_nullable
              as String?,
      receptionSound: freezed == receptionSound
          ? _value.receptionSound
          : receptionSound // ignore: cast_nullable_to_non_nullable
              as String?,
      screenSaver: freezed == screenSaver
          ? _value.screenSaver
          : screenSaver // ignore: cast_nullable_to_non_nullable
              as String?,
      queueResetTime: freezed == queueResetTime
          ? _value.queueResetTime
          : queueResetTime // ignore: cast_nullable_to_non_nullable
              as String?,
      skipConfirmationScreen: freezed == skipConfirmationScreen
          ? _value.skipConfirmationScreen
          : skipConfirmationScreen // ignore: cast_nullable_to_non_nullable
              as String?,
      showWaitingAlerts: freezed == showWaitingAlerts
          ? _value.showWaitingAlerts
          : showWaitingAlerts // ignore: cast_nullable_to_non_nullable
              as String?,
      queueTimeSettingAll: freezed == queueTimeSettingAll
          ? _value.queueTimeSettingAll
          : queueTimeSettingAll // ignore: cast_nullable_to_non_nullable
              as String?,
      showGroupsOrPeople: freezed == showGroupsOrPeople
          ? _value.showGroupsOrPeople
          : showGroupsOrPeople // ignore: cast_nullable_to_non_nullable
              as String?,
      useNoCallToCalculate: freezed == useNoCallToCalculate
          ? _value.useNoCallToCalculate
          : useNoCallToCalculate // ignore: cast_nullable_to_non_nullable
              as String?,
      highlightOverTime: freezed == highlightOverTime
          ? _value.highlightOverTime
          : highlightOverTime // ignore: cast_nullable_to_non_nullable
              as int?,
      queueTimeSettingAllWaitingTime: freezed == queueTimeSettingAllWaitingTime
          ? _value.queueTimeSettingAllWaitingTime
          : queueTimeSettingAllWaitingTime // ignore: cast_nullable_to_non_nullable
              as int?,
      queueTimeSettingAllIntervalTime: freezed ==
              queueTimeSettingAllIntervalTime
          ? _value.queueTimeSettingAllIntervalTime
          : queueTimeSettingAllIntervalTime // ignore: cast_nullable_to_non_nullable
              as int?,
      allWaitingTimeDisplayed: freezed == allWaitingTimeDisplayed
          ? _value.allWaitingTimeDisplayed
          : allWaitingTimeDisplayed // ignore: cast_nullable_to_non_nullable
              as String?,
      businessHoursTime: freezed == businessHoursTime
          ? _value.businessHoursTime
          : businessHoursTime // ignore: cast_nullable_to_non_nullable
              as String?,
      showWaitingTime: freezed == showWaitingTime
          ? _value.showWaitingTime
          : showWaitingTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreImpl implements _Store {
  const _$StoreImpl(
      {required this.id,
      required this.storeId,
      required this.storeName,
      this.contactUser,
      this.contactEmail,
      this.contactPhone,
      this.storeAdd,
      this.openingTime,
      this.resetQueueNumberTime,
      this.webGetNumber,
      this.numberOfPeople,
      this.useNotepad,
      this.adultsAndChildren,
      this.autoTakeNumber,
      this.extendedMode,
      this.cuttingInLine,
      this.stopTakingNumbers,
      this.frontEndClosed,
      this.notifyTheReceptionist,
      this.notifyCustomerCancellation,
      this.receptionSound,
      this.screenSaver,
      this.queueResetTime,
      this.skipConfirmationScreen,
      this.showWaitingAlerts,
      this.queueTimeSettingAll,
      this.showGroupsOrPeople,
      this.useNoCallToCalculate,
      this.highlightOverTime,
      this.queueTimeSettingAllWaitingTime,
      this.queueTimeSettingAllIntervalTime,
      this.allWaitingTimeDisplayed,
      this.businessHoursTime,
      this.showWaitingTime});

  factory _$StoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreImplFromJson(json);

  @override
  final int id;

  ///ID
  @override
  final String storeId;

  ///店鋪名稱
  @override
  final String storeName;

  ///通知使用者
  @override
  final String? contactUser;

  ///聯絡信箱
  @override
  final String? contactEmail;

  ///聯絡電話
  @override
  final String? contactPhone;

  ///店鋪地址
  @override
  final String? storeAdd;

  ///開始時間
  @override
  final String? openingTime;

  ///重置排隊編號時間
  @override
  final String? resetQueueNumberTime;

  ///網路取號
  @override
  final String? webGetNumber;

  ///人數
  @override
  final String? numberOfPeople;

  ///使用筆記
  @override
  final String? useNotepad;

  ///成人和兒童
  @override
  final String? adultsAndChildren;

  ///自動取號
  @override
  final String? autoTakeNumber;

  ///延長模式
  @override
  final String? extendedMode;

  ///差對
  @override
  final String? cuttingInLine;

  ///停止排隊 或者關店的意思
  @override
  final String? stopTakingNumbers;

  ///前端關閉 停止一切東西?
  @override
  final String? frontEndClosed;

  ///通知接待員
  @override
  final String? notifyTheReceptionist;

  ///通知客戶取消
  @override
  final String? notifyCustomerCancellation;

  ///接待聲音
  @override
  final String? receptionSound;

  ///等待螢幕畫面
  @override
  final String? screenSaver;

  ///排隊重置時間
  @override
  final String? queueResetTime;

  /// 跳過確認頁面
  @override
  final String? skipConfirmationScreen;

  ///顯示排隊警告
  @override
  final String? showWaitingAlerts;

  ///排隊時間
  @override
  final String? queueTimeSettingAll;

  ///顯示組數或人數開關
  @override
  final String? showGroupsOrPeople;

  ///Y的話僅計算未呼叫人數
// @JsonKey(fromJson: _stringToBool, toJson: _boolToString)
  @override
  final String? useNoCallToCalculate;
  @override
  final int? highlightOverTime;

  ///排隊時間
  @override
  final int? queueTimeSettingAllWaitingTime;
  @override
  final int? queueTimeSettingAllIntervalTime;

  /// action  "'earliest','last','total'" 顯示組數或人數
  @override
  final String? allWaitingTimeDisplayed;

  ///等待時間
  @override
  final String? businessHoursTime;

  ///顯示等待時間
  @override
  final String? showWaitingTime;

  @override
  String toString() {
    return 'Store(id: $id, storeId: $storeId, storeName: $storeName, contactUser: $contactUser, contactEmail: $contactEmail, contactPhone: $contactPhone, storeAdd: $storeAdd, openingTime: $openingTime, resetQueueNumberTime: $resetQueueNumberTime, webGetNumber: $webGetNumber, numberOfPeople: $numberOfPeople, useNotepad: $useNotepad, adultsAndChildren: $adultsAndChildren, autoTakeNumber: $autoTakeNumber, extendedMode: $extendedMode, cuttingInLine: $cuttingInLine, stopTakingNumbers: $stopTakingNumbers, frontEndClosed: $frontEndClosed, notifyTheReceptionist: $notifyTheReceptionist, notifyCustomerCancellation: $notifyCustomerCancellation, receptionSound: $receptionSound, screenSaver: $screenSaver, queueResetTime: $queueResetTime, skipConfirmationScreen: $skipConfirmationScreen, showWaitingAlerts: $showWaitingAlerts, queueTimeSettingAll: $queueTimeSettingAll, showGroupsOrPeople: $showGroupsOrPeople, useNoCallToCalculate: $useNoCallToCalculate, highlightOverTime: $highlightOverTime, queueTimeSettingAllWaitingTime: $queueTimeSettingAllWaitingTime, queueTimeSettingAllIntervalTime: $queueTimeSettingAllIntervalTime, allWaitingTimeDisplayed: $allWaitingTimeDisplayed, businessHoursTime: $businessHoursTime, showWaitingTime: $showWaitingTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.contactUser, contactUser) ||
                other.contactUser == contactUser) &&
            (identical(other.contactEmail, contactEmail) ||
                other.contactEmail == contactEmail) &&
            (identical(other.contactPhone, contactPhone) ||
                other.contactPhone == contactPhone) &&
            (identical(other.storeAdd, storeAdd) ||
                other.storeAdd == storeAdd) &&
            (identical(other.openingTime, openingTime) ||
                other.openingTime == openingTime) &&
            (identical(other.resetQueueNumberTime, resetQueueNumberTime) ||
                other.resetQueueNumberTime == resetQueueNumberTime) &&
            (identical(other.webGetNumber, webGetNumber) ||
                other.webGetNumber == webGetNumber) &&
            (identical(other.numberOfPeople, numberOfPeople) ||
                other.numberOfPeople == numberOfPeople) &&
            (identical(other.useNotepad, useNotepad) ||
                other.useNotepad == useNotepad) &&
            (identical(other.adultsAndChildren, adultsAndChildren) ||
                other.adultsAndChildren == adultsAndChildren) &&
            (identical(other.autoTakeNumber, autoTakeNumber) ||
                other.autoTakeNumber == autoTakeNumber) &&
            (identical(other.extendedMode, extendedMode) ||
                other.extendedMode == extendedMode) &&
            (identical(other.cuttingInLine, cuttingInLine) ||
                other.cuttingInLine == cuttingInLine) &&
            (identical(other.stopTakingNumbers, stopTakingNumbers) ||
                other.stopTakingNumbers == stopTakingNumbers) &&
            (identical(other.frontEndClosed, frontEndClosed) ||
                other.frontEndClosed == frontEndClosed) &&
            (identical(other.notifyTheReceptionist, notifyTheReceptionist) ||
                other.notifyTheReceptionist == notifyTheReceptionist) &&
            (identical(other.notifyCustomerCancellation, notifyCustomerCancellation) ||
                other.notifyCustomerCancellation ==
                    notifyCustomerCancellation) &&
            (identical(other.receptionSound, receptionSound) ||
                other.receptionSound == receptionSound) &&
            (identical(other.screenSaver, screenSaver) ||
                other.screenSaver == screenSaver) &&
            (identical(other.queueResetTime, queueResetTime) ||
                other.queueResetTime == queueResetTime) &&
            (identical(other.skipConfirmationScreen, skipConfirmationScreen) ||
                other.skipConfirmationScreen == skipConfirmationScreen) &&
            (identical(other.showWaitingAlerts, showWaitingAlerts) ||
                other.showWaitingAlerts == showWaitingAlerts) &&
            (identical(other.queueTimeSettingAll, queueTimeSettingAll) ||
                other.queueTimeSettingAll == queueTimeSettingAll) &&
            (identical(other.showGroupsOrPeople, showGroupsOrPeople) ||
                other.showGroupsOrPeople == showGroupsOrPeople) &&
            (identical(other.useNoCallToCalculate, useNoCallToCalculate) ||
                other.useNoCallToCalculate == useNoCallToCalculate) &&
            (identical(other.highlightOverTime, highlightOverTime) ||
                other.highlightOverTime == highlightOverTime) &&
            (identical(other.queueTimeSettingAllWaitingTime, queueTimeSettingAllWaitingTime) ||
                other.queueTimeSettingAllWaitingTime ==
                    queueTimeSettingAllWaitingTime) &&
            (identical(other.queueTimeSettingAllIntervalTime,
                    queueTimeSettingAllIntervalTime) ||
                other.queueTimeSettingAllIntervalTime ==
                    queueTimeSettingAllIntervalTime) &&
            (identical(
                    other.allWaitingTimeDisplayed, allWaitingTimeDisplayed) ||
                other.allWaitingTimeDisplayed == allWaitingTimeDisplayed) &&
            (identical(other.businessHoursTime, businessHoursTime) ||
                other.businessHoursTime == businessHoursTime) &&
            (identical(other.showWaitingTime, showWaitingTime) ||
                other.showWaitingTime == showWaitingTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        storeId,
        storeName,
        contactUser,
        contactEmail,
        contactPhone,
        storeAdd,
        openingTime,
        resetQueueNumberTime,
        webGetNumber,
        numberOfPeople,
        useNotepad,
        adultsAndChildren,
        autoTakeNumber,
        extendedMode,
        cuttingInLine,
        stopTakingNumbers,
        frontEndClosed,
        notifyTheReceptionist,
        notifyCustomerCancellation,
        receptionSound,
        screenSaver,
        queueResetTime,
        skipConfirmationScreen,
        showWaitingAlerts,
        queueTimeSettingAll,
        showGroupsOrPeople,
        useNoCallToCalculate,
        highlightOverTime,
        queueTimeSettingAllWaitingTime,
        queueTimeSettingAllIntervalTime,
        allWaitingTimeDisplayed,
        businessHoursTime,
        showWaitingTime
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreImplCopyWith<_$StoreImpl> get copyWith =>
      __$$StoreImplCopyWithImpl<_$StoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreImplToJson(
      this,
    );
  }
}

abstract class _Store implements Store {
  const factory _Store(
      {required final int id,
      required final String storeId,
      required final String storeName,
      final String? contactUser,
      final String? contactEmail,
      final String? contactPhone,
      final String? storeAdd,
      final String? openingTime,
      final String? resetQueueNumberTime,
      final String? webGetNumber,
      final String? numberOfPeople,
      final String? useNotepad,
      final String? adultsAndChildren,
      final String? autoTakeNumber,
      final String? extendedMode,
      final String? cuttingInLine,
      final String? stopTakingNumbers,
      final String? frontEndClosed,
      final String? notifyTheReceptionist,
      final String? notifyCustomerCancellation,
      final String? receptionSound,
      final String? screenSaver,
      final String? queueResetTime,
      final String? skipConfirmationScreen,
      final String? showWaitingAlerts,
      final String? queueTimeSettingAll,
      final String? showGroupsOrPeople,
      final String? useNoCallToCalculate,
      final int? highlightOverTime,
      final int? queueTimeSettingAllWaitingTime,
      final int? queueTimeSettingAllIntervalTime,
      final String? allWaitingTimeDisplayed,
      final String? businessHoursTime,
      final String? showWaitingTime}) = _$StoreImpl;

  factory _Store.fromJson(Map<String, dynamic> json) = _$StoreImpl.fromJson;

  @override
  int get id;
  @override

  ///ID
  String get storeId;
  @override

  ///店鋪名稱
  String get storeName;
  @override

  ///通知使用者
  String? get contactUser;
  @override

  ///聯絡信箱
  String? get contactEmail;
  @override

  ///聯絡電話
  String? get contactPhone;
  @override

  ///店鋪地址
  String? get storeAdd;
  @override

  ///開始時間
  String? get openingTime;
  @override

  ///重置排隊編號時間
  String? get resetQueueNumberTime;
  @override

  ///網路取號
  String? get webGetNumber;
  @override

  ///人數
  String? get numberOfPeople;
  @override

  ///使用筆記
  String? get useNotepad;
  @override

  ///成人和兒童
  String? get adultsAndChildren;
  @override

  ///自動取號
  String? get autoTakeNumber;
  @override

  ///延長模式
  String? get extendedMode;
  @override

  ///差對
  String? get cuttingInLine;
  @override

  ///停止排隊 或者關店的意思
  String? get stopTakingNumbers;
  @override

  ///前端關閉 停止一切東西?
  String? get frontEndClosed;
  @override

  ///通知接待員
  String? get notifyTheReceptionist;
  @override

  ///通知客戶取消
  String? get notifyCustomerCancellation;
  @override

  ///接待聲音
  String? get receptionSound;
  @override

  ///等待螢幕畫面
  String? get screenSaver;
  @override

  ///排隊重置時間
  String? get queueResetTime;
  @override

  /// 跳過確認頁面
  String? get skipConfirmationScreen;
  @override

  ///顯示排隊警告
  String? get showWaitingAlerts;
  @override

  ///排隊時間
  String? get queueTimeSettingAll;
  @override

  ///顯示組數或人數開關
  String? get showGroupsOrPeople;
  @override

  ///Y的話僅計算未呼叫人數
// @JsonKey(fromJson: _stringToBool, toJson: _boolToString)
  String? get useNoCallToCalculate;
  @override
  int? get highlightOverTime;
  @override

  ///排隊時間
  int? get queueTimeSettingAllWaitingTime;
  @override
  int? get queueTimeSettingAllIntervalTime;
  @override

  /// action  "'earliest','last','total'" 顯示組數或人數
  String? get allWaitingTimeDisplayed;
  @override

  ///等待時間
  String? get businessHoursTime;
  @override

  ///顯示等待時間
  String? get showWaitingTime;
  @override
  @JsonKey(ignore: true)
  _$$StoreImplCopyWith<_$StoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
