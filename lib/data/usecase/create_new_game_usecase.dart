import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class CreateNewGameUsecase extends UseCaseFutureEither<void, GameModel> {
  final RemoteRepository repository;

  CreateNewGameUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(GameModel params) async {
    return await repository.createGame(params);
  }
}
