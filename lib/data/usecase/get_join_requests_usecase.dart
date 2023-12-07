import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/join_request_full_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetJoinRequestsUsecase extends UseCaseFutureEither<Stream<List<JoinRequestFullModel>>, NoParams> {
  final RemoteRepository repository;

  GetJoinRequestsUsecase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<JoinRequestFullModel>>>> call(NoParams params) async {
    return repository.getJoinRequests();
  }
}
