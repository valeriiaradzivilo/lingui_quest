import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetGroupByCodeUsecase extends UseCaseFutureEither<GroupModel, String> {
  final RemoteRepository repository;

  GetGroupByCodeUsecase({required this.repository});

  @override
  Future<Either<Failure, GroupModel>> call(String params) async {
    return repository.getGroupByCode(params);
  }
}
