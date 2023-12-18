import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/student_group_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class DeleteStudentFromGroupUsecase extends UseCaseFutureEither<void, StudentGroupModel> {
  final RemoteRepository repository;

  DeleteStudentFromGroupUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(StudentGroupModel params) async {
    return repository.deleteStudentFromGroup(params);
  }
}
