// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../game_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameResultModelImpl _$$GameResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GameResultModelImpl(
      userId: json['user_id'] as String,
      gameId: json['game_id'] as String,
      result: (json['result'] as num).toDouble(),
      timeFinished: json['time_finished'] as int,
      errors: (json['errors'] as List<dynamic>)
          .map((e) => GameErrorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GameResultModelImplToJson(
        _$GameResultModelImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'game_id': instance.gameId,
      'result': instance.result,
      'time_finished': instance.timeFinished,
      'errors': instance.errors.map((e) => e.toJson()).toList(),
    };
