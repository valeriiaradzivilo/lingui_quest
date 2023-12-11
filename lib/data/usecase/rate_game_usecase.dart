import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class RateGameUsecase extends UseCaseFutureEither<void, GameRate> {
  final RemoteRepository repository;

  RateGameUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(GameRate params) async {
    return repository.rateTheGame(params);
  }
}

class GameRate {
  String gameId;
  double rate;

  GameRate(this.gameId, this.rate);
}
