// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestTaskModel _$TestTaskModelFromJson(Map<String, dynamic> json) =>
    TestTaskModel(
      json['creatorId'] as String,
      json['question'] as String,
      (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      (json['correctAnswerIds'] as List<dynamic>).map((e) => e as int).toList(),
      json['level'] as String,
    );

Map<String, dynamic> _$TestTaskModelToJson(TestTaskModel instance) =>
    <String, dynamic>{
      'creatorId': instance.creatorId,
      'question': instance.question,
      'options': instance.options,
      'correctAnswerIds': instance.correctAnswerIds,
      'level': instance.level,
    };
