import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class PostGroupUsecase extends UseCaseFutureEither<void, GroupModel> {
  final RemoteRepository repository;

  PostGroupUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(GroupModel params) async {
    return repository.postGroup(params);
  }
}
