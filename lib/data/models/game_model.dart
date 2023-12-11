import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';
import 'package:lingui_quest/data/models/question_model.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';

part 'generated/game_model.freezed.dart';
part 'generated/game_model.g.dart';

@freezed
class GameModel with _$GameModel {
  const factory GameModel({
    required String id,
    required String creatorId,
    required String name,
    required List<QuestionModel> questions,
    required EnglishLevel level,
    required String theme,
    required String description,
    required int time,
    required List<String> groups,
    double? rate,
  }) = _GameModel;
  factory GameModel.fromJson(Json json) => _$GameModelFromJson(json);

  factory GameModel.empty() {
    return GameModel(
      id: '',
      creatorId: '',
      name: '',
      questions: [],
      level: EnglishLevel.a1,
      theme: '',
      description: '',
      time: 3600,
      groups: [],
      rate: null,
    );
  }

  const GameModel._();

  bool get validate =>
      name.isNotEmpty && questions.every((e) => e.validate) && theme.isNotEmpty && description.isNotEmpty && time > 0;
}
