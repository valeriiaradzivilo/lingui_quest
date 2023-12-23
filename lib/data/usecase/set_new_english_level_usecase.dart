import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';

class SetNewEnglishLevelUsecase extends UseCaseFutureEither<void, EnglishLevel> {
  final RemoteRepository repository;

  SetNewEnglishLevelUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(EnglishLevel params) async {
    return repository.setNewEnglishLevel(params);
  }
}
