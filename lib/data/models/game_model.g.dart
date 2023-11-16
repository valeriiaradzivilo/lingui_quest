// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameModel _$GameModelFromJson(Map<String, dynamic> json) => GameModel(
      creatorId: json['creatorId'] as String,
      name: json['name'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameModelToJson(GameModel instance) => <String, dynamic>{
      'creatorId': instance.creatorId,
      'name': instance.name,
      'questions': instance.questions,
    };
