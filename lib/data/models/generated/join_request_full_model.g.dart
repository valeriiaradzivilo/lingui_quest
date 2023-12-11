// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../join_request_full_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JoinRequestFullModelImpl _$$JoinRequestFullModelImplFromJson(
        Map<String, dynamic> json) =>
    _$JoinRequestFullModelImpl(
      group: GroupModel.fromJson(json['group'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      id: json['id'] as String,
      requestDate: fromTimestamp(json['request_date'] as Timestamp),
    );

Map<String, dynamic> _$$JoinRequestFullModelImplToJson(
        _$JoinRequestFullModelImpl instance) =>
    <String, dynamic>{
      'group': instance.group.toJson(),
      'user': instance.user.toJson(),
      'id': instance.id,
      'request_date': Timestamp.fromDate(instance.requestDate),
    };
