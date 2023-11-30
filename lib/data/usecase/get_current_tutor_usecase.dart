import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetCurrentTutorUsecase extends UseCaseFutureEither<TutorModel, NoParams> {
  final RemoteRepository repository;

  GetCurrentTutorUsecase({required this.repository});

  @override
  Future<Either<Failure, TutorModel>> call(NoParams params) async {
    return await repository.getCurrentTutor();
  }
}
