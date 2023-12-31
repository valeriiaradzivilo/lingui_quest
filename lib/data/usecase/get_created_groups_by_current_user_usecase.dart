import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetCreatedGroupsByCurrentUserUsecase extends UseCaseFutureEither<List<GroupModel>, NoParams> {
  final RemoteRepository repository;

  GetCreatedGroupsByCurrentUserUsecase({required this.repository});

  @override
  Future<Either<Failure, List<GroupModel>>> call(NoParams params) async {
    return repository.getCreatedGroupsForCurrentUser();
  }
}
