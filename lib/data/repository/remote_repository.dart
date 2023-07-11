import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/data/firebase/firebase_database.dart';
import 'package:lingui_quest/data/usecase/sign_in_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';

class RemoteRepository {
  final FirebaseDatabaseImpl _database;

  RemoteRepository(this._database);

  Future<Either<Failure, void>> signUpWithEmail(SignUpParams params) async {
    try {
      await _database.createUserWithEmailAndPassword(params.email, params.password);
      return const Right(null);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> signIn(SignInParams params) async {
    try {
      await _database.signInWithEmailAndPassword(params.email, params.password);
      return const Right(null);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }
}
