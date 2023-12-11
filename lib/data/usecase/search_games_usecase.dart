import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/game_search_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class SearchGamesUsecase extends UseCaseFutureEither<List<GameModel>, GameSearchModel> {
  final RemoteRepository repository;

  SearchGamesUsecase({required this.repository});

  @override
  Future<Either<Failure, List<GameModel>>> call(GameSearchModel params) async {
    return repository.searchGame(params);
  }
}
