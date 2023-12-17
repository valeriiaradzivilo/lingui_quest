import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_result_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class PostGameResultUsecase extends UseCaseFutureEither<void, GameResultModel> {
  final RemoteRepository repository;

  PostGameResultUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(GameResultModel params) async {
    return repository.postGameResult(params);
  }
}
