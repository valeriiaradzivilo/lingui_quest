import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/game_search_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_all_public_games_usecase.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/get_public_games_count.dart';
import 'package:lingui_quest/data/usecase/search_games_usecase.dart';
import 'package:lingui_quest/shared/constants/games_constants.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/enums/game_theme_enum.dart';

part 'games_list_state.dart';

sealed class GameListEvent {}

final class SwitchPage extends GameListEvent {
  final int page;
  SwitchPage({required this.page});
}

final class FindGames extends GameListEvent {}

final class StopSearch extends GameListEvent {}

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

final class Init extends GameListEvent {}

class GamesListBloc extends Bloc<GameListEvent, GamesListState> {
  final GetAllPublicGamesUsecase _getAllPublicGamesUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final SearchGamesUsecase _searchGamesUsecase;
  final GetPublicGamesCount _getPublicGamesCount;

  GamesListBloc(
      this._getAllPublicGamesUsecase, this._getCurrentUserUsecase, this._searchGamesUsecase, this._getPublicGamesCount)
      : super(GamesListState.initial()) {
    on<SwitchPage>((event, emit) async {
      emit(state.copyWith(status: GamesUploadStatus.progress));
      final allGamesListResult = await _getAllPublicGamesUsecase(event.page);
      allGamesListResult.fold(
          (_) => emit(state.copyWith(status: GamesUploadStatus.error, errorMessage: 'Error getting games. Try again!')),
          (games) => emit(state.copyWith(gamesList: games, status: GamesUploadStatus.initial, page: event.page)));
    });
    on<Init>(
      (event, emit) async {
        final getCurrentUserRes = await _getCurrentUserUsecase(NoParams());
        getCurrentUserRes.fold((___) => null, (currentUser) => emit(state.copyWith(currentUser: currentUser)));

        final publicGamesCountRes = await _getPublicGamesCount(NoParams());
        publicGamesCountRes.fold(
            (__) =>
                emit(state.copyWith(status: GamesUploadStatus.error, errorMessage: 'Error getting games. Try again!')),
            (gamesCount) async {
          var pageDivisionRes = gamesCount ~/ GameConstants.gamesPerPage;
          if (gamesCount - pageDivisionRes > 0) {
            pageDivisionRes++;
          }
          emit(state.copyWith(totalPageCount: pageDivisionRes));
        });
        if (publicGamesCountRes.isRight()) {
          final allGamesListResult = await _getAllPublicGamesUsecase(state.page);
          allGamesListResult.fold(
              (_) => emit(
                  state.copyWith(status: GamesUploadStatus.error, errorMessage: 'Error getting games. Try again!')),
              (games) async => emit(state.copyWith(gamesList: games, status: GamesUploadStatus.initial)));
        }
      },
    );
    on<FindGames>(
      (event, emit) async {
        final getGames = await _searchGamesUsecase(state.searchModel);
        getGames.fold(
            (l) =>
                emit(state.copyWith(status: GamesUploadStatus.error, searchResult: [], errorMessage: l.failureMessage)),
            (r) => emit(
                  state.copyWith(
                    searchResult: r,
                    status: GamesUploadStatus.search,
                  ),
                ));
      },
    );
    on<ChangeSearchText>(
      (event, emit) async {
        emit(state.copyWith(searchModel: state.searchModel.copyWith(name: event.text), searchResult: []));
      },
    );
    on<ChangeLevel>(
      (event, emit) async {
        final newLevelList = [...state.searchModel.level];
        if (newLevelList.contains(event.level)) {
          newLevelList.remove(event.level);
        } else {
          newLevelList.add(event.level);
        }
        emit(state.copyWith(
            status: newLevelList.isNotEmpty ? GamesUploadStatus.search : GamesUploadStatus.initial,
            searchModel: state.searchModel.copyWith(level: newLevelList),
            searchResult: []));
        final getGames = await _searchGamesUsecase(state.searchModel);
        getGames.fold((l) => emit(state.copyWith(searchResult: [])), (r) => emit(state.copyWith(searchResult: r)));
      },
    );
    on<ChangeTheme>((event, emit) async {
      final newThemeList = [...state.searchModel.theme];
      if (newThemeList.contains(event.theme.label)) {
        newThemeList.remove(event.theme.label);
      } else {
        newThemeList.add(event.theme.label);
      }
      emit(state.copyWith(
          status: newThemeList.isNotEmpty ? GamesUploadStatus.search : GamesUploadStatus.initial,
          searchModel: state.searchModel.copyWith(theme: newThemeList),
          searchResult: []));
      final getGames = await _searchGamesUsecase(state.searchModel);
      getGames.fold((l) => emit(state.copyWith(searchResult: [])), (r) => emit(state.copyWith(searchResult: r)));
    });

    on<StopSearch>((event, emit) => emit(state.copyWith(
          status: GamesUploadStatus.initial,
          searchModel: GameSearchModel.empty(),
          searchResult: [],
        )));
  }
}
