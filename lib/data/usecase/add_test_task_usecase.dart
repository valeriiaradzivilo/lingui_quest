import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class AddTestTaskUsecase extends UseCaseFutureEither<void, LevelTestTaskModel> {
  final RemoteRepository repository;

  AddTestTaskUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(LevelTestTaskModel params) async {
    return await repository.addTestTask(params);
  }
}
