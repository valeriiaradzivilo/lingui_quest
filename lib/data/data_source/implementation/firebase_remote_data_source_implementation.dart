import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lingui_quest/core/extensions/custom_exceptions.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';
import 'package:lingui_quest/data/data_source/firebase_remote_data_source.dart';
import 'package:lingui_quest/data/firebase/firebase_constants.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/game_result_full_model.dart';
import 'package:lingui_quest/data/models/game_result_model.dart';
import 'package:lingui_quest/data/models/game_search_model.dart';
import 'package:lingui_quest/data/models/group_full_info.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/join_request_full_model.dart';
import 'package:lingui_quest/data/models/join_request_model.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/passed_game_model.dart';
import 'package:lingui_quest/data/models/student_group_model.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/rate_game_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';
import 'package:lingui_quest/shared/constants/games_constants.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:uuid/uuid.dart';

class FirebaseRemoteDatasourceImplementation implements FirebaseRemoteDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> createUserWithEmailAndPassword(SignUpParams params) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await saveUserData(UserModel(
            email: params.email,
            userId: user.uid,
            username: params.email,
            firstName: params.firstName,
            lastName: params.lastName,
            level: EnglishLevel.a1,
            isTutor: false));

        SimpleLogger().info('Created an account for ${params.email}');
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      SimpleLogger().shout('Could not create an account for ${params.email}');
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw AccountAlreadyExistsException();
      }
    } catch (e) {
      SimpleLogger().shout('Could not create an account for ${params.email}');
      rethrow;
    }
  }

  @override
  Future<void> saveUserData(UserModel user) async {
    final CollectionReference userData = firestore.collection(FirebaseCollection.userData.collectionName);
    await userData.add(user.toJson());
    SimpleLogger().info('User added');
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      SimpleLogger().info('Signed user $email in');
    } on FirebaseAuthException catch (e) {
      SimpleLogger().shout('Could not sign in');
      if (e.code == 'user-not-found') {
        throw NoUserFoundException();
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> crateNewTestTask(LevelTestTaskModel task) async {
    final CollectionReference testTasks = firestore.collection(FirebaseCollection.testTasks.collectionName);
    await testTasks.add(task.toJson());
    SimpleLogger().info('Task added');
  }

  @override
  Future<Stream<List<LevelTestTaskModel>>> readTasks() async {
    return firestore
        .collection(FirebaseCollection.testTasks.collectionName)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => LevelTestTaskModel.fromJson(doc.data())).toList());
  }

  @override
  Future<Stream<List<UserModel>>> getAllUserDataTeachers() async {
    return firestore.collection(FirebaseCollection.userData.collectionName).snapshots().map((event) => event.docs
        .map((e) {
          if (e.data()['isTutor']) {
            return UserModel.fromJson(e.data());
          }
        })
        .whereType<UserModel>()
        .toList());
  }

  @override
  Future<UserModel> getCurrentUserData() async {
    if (_firebaseAuth.currentUser != null) {
      final data = await firestore
          .collection(FirebaseCollection.userData.collectionName)
          .where('user_id', isEqualTo: _firebaseAuth.currentUser!.uid)
          .limit(1)
          .get();
      return UserModel.fromJson(data.docs.first.data());
    } else {
      return UserModel.empty();
    }
  }

  @override
  Future<void> createNewTutor(TutorModel tutor) async {
    final CollectionReference tutorInfoTable = firestore.collection(FirebaseCollection.tutor.collectionName);
    await tutorInfoTable.add(tutor.copyWith(userId: _firebaseAuth.currentUser!.uid).toJson());
    SimpleLogger().info('Tutor added');
    final userDataDocToEdit = await firestore
        .collection(FirebaseCollection.userData.collectionName)
        .where('user_id', isEqualTo: _firebaseAuth.currentUser?.uid)
        .limit(1)
        .get();
    final id = userDataDocToEdit.docs.first.id;

    await firestore.collection(FirebaseCollection.userData.collectionName).doc(id).update({'is_tutor': true});
    SimpleLogger().info('User was edited');
  }

  @override
  Future<void> createNewGame(GameModel model) async {
    final CollectionReference gamesTable = firestore.collection(FirebaseCollection.games.collectionName);
    await gamesTable.add(model.copyWith(creatorId: _firebaseAuth.currentUser!.uid, id: Uuid().v1()).toJson());
    SimpleLogger().info('Game added');
  }

  @override
  Future<Stream<List<GameModel>>> getAllPublicGames(int page) async {
    //game is considered public when groups list is empty
    final games = firestore.collection(FirebaseCollection.games.collectionName).where('groups', isEqualTo: []);

    final snapshot = await games.get();
    final count = snapshot.size;
    var amountOfFilesToTake = GameConstants.gamesPerPage;
    if (count < page * GameConstants.gamesPerPage + GameConstants.gamesPerPage) {
      amountOfFilesToTake = count - (page * GameConstants.gamesPerPage);
    }
    final resultStream = games
        .startAtDocument(snapshot.docs.elementAt(page * GameConstants.gamesPerPage))
        .endAtDocument(snapshot.docs.elementAt(page * GameConstants.gamesPerPage + amountOfFilesToTake - 1))
        .snapshots();

    return resultStream.map((event) => event.docs.map((doc) {
          return GameModel.fromJson(doc.data());
        }).toList());
  }

  @override
  Future<GameModel> getGameById(String id) async {
    final res =
        await firestore.collection(FirebaseCollection.games.collectionName).where('id', isEqualTo: id).limit(1).get();
    return GameModel.fromJson(res.docs.first.data());
  }

  @override
  Future<GroupModel> getGroupByCode(String code) async {
    final res = await firestore
        .collection(FirebaseCollection.groups.collectionName)
        .where('code', isEqualTo: code)
        .limit(1)
        .get();
    return GroupModel.fromJson(res.docs.first.data());
  }

  @override
  Future<Stream<List<GroupModel>>> getAllGroupsForCurrentUser({bool mustBeCreator = false}) async {
    final resAsCreator = firestore
        .collection(FirebaseCollection.groups.collectionName)
        .where('creator_id', isEqualTo: _firebaseAuth.currentUser!.uid)
        .snapshots();
    final resAsStudent = mustBeCreator
        ? Stream.empty()
        : firestore
            .collection(FirebaseCollection.groups.collectionName)
            .where('students', arrayContains: _firebaseAuth.currentUser!.uid)
            .snapshots();
    final Stream<List<GroupModel>> res = Rx.combineLatest2(resAsCreator, resAsStudent, (creator, student) {
      final List<GroupModel> listOfGroups = [];
      for (final doc in creator.docs) {
        listOfGroups.add(GroupModel.fromJson(doc.data()));
      }
      for (final doc in student.docs) {
        listOfGroups.add(GroupModel.fromJson(doc.data()));
      }
      return listOfGroups;
    }).asBroadcastStream();

    return res;
  }

  @override
  Future<List<GroupModel>> getCreatedGroupsByCurrentUser() async {
    final resAsCreator = await firestore
        .collection(FirebaseCollection.groups.collectionName)
        .where('creator_id', isEqualTo: _firebaseAuth.currentUser!.uid)
        .get();

    return resAsCreator.docs.map((e) => GroupModel.fromJson(e.data())).toList();
  }

  @override
  Future<void> postGroup(GroupModel group) async {
    final newGroup = group.copyWith(creatorId: _firebaseAuth.currentUser!.uid, code: Uuid().v1());
    await firestore.collection(FirebaseCollection.groups.collectionName).add(newGroup.toJson());
  }

  @override
  Future<TutorModel> getCurrentTutor() async {
    final tutorModelMap = await firestore
        .collection(FirebaseCollection.tutor.collectionName)
        .where('user_id', isEqualTo: _firebaseAuth.currentUser!.uid)
        .limit(1)
        .get();

    return TutorModel.fromJson(tutorModelMap.docs.first.data());
  }

  @override
  Future<GroupFullInfoModel> getFullGroupInfo(GroupModel group) async {
    final resTutor = await firestore
        .collection(FirebaseCollection.tutor.collectionName)
        .where('user_id', isEqualTo: group.creatorId)
        .limit(1)
        .get();

    final resUser = await firestore
        .collection(FirebaseCollection.userData.collectionName)
        .where('user_id', isEqualTo: group.creatorId)
        .limit(1)
        .get();

    final List<UserModel> students = [];
    for (final studentId in group.students) {
      students.add(await _getUserByUserId(studentId));
    }
    return GroupFullInfoModel(
      group,
      TutorModel.fromJson(resTutor.docs.first.data()),
      UserModel.fromJson(resUser.docs.first.data()),
      await getGameByGroupCode(group.code),
      students,
    );
  }

  @override
  Future<Stream<List<JoinRequestFullModel>>> getJoinRequests() async {
    final groupsToCheck = getCreatedGroupsByCurrentUser().asStream();
    final Stream<List<JoinRequestFullModel>> streamOfRequests = groupsToCheck.asyncMap((event) async {
      final List<JoinRequestFullModel> result = [];
      for (final group in event) {
        final requestsList = await firestore
            .collection(FirebaseCollection.joinRequest.collectionName)
            .where('group_id', isEqualTo: group.code)
            .get();
        if (requestsList.docs.isNotEmpty) {
          for (final doc in requestsList.docs) {
            final requestModel = JoinRequestModel.fromJson(doc.data());
            result.add(JoinRequestFullModel(
                group: group,
                user: await _getUserByUserId(requestModel.userId),
                requestDate: requestModel.requestDate,
                id: requestModel.id));
          }
        }
      }
      return result;
    });

    return streamOfRequests.asBroadcastStream();
  }

  Future<UserModel> _getUserByUserId(String userId) async {
    final userResults = await firestore
        .collection(FirebaseCollection.userData.collectionName)
        .where('user_id', isEqualTo: userId)
        .limit(1)
        .get();
    return UserModel.fromJson(userResults.docs.first.data());
  }

  @override
  Future<Stream<List<GameModel>>> getGameByGroupCode(String code) async {
    final Stream<QuerySnapshot<Json>> resultStream =
        firestore.collection(FirebaseCollection.games.collectionName).where('groups', arrayContains: code).snapshots();
    return resultStream.map((event) => event.docs.map((e) => GameModel.fromJson(e.data())).toList());
  }

  @override
  Future<void> requestToJoinTheGroup(String code) async {
    final group = await getGroupByCode(code);
    if (group.students.contains(_firebaseAuth.currentUser!.uid) || group.creatorId == _firebaseAuth.currentUser!.uid) {
      throw 'User is trying to connect to the groups he is already part of.';
    }
    final CollectionReference requestsTable = firestore.collection(FirebaseCollection.joinRequest.collectionName);
    await requestsTable.add(JoinRequestModel(
      groupId: code,
      userId: _firebaseAuth.currentUser!.uid,
      requestDate: DateTime.now(),
      id: Uuid().v1(),
    ).toJson());
    SimpleLogger().info('Request to join the channel is created');
  }

  @override
  Future<void> acceptRequestToJoinTheGroup(JoinRequestFullModel model) async {
    final userDataDocToEdit = await firestore
        .collection(FirebaseCollection.groups.collectionName)
        .where('code', isEqualTo: model.group.code)
        .limit(1)
        .get();
    final oldGroupData = GroupModel.fromJson(userDataDocToEdit.docs.first.data());
    final id = userDataDocToEdit.docs.first.id;

    await firestore.collection(FirebaseCollection.groups.collectionName).doc(id).update({
      'students': [...oldGroupData.students, model.user.userId]
    });

    // if the group was updated - delete the request
    await _deleteRequest(model.id);
  }

  Future _deleteRequest(String id) async {
    final doc = await firestore
        .collection(FirebaseCollection.joinRequest.collectionName)
        .where('id', isEqualTo: id)
        .limit(1)
        .get();
    await firestore.collection(FirebaseCollection.joinRequest.collectionName).doc(doc.docs.first.id).delete();
  }

  @override
  Future<void> declineRequestToJoinTheGroup(String id) async {
    await _deleteRequest(id);
  }

  @override
  Future<void> rateTheGame(GameRate rate) async {
    final game =
        await firestore.collection(FirebaseCollection.games.collectionName).where('id', isEqualTo: rate.gameId).get();

    final gameModel = GameModel.fromJson(game.docs.first.data());
    final double newRate = gameModel.rate == null ? rate.rate : (rate.rate + gameModel.rate!) / 2;
    await firestore
        .collection(FirebaseCollection.games.collectionName)
        .doc(game.docs.first.id)
        .update({'rate': newRate});
  }

  @override
  Future<List<GameModel>> searchGame(GameSearchModel searchModel) async {
    final QuerySnapshot<Json> gamesRes =
        await firestore.collection(FirebaseCollection.games.collectionName).where('groups', isEqualTo: []).get();
    final List<GameModel> allGames = gamesRes.docs.map((e) => GameModel.fromJson(e.data())).toList();
    final List<GameModel> games = [];
    if (searchModel.name.isNotEmpty) {
      games.addAll(allGames.where((element) =>
          element.name.toLowerCase().contains(searchModel.name.toLowerCase()) ||
          searchModel.name.toLowerCase().contains(element.name.toLowerCase())));
    }
    if (searchModel.theme.isNotEmpty) {
      games.addAll(allGames.where((element) => searchModel.theme.contains(element.theme)));
    }
    if (searchModel.level.isNotEmpty) {
      games.addAll(allGames.where((element) => searchModel.level.contains(element.level)));
    }
    return games;
  }

  @override
  Future<int> publicGamesCount() async {
    //game is considered public when groups list is empty
    final games =
        await firestore.collection(FirebaseCollection.games.collectionName).where('groups', isEqualTo: []).get();
    return games.size;
  }

  @override
  Future<List<GameResultFullModel>> getAllGameResults(String gameId) async {
    final results = await firestore
        .collection(FirebaseCollection.gameResult.collectionName)
        .where('game_id', isEqualTo: gameId)
        .get();
    final List<GameResultFullModel> answer = [];

    for (final doc in results.docs) {
      final model = GameResultModel.fromJson(doc.data());
      final UserModel user = await _getUserByUserId(model.userId);
      final GameModel game = await getGameById(model.gameId);
      answer.add(GameResultFullModel(
        user: user,
        game: game,
        result: model.result,
        timeFinished: model.timeFinished,
        errors: model.errors,
      ));
    }

    return answer;
  }

  @override
  Future<void> postGameResult(GameResultModel result) async {
    final CollectionReference gameResultsTable = firestore.collection(FirebaseCollection.gameResult.collectionName);
    await gameResultsTable.add(result.toJson());
    SimpleLogger().info('Game result is posted');
  }

  @override
  Future<List<PassedGameModel>> getPassedGames() async {
    final gameResults = await firestore
        .collection(FirebaseCollection.gameResult.collectionName)
        .where('user_id', isEqualTo: _firebaseAuth.currentUser!.uid)
        .get();

    final List<PassedGameModel> answer = [];
    for (final game in gameResults.docs) {
      answer.add(PassedGameModel(game: await getGameById(game.data()['game_id']), result: game.data()['result']));
    }
    SimpleLogger().info('There was ${gameResults.docs.length} passed by this user games');

    return answer;
  }

  @override
  Future<List<GameModel>> getCreatedGames() async {
    final games = await firestore
        .collection(FirebaseCollection.games.collectionName)
        .where('creator_id', isEqualTo: _firebaseAuth.currentUser!.uid)
        .get();

    SimpleLogger().info('There was ${games.docs.length} created by this user games');

    return games.docs.map((e) => GameModel.fromJson(e.data())).toList();
  }

  @override
  Future<void> deleteStudentFromGroup(StudentGroupModel model) async {
    final userDataDocToEdit = await firestore
        .collection(FirebaseCollection.groups.collectionName)
        .where('code', isEqualTo: model.groupId)
        .limit(1)
        .get();
    final oldGroupData = GroupModel.fromJson(userDataDocToEdit.docs.first.data());
    final id = userDataDocToEdit.docs.first.id;
    final oldStudentList = [...oldGroupData.students];
    oldStudentList.remove(model.userId);
    await firestore.collection(FirebaseCollection.groups.collectionName).doc(id).update({'students': oldStudentList});
  }

  @override
  Future<void> setNewEnglishLevel(EnglishLevel level) async {
    final userDataDocToEdit = await firestore
        .collection(FirebaseCollection.userData.collectionName)
        .where('user_id', isEqualTo: _firebaseAuth.currentUser?.uid)
        .limit(1)
        .get();
    final id = userDataDocToEdit.docs.first.id;

    await firestore.collection(FirebaseCollection.userData.collectionName).doc(id).update({'level': level.name});
  }
}
