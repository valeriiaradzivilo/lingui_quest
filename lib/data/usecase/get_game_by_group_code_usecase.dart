import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetGameByGroupCodeUsecase extends UseCaseFutureEither<Stream<List<GameModel>>, String> {
  final RemoteRepository repository;

  GetGameByGroupCodeUsecase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<GameModel>>>> call(String params) async {
    return repository.getGameByGroupCode(params);
  }
}
