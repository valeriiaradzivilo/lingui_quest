import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';
import 'package:lingui_quest/data/models/question_model.dart';

part 'generated/game_error_model.freezed.dart';
part 'generated/game_error_model.g.dart';

@freezed
class GameErrorModel with _$GameErrorModel {
  const factory GameErrorModel({
    required QuestionModel question,
    required String expectedResult,
    required String actualResult,
  }) = _GameErrorModel;
  factory GameErrorModel.fromJson(Json json) => _$GameErrorModelFromJson(json);

  factory GameErrorModel.empty() {
    return GameErrorModel(
      question: QuestionModel.empty(),
      expectedResult: '',
      actualResult: '',
    );
  }
}
