// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../game_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameErrorModelImpl _$$GameErrorModelImplFromJson(Map<String, dynamic> json) =>
    _$GameErrorModelImpl(
      question:
          QuestionModel.fromJson(json['question'] as Map<String, dynamic>),
      expectedResult: json['expected_result'] as String,
      actualResult: json['actual_result'] as String,
    );

Map<String, dynamic> _$$GameErrorModelImplToJson(
        _$GameErrorModelImpl instance) =>
    <String, dynamic>{
      'question': instance.question.toJson(),
      'expected_result': instance.expectedResult,
      'actual_result': instance.actualResult,
    };
