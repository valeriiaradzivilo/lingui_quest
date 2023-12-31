// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameModelImpl _$$GameModelImplFromJson(Map<String, dynamic> json) =>
    _$GameModelImpl(
      id: json['id'] as String,
      creatorId: json['creator_id'] as String,
      name: json['name'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      level: $enumDecode(_$EnglishLevelEnumMap, json['level']),
      theme: json['theme'] as String,
      description: json['description'] as String,
      time: json['time'] as int,
      groups:
          (json['groups'] as List<dynamic>).map((e) => e as String).toList(),
      rate: (json['rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$GameModelImplToJson(_$GameModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'name': instance.name,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'level': _$EnglishLevelEnumMap[instance.level]!,
      'theme': instance.theme,
      'description': instance.description,
      'time': instance.time,
      'groups': instance.groups,
      'rate': instance.rate,
    };

const _$EnglishLevelEnumMap = {
  EnglishLevel.a1: 'a1',
  EnglishLevel.a2: 'a2',
  EnglishLevel.b1: 'b1',
  EnglishLevel.b2: 'b2',
  EnglishLevel.c1: 'c1',
  EnglishLevel.c2: 'c2',
};
