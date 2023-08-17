import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/test_task_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetAllTestTasksUsecase extends UseCaseFutureEither<Stream<List<TestTaskModel>>, NoParams> {
  final RemoteRepository repository;

  GetAllTestTasksUsecase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<TestTaskModel>>>> call(NoParams params) async {
    return await repository.getAllTestTasks();
  }
}
