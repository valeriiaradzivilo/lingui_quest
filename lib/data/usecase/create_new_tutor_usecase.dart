import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class CreateNewTutorUsecase extends UseCaseFutureEither<void, TutorModel> {
  final RemoteRepository repository;

  CreateNewTutorUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(TutorModel params) async {
    return await repository.createTutor(params);
  }
}
