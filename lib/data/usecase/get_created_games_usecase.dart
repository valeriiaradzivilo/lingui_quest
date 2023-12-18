import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetCreatedGamesUsecase extends UseCaseFutureEither<void, NoParams> {
  final RemoteRepository repository;

  GetCreatedGamesUsecase({required this.repository});

  @override
  Future<Either<Failure, List<GameModel>>> call(NoParams params) async {
    return await repository.getCreatedGames();
  }
}
