import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';
import 'package:lingui_quest/data/models/game_error_model.dart';

part 'generated/game_result_model.freezed.dart';
part 'generated/game_result_model.g.dart';

@freezed
class GameResultModel with _$GameResultModel {
  const factory GameResultModel({
    required String userId,
    required String gameId,
    required double result,
    required int timeFinished,
    required List<GameErrorModel> errors,
  }) = _GameResultModel;
  factory GameResultModel.fromJson(Json json) => _$GameResultModelFromJson(json);

  factory GameResultModel.empty() {
    return GameResultModel(
      userId: '',
      gameId: '',
      result: 0,
      timeFinished: DateTime.now().millisecondsSinceEpoch,
      errors: [],
    );
  }
}
