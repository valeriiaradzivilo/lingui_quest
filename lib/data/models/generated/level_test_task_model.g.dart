// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../level_test_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelTestTaskModel _$LevelTestTaskModelFromJson(Map<String, dynamic> json) =>
    LevelTestTaskModel(
      creatorId: json['creator_id'] as String,
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswerIds: (json['correct_answer_ids'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      level: json['level'] as String,
      isVerified: json['is_verified'] as bool? ?? true,
    );

Map<String, dynamic> _$LevelTestTaskModelToJson(LevelTestTaskModel instance) =>
    <String, dynamic>{
      'creator_id': instance.creatorId,
      'question': instance.question,
      'options': instance.options,
      'correct_answer_ids': instance.correctAnswerIds,
      'level': instance.level,
      'is_verified': instance.isVerified,
    };
