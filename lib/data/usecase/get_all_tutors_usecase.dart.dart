import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';

class GetAllTutorsUsecase extends UseCaseFutureEither<void, NoParams> {
  final RemoteRepository repository;

  GetAllTutorsUsecase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<TutorModel>>>> call(NoParams params) async {
    return await repository.getAllTutors();
  }
}
