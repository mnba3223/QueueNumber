// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      userid: (json['userid'] as num).toInt(),
      username: json['username'] as String,
      password: json['password'] as String?,
      type: (json['type'] as num?)?.toInt(),
      department: json['department'] as String?,
      fullname: json['fullname'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'userid': instance.userid,
      'username': instance.username,
      'password': instance.password,
      'type': instance.type,
      'department': instance.department,
      'fullname': instance.fullname,
    };
