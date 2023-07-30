// ignore_for_file: deprecated_consistency; invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';

part 'test_task_model.g.dart';

@JsonSerializable()
class TestTaskModel {
  final String creatorId;
  final String question;
  final List<String> options;
  final List<int> correctAnswerIds;
  final String level;
  TestTaskModel(this.creatorId, this.question, this.options, this.correctAnswerIds, this.level);
  factory TestTaskModel.fromJson(Json json) => _$TestTaskModelFromJson(json);
  Json toJson() => _$TestTaskModelToJson(this);
}
