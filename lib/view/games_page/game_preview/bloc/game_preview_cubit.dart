import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/usecase/get_game_by_id_usecase.dart';

part 'game_preview_state.dart';

class GamePreviewCubit extends Cubit<GamePreviewState> {
  GamePreviewCubit(this._getGameByIdUsecase) : super(GamePreviewState.initial());
  final GetGameByIdUsecase _getGameByIdUsecase;

  void init(String? gameId) async {
    if (gameId != null) {
      final id = gameId.substring(gameId.indexOf('=') + 1);
      final gameRes = await _getGameByIdUsecase(id);
      if (gameRes.isRight()) {
        emit(state.copyWith(
            status: GamePreviewStatus.initial, game: gameRes.foldRight(GameModel.empty(), (r, previous) => r)));
        return;
      }
    }
    emit(state.copyWith(
        status: GamePreviewStatus.error,
        errorMessage: 'The game was not found. Maybe it was deleted by creator or you do not have access to it.'));
  }
}
