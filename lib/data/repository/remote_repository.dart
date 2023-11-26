import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/data/firebase/firebase_database.dart';
import 'package:lingui_quest/data/level_test_logic/level_test_tree.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/sign_in_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';

class RemoteRepository {
  final FirebaseDatabaseImpl _database;

  RemoteRepository(this._database);

  Future<Either<Failure, void>> signUpWithEmail(SignUpParams params) async {
    try {
      await _database.createUserWithEmailAndPassword(params);
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

  Future<Either<Failure, void>> signOut() async {
    try {
      await _database.signOut();
      return const Right(null);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final UserModel currentUser = await _database.getCurrentUserData();
      return Right(currentUser);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> addTestTask(LevelTestTaskModel task) async {
    try {
      await _database.crateNewTestTask(task);
      return const Right(null);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Stream<List<LevelTestTaskModel>>>> getAllTestTasks() async {
    try {
      final res = await _database.readTasks();
      return Right(res);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Node>> createTestTaskTree(List<LevelTestTaskModel> allTasks) async {
    try {
      final LevelTestTasksTree myTree = LevelTestTasksTree();
      return Right(await myTree.startTree(allTasks));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  // Future<Either<Failure, Stream<List<TutorModel>>>> getAllTutors() async {
  //   try {
  //     return Right(await _database.getAllTutors());
  //   } catch (e) {
  //     return Left(UndefinedFailure(message: e.toString()));
  //   }
  // }

  Future<Either<Failure, void>> createTutor(TutorModel tutor) async {
    try {
      return Right(await _database.createNewTutor(tutor));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> createGame(GameModel game) async {
    try {
      return Right(await _database.createNewGame(game));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Stream<List<GameModel>>>> getAllGames(int page) async {
    try {
      return Right(await _database.getAllGames(page));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, GameModel>> getGameById(String gameId) async {
    try {
      return Right(await _database.getGameById(gameId));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }
}
