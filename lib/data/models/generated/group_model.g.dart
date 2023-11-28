// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupModelImpl _$$GroupModelImplFromJson(Map<String, dynamic> json) =>
    _$GroupModelImpl(
      creatorId: json['creator_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      code: json['code'] as String,
      students:
          (json['students'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$GroupModelImplToJson(_$GroupModelImpl instance) =>
    <String, dynamic>{
      'creator_id': instance.creatorId,
      'name': instance.name,
      'description': instance.description,
      'code': instance.code,
      'students': instance.students,
    };
