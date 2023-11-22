import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_all_games_usecase.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';

part 'games_state.dart';

sealed class CounterEvent {}

final class AddNewGame extends CounterEvent {}

final class FindAllGames extends CounterEvent {}

final class GameListBloc extends CounterEvent {}

class GameBloc extends Bloc<CounterEvent, GamesState> {
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final GetAllGamesUsecase _getAllGamesUsecase;
  GameBloc(this._getCurrentUserUsecase, this._getAllGamesUsecase) : super(GamesState.initial()) {
    on<AddNewGame>((event, emit) async {
      Response response = await Dio().get('http://192.168.2.5:5000/create_test');
      print(response);
    });
    on<FindAllGames>((event, emit) async {
      final allGamesListResult = await _getAllGamesUsecase(state.page);
      allGamesListResult.fold(
          (_) => emit(state.copyWith(status: GamesUploadStatus.error, errorMessage: 'Error getting games. Try again!')),
          (games) => emit(state.copyWith(gamesList: games)));
    });
  }
}
