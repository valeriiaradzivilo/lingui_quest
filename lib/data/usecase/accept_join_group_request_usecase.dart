import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/join_request_full_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class AcceptJoinGroupRequestUsecase extends UseCaseFutureEither<void, JoinRequestFullModel> {
  final RemoteRepository repository;

  AcceptJoinGroupRequestUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(JoinRequestFullModel params) async {
    return repository.acceptRequestToJoinTheGroup(params);
  }
}
