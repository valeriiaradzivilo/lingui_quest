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
import 'package:lingui_quest/data/usecase/rate_game_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';

abstract class FirebaseRemoteDatasource {
  /// Creates a new user in Firebase with an email and password.
  ///
  /// [params] - The parameters for signing up, including email and password.
  Future<void> createUserWithEmailAndPassword(SignUpParams params);

  /// Saves user data to Firebase.
  ///
  /// [user] - The user data to save.
  Future<void> saveUserData(UserModel user);

  /// Signs in a user with an email and password.
  ///
  /// [email] - The email of the user.
  /// [password] - The password of the user.
  Future<void> signInWithEmailAndPassword(String email, String password);

  /// Signs out the current user.
  Future<void> signOut();

  /// Creates a new test task in Firebase.
  ///
  /// [task] - The test task to create.
  Future<void> crateNewTestTask(LevelTestTaskModel task);

  /// Reads all test tasks from Firebase.
  ///
  /// Returns a stream of lists of test tasks.
  Future<Stream<List<LevelTestTaskModel>>> readTasks();

  /// Gets all user data of teachers from Firebase.
  ///
  /// Returns a stream of lists of user models.
  Future<Stream<List<UserModel>>> getAllUserDataTeachers();

  /// Gets the current user's data from Firebase.
  Future<UserModel> getCurrentUserData();

  /// Creates a new tutor in Firebase.
  ///
  /// [tutor] - The tutor to create.
  Future<void> createNewTutor(TutorModel tutor);

  /// Gets the tutor model for current user from Firebase.
  Future<TutorModel> getCurrentTutor();

  /// Creates a new game in Firebase.
  ///
  /// [model] - The game model to create.
  Future<void> createNewGame(GameModel model);

  /// Gets all games from Firebase, paginated.
  ///
  /// [page] - The page of games to get.
  /// Returns a stream of lists of game models.
  Future<Stream<List<GameModel>>> getAllPublicGames(int page);

  /// Gets count of all public games from Firebase, paginated.
  Future<int> publicGamesCount();

  /// Gets a game by its ID from Firebase.
  ///
  /// [id] - The ID of the game.
  /// Returns a game model.
  Future<GameModel> getGameById(String id);

  /// Gets a game by group code from Firebase.
  ///
  /// [code] - The code of the group.
  /// Returns a list of game models.
  Future<Stream<List<GameModel>>> getGameByGroupCode(String code);

  /// Gets a group by its code from Firebase.
  ///
  /// [code] - The code of the group.
  /// Returns a group model.
  Future<GroupModel> getGroupByCode(String code);

  /// Gets all groups for the current user from Firebase.
  ///
  /// Returns a stream of lists of group models.
  Future<Stream<List<GroupModel>>> getAllGroupsForCurrentUser();

  /// Gets all created groups by the current user from Firebase.
  ///
  /// Returns a stream of lists of group models.
  Future<List<GroupModel>> getCreatedGroupsByCurrentUser();

  /// Posts a group to Firebase.
  ///
  /// [group] - The group to post.
  Future<void> postGroup(GroupModel group);

  /// Get a full group information from Firebase.
  ///
  /// [group] - The group to get.
  Future<GroupFullInfoModel> getFullGroupInfo(GroupModel group);

  /// Get all join requests for current group from Firebase.
  Future<Stream<List<JoinRequestFullModel>>> getJoinRequests();

  /// Post a request to join the group.
  ///
  /// [code] - The code of the group.
  Future<void> requestToJoinTheGroup(String code);

  /// Add to students in 'studentsGroups' and delete a request to join the group.
  ///
  /// [model] - The request.
  Future<void> acceptRequestToJoinTheGroup(JoinRequestFullModel model);

  /// Declines a request to join the group.
  ///
  /// [id] - The unique identifier of the request.
  Future<void> declineRequestToJoinTheGroup(String id);

  /// Searches for a game by its unique identifier.
  ///
  /// [searchModel] - Model which contains search values.
  Future<List<GameModel>> searchGame(GameSearchModel searchModel);

  /// Rates a game by its unique identifier.
  ///
  /// [id] - The unique identifier of the game.
  Future<void> rateTheGame(GameRate rate);

  /// Retrieves the list of games for the current user.
  Future<List<PassedGameModel>> getPassedGames();

  /// Posts the result of a game.
  ///
  /// [id] - The unique identifier of the game.
  Future<void> postGameResult(GameResultModel result);

  /// Gets all results of a game.
  ///
  /// [gameId] - The unique identifier of the game.
  Future<List<GameResultFullModel>> getAllGameResults(String gameId);

  /// Gets all games created by current user
  Future<List<GameModel>> getCreatedGames();

  /// Delete a student
  ///
  /// [model] - user id + group id
  Future<void> deleteStudentFromGroup(StudentGroupModel model);

  /// Sets a new level for the student
  Future<void> setNewEnglishLevel(EnglishLevel level);
}
