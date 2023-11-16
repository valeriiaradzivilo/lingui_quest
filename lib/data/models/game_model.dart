import 'package:json_annotation/json_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';
import 'package:lingui_quest/data/models/question_model.dart';

part 'game_model.g.dart';

@JsonSerializable()
class GameModel {
  final String creatorId;
  final String name;
  final List<QuestionModel> questions;

  GameModel({
    required this.creatorId,
    required this.name,
    required this.questions,
  });
  factory GameModel.fromJson(Json json) => _$GameModelFromJson(json);
  Json toJson() => _$GameModelToJson(this);

  factory GameModel.empty() {
    return GameModel(
      creatorId: '',
      name: '',
      questions: [],
    );
  }
}
