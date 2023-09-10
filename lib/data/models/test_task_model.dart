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
  TestTaskModel(
      {required this.creatorId,
      required this.question,
      required this.options,
      required this.correctAnswerIds,
      required this.level});
  factory TestTaskModel.fromJson(Json json) => _$TestTaskModelFromJson(json);
  Json toJson() => _$TestTaskModelToJson(this);

  factory TestTaskModel.empty() {
    return TestTaskModel(creatorId: '', question: '', options: [], correctAnswerIds: [], level: '');
  }
}
