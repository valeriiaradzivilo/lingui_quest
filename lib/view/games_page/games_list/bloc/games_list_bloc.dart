import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/game_search_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_all_games_usecase.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/search_games_usecase.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/enums/game_theme_enum.dart';

part 'games_state.dart';

sealed class GameListEvent {}

final class FindAllGames extends GameListEvent {}

final class FindGames extends GameListEvent {}

final class ChangeSearchText extends GameListEvent {
  final String text;

  ChangeSearchText({required this.text});
}

final class ChangeLevel extends GameListEvent {
  final EnglishLevel level;

  ChangeLevel({required this.level});
}

final class ChangeTheme extends GameListEvent {
  final GameTheme theme;

  ChangeTheme({required this.theme});
}

final class FindCurrentUser extends GameListEvent {}

class GamesListBloc extends Bloc<GameListEvent, GamesListState> {
  final GetAllGamesUsecase _getAllPublicGamesUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final SearchGamesUsecase _searchGamesUsecase;

  GamesListBloc(this._getAllPublicGamesUsecase, this._getCurrentUserUsecase, this._searchGamesUsecase)
      : super(GamesListState.initial()) {
    on<FindAllGames>((event, emit) async {
      final allGamesListResult = await _getAllPublicGamesUsecase(state.page);
      allGamesListResult.fold(
          (_) => emit(state.copyWith(status: GamesUploadStatus.error, errorMessage: 'Error getting games. Try again!')),
          (games) => emit(state.copyWith(gamesList: games)));
    });
    on<FindCurrentUser>(
      (event, emit) async {
        final getCurrentUserRes = await _getCurrentUserUsecase(NoParams());
        getCurrentUserRes.fold((l) => null, (r) => emit(state.copyWith(currentUser: r)));
        final allGamesListResult = await _getAllPublicGamesUsecase(state.page);
        allGamesListResult.fold(
            (_) =>
                emit(state.copyWith(status: GamesUploadStatus.error, errorMessage: 'Error getting games. Try again!')),
            (games) => emit(state.copyWith(gamesList: games)));
      },
    );
    on<FindGames>(
      (event, emit) async {
        final getGames = await _searchGamesUsecase(state.searchModel);
        getGames.fold((l) => emit(state.copyWith(searchResult: [])), (r) => emit(state.copyWith(searchResult: r)));
      },
    );
    on<ChangeSearchText>(
      (event, emit) => emit(state.copyWith(searchModel: state.searchModel.copyWith(name: event.text))),
    );
  }
}
