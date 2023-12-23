import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/data/data_source/firebase_remote_data_source.dart';
import 'package:lingui_quest/data/level_test_logic/level_test_tree.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/game_result_full_model.dart';
import 'package:lingui_quest/data/models/game_result_model.dart';
import 'package:lingui_quest/data/models/game_search_model.dart';
import 'package:lingui_quest/data/models/group_full_info.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/join_request_full_model.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/passed_game_model.dart';
import 'package:lingui_quest/data/models/student_group_model.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';
import 'package:lingui_quest/data/usecase/rate_game_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_in_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:simple_logger/simple_logger.dart';

class RemoteRepositoryImplementation implements RemoteRepository {
  final FirebaseRemoteDatasource _database;

  RemoteRepositoryImplementation(this._database);

  @override
  Future<Either<Failure, void>> signUpWithEmail(SignUpParams params) async {
    try {
      return Right(await _database.createUserWithEmailAndPassword(params));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signIn(SignInParams params) async {
    try {
      return Right(await _database.signInWithEmailAndPassword(params.email, params.password));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      return Right(await _database.signOut());
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final UserModel currentUser = await _database.getCurrentUserData();
      return Right(currentUser);
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addTestTask(LevelTestTaskModel task) async {
    try {
      return Right(await _database.crateNewTestTask(task));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<LevelTestTaskModel>>>> getAllTestTasks() async {
    try {
      final res = await _database.readTasks();
      return Right(res);
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Node>> createTestTaskTree(List<LevelTestTaskModel> allTasks) async {
    try {
      final LevelTestTasksTree myTree = LevelTestTasksTree();
      return Right(await myTree.startTree(allTasks));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createTutor(TutorModel tutor) async {
    try {
      return Right(await _database.createNewTutor(tutor));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TutorModel>> getCurrentTutor() async {
    try {
      return Right(await _database.getCurrentTutor());
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createGame(GameModel game) async {
    try {
      return Right(await _database.createNewGame(game));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<GameModel>>>> getAllPublicGames(int page) async {
    try {
      return Right(await _database.getAllPublicGames(page));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GameModel>> getGameById(String gameId) async {
    try {
      return Right(await _database.getGameById(gameId));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroupModel>> getGroupByCode(String code) async {
    try {
      return Right(await _database.getGroupByCode(code));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<GroupModel>>>> getAllGroupsForCurrentUser() async {
    try {
      return Right(await _database.getAllGroupsForCurrentUser());
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> postGroup(GroupModel group) async {
    try {
      return Right(await _database.postGroup(group));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroupFullInfoModel>> getFullGroupInfo(GroupModel group) async {
    try {
      return Right(await _database.getFullGroupInfo(group));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<JoinRequestFullModel>>>> getJoinRequests() async {
    try {
      return Right(await _database.getJoinRequests());
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GroupModel>>> getCreatedGroupsForCurrentUser() async {
    try {
      return Right(await _database.getCreatedGroupsByCurrentUser());
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<GameModel>>>> getGameByGroupCode(String code) async {
    try {
      return Right(await _database.getGameByGroupCode(code));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> requestToJoinTheGroup(String code) async {
    try {
      return Right(await _database.requestToJoinTheGroup(code));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rateTheGame(GameRate rate) async {
    try {
      return Right(await _database.rateTheGame(rate));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptRequestToJoinTheGroup(JoinRequestFullModel model) async {
    try {
      return Right(await _database.acceptRequestToJoinTheGroup(model));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> declineRequestToJoinTheGroup(String id) async {
    try {
      return Right(await _database.declineRequestToJoinTheGroup(id));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GameModel>>> searchGame(GameSearchModel searchModel) async {
    try {
      return Right(await _database.searchGame(searchModel));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> publicGamesCount() async {
    try {
      return Right(await _database.publicGamesCount());
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GameResultFullModel>>> getAllGameResults(String gameId) async {
    try {
      return Right(await _database.getAllGameResults(gameId));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PassedGameModel>>> getPassedGames() async {
    try {
      return Right(await _database.getPassedGames());
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> postGameResult(GameResultModel result) async {
    try {
      return Right(await _database.postGameResult(result));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GameModel>>> getCreatedGames() async {
    try {
      return Right(await _database.getCreatedGames());
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudentFromGroup(StudentGroupModel model) async {
    try {
      return Right(await _database.deleteStudentFromGroup(model));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setNewEnglishLevel(EnglishLevel level) async {
    try {
      return Right(await _database.setNewEnglishLevel(level));
    } catch (e) {
      SimpleLogger().shout(e.toString());
      return Left(UndefinedFailure(message: e.toString()));
    }
  }
}
