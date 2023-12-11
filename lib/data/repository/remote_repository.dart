import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/data/level_test_logic/level_test_tree.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/game_search_model.dart';
import 'package:lingui_quest/data/models/group_full_info.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/join_request_full_model.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/rate_game_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_in_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';

abstract class RemoteRepository {
  /// Signs up a user with an email.
  ///
  /// [params] - The parameters for signing up.
  Future<Either<Failure, void>> signUpWithEmail(SignUpParams params);

  /// Signs in a user.
  ///
  /// [params] - The parameters for signing in.
  Future<Either<Failure, void>> signIn(SignInParams params);

  /// Signs out a user.
  Future<Either<Failure, void>> signOut();

  /// Gets the current user.
  Future<Either<Failure, UserModel>> getCurrentUser();

  /// Adds a test task to the repository.
  ///
  /// [task] - The test task to add.
  Future<Either<Failure, void>> addTestTask(LevelTestTaskModel task);

  /// Gets all test tasks from the repository.
  Future<Either<Failure, Stream<List<LevelTestTaskModel>>>> getAllTestTasks();

  /// Creates a test task tree from a list of test tasks.
  ///
  /// [allTasks] - The list of test tasks.
  Future<Either<Failure, Node>> createTestTaskTree(List<LevelTestTaskModel> allTasks);

  /// Creates a tutor in the repository.
  ///
  /// [tutor] - The tutor to create.
  Future<Either<Failure, void>> createTutor(TutorModel tutor);

  /// Gets a tutor model for current user in the repository.
  Future<Either<Failure, TutorModel>> getCurrentTutor();

  /// Creates a game in the repository.
  ///
  /// [game] - The game to create.
  Future<Either<Failure, void>> createGame(GameModel game);

  /// Gets all games from the repository, paginated.
  ///
  /// [page] - The page of games to get.
  Future<Either<Failure, Stream<List<GameModel>>>> getAllPublicGames(int page);

  /// Gets a game by its ID.
  ///
  /// [gameId] - The ID of the game.
  Future<Either<Failure, GameModel>> getGameById(String gameId);

  /// Gets a game by group code.
  ///
  /// [code] - The code of the group.
  Future<Either<Failure, Stream<List<GameModel>>>> getGameByGroupCode(String code);

  /// Gets a group by its code.
  ///
  /// [code] - The code of the group.
  Future<Either<Failure, GroupModel>> getGroupByCode(String code);

  /// Gets all groups for the current user.
  Future<Either<Failure, Stream<List<GroupModel>>>> getAllGroupsForCurrentUser();

  /// Gets groups created by the current user.
  Future<Either<Failure, List<GroupModel>>> getCreatedGroupsForCurrentUser();

  /// Posts a group to the repository.
  ///
  /// [group] - The group to post.
  Future<Either<Failure, void>> postGroup(GroupModel group);

  /// Get a full group information from Firebase.
  ///
  /// [group] - The group to get.
  Future<Either<Failure, GroupFullInfoModel>> getFullGroupInfo(GroupModel group);

  /// Get all join requests for current group from Firebase.
  Future<Either<Failure, Stream<List<JoinRequestFullModel>>>> getJoinRequests();

  /// Posts a request to join the group to the repository.
  ///
  /// [code] - The group code.
  Future<Either<Failure, void>> requestToJoinTheGroup(String code);

  /// Add to students in 'studentsGroups' and delete a request to join the group.
  ///
  /// [model] - The request.
  Future<Either<Failure, void>> acceptRequestToJoinTheGroup(JoinRequestFullModel model);

  /// Declines a request to join the group.
  ///
  /// [id] - The unique identifier of the request.
  Future<Either<Failure, void>> declineRequestToJoinTheGroup(String id);

  /// Searches for a game by its unique identifier.
  ///
  /// [id] - The unique identifier of the game.
  Future<Either<Failure, List<GameModel>>> searchGame(GameSearchModel searchModel);

  /// Rates a game by its unique identifier.
  ///
  /// [id] - The unique identifier of the game.
  Future<Either<Failure, void>> rateTheGame(GameRate rate);
}
