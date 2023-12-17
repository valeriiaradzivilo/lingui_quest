import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/get_game_by_id_usecase.dart';

part 'game_preview_state.dart';

class GamePreviewCubit extends Cubit<GamePreviewState> {
  GamePreviewCubit(this._getGameByIdUsecase, this._getCurrentUserUsecase) : super(GamePreviewState.initial());
  final GetGameByIdUsecase _getGameByIdUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;

  void init(String? gameId) async {
    if (gameId != null) {
      final getCurrentUserRes = await _getCurrentUserUsecase(NoParams());
      getCurrentUserRes.fold((___) => null, (currentUser) => emit(state.copyWith(currentUser: currentUser)));
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
