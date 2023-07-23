import 'package:lingui_quest/core/usecase/usercase.dart';
import 'package:lingui_quest/data/local_storage/hive_database.dart';

class CheckLoggedInUsecase extends UseCaseFuture<void, NoParams> {
  CheckLoggedInUsecase();

  @override
  Future<bool> call(NoParams params) async {
    return await HiveDatabase.isSignedIn();
  }
}
