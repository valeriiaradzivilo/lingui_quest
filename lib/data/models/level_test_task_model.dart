// ignore_for_file: deprecated_consistency; invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';

part 'generated/level_test_task_model.g.dart';

@JsonSerializable()
class LevelTestTaskModel {
  final String creatorId;
  final String question;
  final List<String> options;
  final List<int> correctAnswerIds;
  final String level;
  final bool isVerified;
  LevelTestTaskModel(
      {required this.creatorId,
      required this.question,
      required this.options,
      required this.correctAnswerIds,
      required this.level,
      this.isVerified = true});
  factory LevelTestTaskModel.fromJson(Json json) => _$LevelTestTaskModelFromJson(json);
  Json toJson() => _$LevelTestTaskModelToJson(this);

  factory LevelTestTaskModel.empty() {
    return LevelTestTaskModel(creatorId: '', question: '', options: [], correctAnswerIds: [], level: '');
  }
}
