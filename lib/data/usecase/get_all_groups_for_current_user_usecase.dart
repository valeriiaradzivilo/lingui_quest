import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetAllGroupsForCurrentUserUsecase extends UseCaseFutureEither<Stream<List<GroupModel>>, NoParams> {
  final RemoteRepository repository;

  GetAllGroupsForCurrentUserUsecase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<GroupModel>>>> call(NoParams params) async {
    return repository.getAllGroupsForCurrentUser();
  }
}
