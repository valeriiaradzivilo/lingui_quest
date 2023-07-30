import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usercase.dart';
import 'package:lingui_quest/data/models/test_task_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class AddTestTaskUsecase extends UseCaseFutureEither<void, TestTaskModel> {
  final RemoteRepository repository;

  AddTestTaskUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(TestTaskModel params) async {
    return await repository.addTestTask(params);
  }
}
