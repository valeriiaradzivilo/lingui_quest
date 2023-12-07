// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../join_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JoinRequestModelImpl _$$JoinRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$JoinRequestModelImpl(
      groupId: json['group_id'] as String,
      userId: json['user_id'] as String,
      requestDate: fromTimestamp(json['request_date'] as Timestamp),
    );

Map<String, dynamic> _$$JoinRequestModelImplToJson(
        _$JoinRequestModelImpl instance) =>
    <String, dynamic>{
      'group_id': instance.groupId,
      'user_id': instance.userId,
      'request_date': Timestamp.fromDate(instance.requestDate),
    };
