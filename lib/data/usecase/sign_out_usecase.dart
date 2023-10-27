import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class SignOutUsecase extends UseCaseFutureEither<void, NoParams> {
  final RemoteRepository repository;

  SignOutUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
