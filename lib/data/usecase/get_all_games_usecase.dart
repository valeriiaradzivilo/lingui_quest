import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetAllGamesUsecase extends UseCaseFutureEither<void, int> {
  final RemoteRepository repository;

  GetAllGamesUsecase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<GameModel>>>> call(int params) async {
    return await repository.getAllPublicGames(params);
  }
}
