import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_all_games_usecase.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';

part 'games_state.dart';

sealed class GameListEvent {}

final class FindAllGames extends GameListEvent {}

final class FindCurrentUser extends GameListEvent {}

class GamesListBloc extends Bloc<GameListEvent, GamesListState> {
  final GetAllGamesUsecase _getAllGamesUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  GamesListBloc(this._getAllGamesUsecase, this._getCurrentUserUsecase) : super(GamesListState.initial()) {
    on<FindAllGames>((event, emit) async {
      final allGamesListResult = await _getAllGamesUsecase(state.page);
      allGamesListResult.fold(
          (_) => emit(state.copyWith(status: GamesUploadStatus.error, errorMessage: 'Error getting games. Try again!')),
          (games) => emit(state.copyWith(gamesList: games)));
    });
    on<FindCurrentUser>(
      (event, emit) async {
        final getCurrentUserRes = await _getCurrentUserUsecase(NoParams());
        getCurrentUserRes.fold((l) => null, (r) => state.copyWith(currentUser: r));
      },
    );
  }
}
