// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_text_screen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoreTextScreenResponseImpl _$$StoreTextScreenResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$StoreTextScreenResponseImpl(
      id: (json['id'] as num).toInt(),
      storeId: json['storeId'] as String,
      noOneQueuing: json['noOneQueuing'] as String,
      someOneQueuing: json['someOneQueuing'] as String,
      stopTakeNumber: json['stopTakeNumber'] as String,
      limitTakeNumber: json['limitTakeNumber'] as String,
    );

Map<String, dynamic> _$$StoreTextScreenResponseImplToJson(
        _$StoreTextScreenResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeId': instance.storeId,
      'noOneQueuing': instance.noOneQueuing,
      'someOneQueuing': instance.someOneQueuing,
      'stopTakeNumber': instance.stopTakeNumber,
      'limitTakeNumber': instance.limitTakeNumber,
    };
