import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usercase.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class SignInUsecase extends UseCaseFutureEither<void, SignInParams> {
  final RemoteRepository repository;

  SignInUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(SignInParams params) async {
    return await repository.signIn(params);
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams(this.email, this.password);
}
