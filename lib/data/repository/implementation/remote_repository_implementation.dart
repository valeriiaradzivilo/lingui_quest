import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/data/data_source/firebase_remote_data_source.dart';
import 'package:lingui_quest/data/level_test_logic/level_test_tree.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/group_full_info.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/join_request_full_model.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';
import 'package:lingui_quest/data/usecase/sign_in_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';

class RemoteRepositoryImplementation implements RemoteRepository {
  final FirebaseRemoteDatasource _database;

  RemoteRepositoryImplementation(this._database);

  @override
  Future<Either<Failure, void>> signUpWithEmail(SignUpParams params) async {
    try {
      await _database.createUserWithEmailAndPassword(params);
      return const Right(null);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signIn(SignInParams params) async {
    try {
      await _database.signInWithEmailAndPassword(params.email, params.password);
      return const Right(null);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _database.signOut();
      return const Right(null);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final UserModel currentUser = await _database.getCurrentUserData();
      return Right(currentUser);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addTestTask(LevelTestTaskModel task) async {
    try {
      await _database.crateNewTestTask(task);
      return const Right(null);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<LevelTestTaskModel>>>> getAllTestTasks() async {
    try {
      final res = await _database.readTasks();
      return Right(res);
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Node>> createTestTaskTree(List<LevelTestTaskModel> allTasks) async {
    try {
      final LevelTestTasksTree myTree = LevelTestTasksTree();
      return Right(await myTree.startTree(allTasks));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createTutor(TutorModel tutor) async {
    try {
      return Right(await _database.createNewTutor(tutor));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TutorModel>> getCurrentTutor() async {
    try {
      return Right(await _database.getCurrentTutor());
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createGame(GameModel game) async {
    try {
      return Right(await _database.createNewGame(game));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<GameModel>>>> getAllPublicGames(int page) async {
    try {
      return Right(await _database.getAllPublicGames(page));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GameModel>> getGameById(String gameId) async {
    try {
      return Right(await _database.getGameById(gameId));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroupModel>> getGroupByCode(String code) async {
    try {
      return Right(await _database.getGroupByCode(code));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<GroupModel>>>> getAllGroupsForCurrentUser() async {
    try {
      return Right(await _database.getAllGroupsForCurrentUser());
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> postGroup(GroupModel group) async {
    try {
      return Right(await _database.postGroup(group));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroupFullInfoModel>> getFullGroupInfo(GroupModel group) async {
    try {
      return Right(await _database.getFullGroupInfo(group));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<JoinRequestFullModel>>>> getJoinRequests() async {
    try {
      return Right(await _database.getJoinRequests());
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GroupModel>>> getCreatedGroupsForCurrentUser() async {
    try {
      return Right(await _database.getCreatedGroupsByCurrentUser());
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<GameModel>>>> getGameByGroupCode(String code) async {
    try {
      return Right(await _database.getGameByGroupCode(code));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> requestToJoinTheGroup(String code) async {
    try {
      return Right(await _database.requestToJoinTheGroup(code));
    } catch (e) {
      return Left(UndefinedFailure(message: e.toString()));
    }
  }
}
