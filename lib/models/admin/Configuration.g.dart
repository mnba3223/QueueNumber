// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigurationImpl _$$ConfigurationImplFromJson(Map<String, dynamic> json) =>
    _$ConfigurationImpl(
      id: (json['id'] as num).toInt(),
      categoryName: json['categoryName'] as String,
      categoryRange: json['categoryRange'] as String,
      queueStatus: json['queueStatus'] as String,
      waitTime: (json['waitTime'] as num).toInt(),
      multiGroupWaitTime: (json['multiGroupWaitTime'] as num).toInt(),
      hasRange: json['hasRange'] as bool,
      queueName: json['queueName'] as String,
    );

Map<String, dynamic> _$$ConfigurationImplToJson(_$ConfigurationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'categoryRange': instance.categoryRange,
      'queueStatus': instance.queueStatus,
      'waitTime': instance.waitTime,
      'multiGroupWaitTime': instance.multiGroupWaitTime,
      'hasRange': instance.hasRange,
      'queueName': instance.queueName,
    };
