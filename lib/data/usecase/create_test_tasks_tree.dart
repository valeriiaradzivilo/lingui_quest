import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/level_test_logic/level_test_tree.dart';
import 'package:lingui_quest/data/models/test_task_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class CreateTestTaskTreeUsecase extends UseCaseFutureEither<void, List<TestTaskModel>> {
  final RemoteRepository repository;

  CreateTestTaskTreeUsecase({required this.repository});

  @override
  Future<Either<Failure, Node>> call(List<TestTaskModel> params) async {
    return await repository.createTestTaskTree(params);
  }
}
