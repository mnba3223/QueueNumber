// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Store_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoreImpl _$$StoreImplFromJson(Map<String, dynamic> json) => _$StoreImpl(
      id: (json['id'] as num).toInt(),
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      contactUser: json['contactUser'] as String?,
      contactEmail: json['contactEmail'] as String?,
      contactPhone: json['contactPhone'] as String?,
      storeAdd: json['storeAdd'] as String?,
      openingTime: json['openingTime'] as String?,
      resetQueueNumberTime: json['resetQueueNumberTime'] as String?,
      webGetNumber: json['webGetNumber'] as String?,
      numberOfPeople: json['numberOfPeople'] as String?,
      useNotepad: json['useNotepad'] as String?,
      adultsAndChildren: json['adultsAndChildren'] as String?,
      autoTakeNumber: json['autoTakeNumber'] as String?,
      extendedMode: json['extendedMode'] as String?,
      cuttingInLine: json['cuttingInLine'] as String?,
      stopTakingNumbers: json['stopTakingNumbers'] as String?,
      frontEndClosed: json['frontEndClosed'] as String?,
      notifyTheReceptionist: json['notifyTheReceptionist'] as String?,
      notifyCustomerCancellation: json['notifyCustomerCancellation'] as String?,
      receptionSound: json['receptionSound'] as String?,
      screenSaver: json['screenSaver'] as String?,
      queueResetTime: json['queueResetTime'] as String?,
      skipConfirmationScreen: json['skipConfirmationScreen'] as String?,
      showWaitingAlerts: json['showWaitingAlerts'] as String?,
      queueTimeSettingAll: json['queueTimeSettingAll'] as String?,
      showGroupsOrPeople: json['showGroupsOrPeople'] as String?,
      useNoCallToCalculate: json['useNoCallToCalculate'] as String?,
      highlightOverTime: (json['highlightOverTime'] as num?)?.toInt(),
      queueTimeSettingAllWaitingTime:
          (json['queueTimeSettingAllWaitingTime'] as num?)?.toInt(),
      queueTimeSettingAllIntervalTime:
          (json['queueTimeSettingAllIntervalTime'] as num?)?.toInt(),
      allWaitingTimeDisplayed: json['allWaitingTimeDisplayed'] as String?,
      businessHoursTime: json['businessHoursTime'] as String?,
      showWaitingTime: json['showWaitingTime'] as String?,
    );

Map<String, dynamic> _$$StoreImplToJson(_$StoreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'contactUser': instance.contactUser,
      'contactEmail': instance.contactEmail,
      'contactPhone': instance.contactPhone,
      'storeAdd': instance.storeAdd,
      'openingTime': instance.openingTime,
      'resetQueueNumberTime': instance.resetQueueNumberTime,
      'webGetNumber': instance.webGetNumber,
      'numberOfPeople': instance.numberOfPeople,
      'useNotepad': instance.useNotepad,
      'adultsAndChildren': instance.adultsAndChildren,
      'autoTakeNumber': instance.autoTakeNumber,
      'extendedMode': instance.extendedMode,
      'cuttingInLine': instance.cuttingInLine,
      'stopTakingNumbers': instance.stopTakingNumbers,
      'frontEndClosed': instance.frontEndClosed,
      'notifyTheReceptionist': instance.notifyTheReceptionist,
      'notifyCustomerCancellation': instance.notifyCustomerCancellation,
      'receptionSound': instance.receptionSound,
      'screenSaver': instance.screenSaver,
      'queueResetTime': instance.queueResetTime,
      'skipConfirmationScreen': instance.skipConfirmationScreen,
      'showWaitingAlerts': instance.showWaitingAlerts,
      'queueTimeSettingAll': instance.queueTimeSettingAll,
      'showGroupsOrPeople': instance.showGroupsOrPeople,
      'useNoCallToCalculate': instance.useNoCallToCalculate,
      'highlightOverTime': instance.highlightOverTime,
      'queueTimeSettingAllWaitingTime': instance.queueTimeSettingAllWaitingTime,
      'queueTimeSettingAllIntervalTime':
          instance.queueTimeSettingAllIntervalTime,
      'allWaitingTimeDisplayed': instance.allWaitingTimeDisplayed,
      'businessHoursTime': instance.businessHoursTime,
      'showWaitingTime': instance.showWaitingTime,
    };
