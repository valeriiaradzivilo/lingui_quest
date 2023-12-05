import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/group_full_info.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetFullGroupInfoUsecase extends UseCaseFutureEither<GroupFullInfoModel, GroupModel> {
  final RemoteRepository repository;

  GetFullGroupInfoUsecase({required this.repository});

  @override
  Future<Either<Failure, GroupFullInfoModel>> call(GroupModel params) async {
    return repository.getFullGroupInfo(params);
  }
}
