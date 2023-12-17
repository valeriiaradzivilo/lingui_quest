import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetAllGameResults extends UseCaseFutureEither<void, String> {
  final RemoteRepository repository;

  GetAllGameResults({required this.repository});

  @override
  Future<Either<Failure, void>> call(String params) async {
    return repository.getAllGameResults(params);
  }
}
