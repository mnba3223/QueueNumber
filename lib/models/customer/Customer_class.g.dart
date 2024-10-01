// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Customer_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: (json['id'] as num).toInt(),
      number: json['number'] as String,
      queueNum: json['queueNum'] as String,
      checkinType: json['checkinType'] as String,
      storeId: json['storeId'] as String,
      time: json['time'] as String,
      checkTime: json['checkTime'] as String,
      queueType: (json['queueType'] as num?)?.toInt(),
      numberOfPeople: (json['numberOfPeople'] as num?)?.toInt(),
      numberOfChild: (json['numberOfChild'] as num?)?.toInt(),
      queueNumTitle: json['queueNumTitle'] as String?,
      currentSort: (json['currentSort'] as num?)?.toInt(),
      callingTime: json['callingTime'] as String?,
      callingStatus: json['callingStatus'] as String?,
      queueStatus: json['queueStatus'] as String,
      needs: json['needs'] as String?,
      queueTypeName: json['queueTypeName'] as String,
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'queueNum': instance.queueNum,
      'checkinType': instance.checkinType,
      'storeId': instance.storeId,
      'time': instance.time,
      'checkTime': instance.checkTime,
      'queueType': instance.queueType,
      'numberOfPeople': instance.numberOfPeople,
      'numberOfChild': instance.numberOfChild,
      'queueNumTitle': instance.queueNumTitle,
      'currentSort': instance.currentSort,
      'callingTime': instance.callingTime,
      'callingStatus': instance.callingStatus,
      'queueStatus': instance.queueStatus,
      'needs': instance.needs,
      'queueTypeName': instance.queueTypeName,
    };
