// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../level_test_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelTestTaskModel _$LevelTestTaskModelFromJson(Map<String, dynamic> json) =>
    LevelTestTaskModel(
      creatorId: json['creatorId'] as String,
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswerIds: (json['correctAnswerIds'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      level: json['level'] as String,
      isVerified: json['isVerified'] as bool? ?? true,
    );

Map<String, dynamic> _$LevelTestTaskModelToJson(LevelTestTaskModel instance) =>
    <String, dynamic>{
      'creatorId': instance.creatorId,
      'question': instance.question,
      'options': instance.options,
      'correctAnswerIds': instance.correctAnswerIds,
      'level': instance.level,
      'isVerified': instance.isVerified,
    };
