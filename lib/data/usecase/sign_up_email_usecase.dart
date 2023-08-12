import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class SignUpWithEmailUsecase extends UseCaseFutureEither<void, SignUpParams> {
  final RemoteRepository repository;

  SignUpWithEmailUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(SignUpParams params) async {
    return await repository.signUpWithEmail(params);
  }
}

class SignUpParams {
  final String email;
  final String password;

  SignUpParams(this.email, this.password);
}
