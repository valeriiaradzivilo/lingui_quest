import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetCurrentUserUsecase extends UseCaseFutureEither<UserModel, NoParams> {
  final RemoteRepository repository;

  GetCurrentUserUsecase({required this.repository});

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return repository.getCurrentUser();
  }
}
