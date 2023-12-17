import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetPublicGamesCount extends UseCaseFutureEither<int, NoParams> {
  final RemoteRepository repository;

  GetPublicGamesCount({required this.repository});

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return repository.publicGamesCount();
  }
}
