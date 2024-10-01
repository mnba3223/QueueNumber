// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category_Class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: (json['id'] as num).toInt(),
      storeId: json['storeId'] as String,
      queueType: (json['queueType'] as num).toInt(),
      queueTypeName: json['queueTypeName'] as String,
      queuePeopleMin: (json['queuePeopleMin'] as num).toInt(),
      queuePeopleMax: (json['queuePeopleMax'] as num).toInt(),
      queueNumTitle: json['queueNumTitle'] as String,
      defaultQueue: (json['defaultQueue'] as num).toInt(),
      waitingTime: (json['waitingTime'] as num).toInt(),
      intervalTime: (json['intervalTime'] as num).toInt(),
      hideQueue: _stringToBool(json['hideQueue'] as String),
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeId': instance.storeId,
      'queueType': instance.queueType,
      'queueTypeName': instance.queueTypeName,
      'queuePeopleMin': instance.queuePeopleMin,
      'queuePeopleMax': instance.queuePeopleMax,
      'queueNumTitle': instance.queueNumTitle,
      'defaultQueue': instance.defaultQueue,
      'waitingTime': instance.waitingTime,
      'intervalTime': instance.intervalTime,
      'hideQueue': _boolToString(instance.hideQueue),
    };
