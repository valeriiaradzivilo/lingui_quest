import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lingui_quest/core/extensions/custom_exceptions.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';
import 'package:lingui_quest/data/data_source/firebase_remote_data_source.dart';
import 'package:lingui_quest/data/firebase/firebase_constants.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/game_search_model.dart';
import 'package:lingui_quest/data/models/group_full_info.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/join_request_full_model.dart';
import 'package:lingui_quest/data/models/join_request_model.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/rate_game_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';
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
        try {
          await saveUserData(UserModel(
              email: params.email,
              userId: user.uid,
              username: params.email,
              firstName: params.firstName,
              lastName: params.lastName,
              level: EnglishLevel.a1,
              isTutor: false));
        } catch (e) {
          rethrow;
        }

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
    try {
      final CollectionReference userData = firestore.collection(FirebaseCollection.userData.collectionName);
      await userData.add(user.toJson());
      print('User added');
    } catch (e) {
      rethrow;
    }
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
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> crateNewTestTask(LevelTestTaskModel task) async {
    try {
      final CollectionReference testTasks = firestore.collection(FirebaseCollection.testTasks.collectionName);
      await testTasks.add(task.toJson());
      print('Task added');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Stream<List<LevelTestTaskModel>>> readTasks() async {
    try {
      return firestore
          .collection(FirebaseCollection.testTasks.collectionName)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => LevelTestTaskModel.fromJson(doc.data())).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Stream<List<UserModel>>> getAllUserDataTeachers() async {
    try {
      return firestore.collection(FirebaseCollection.userData.collectionName).snapshots().map((event) => event.docs
          .map((e) {
            if (e.data()['isTutor']) {
              return UserModel.fromJson(e.data());
            }
          })
          .whereType<UserModel>()
          .toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getCurrentUserData() async {
    try {
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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createNewTutor(TutorModel tutor) async {
    try {
      final CollectionReference tutorInfoTable = firestore.collection(FirebaseCollection.tutor.collectionName);
      await tutorInfoTable.add(tutor.copyWith(userId: _firebaseAuth.currentUser!.uid).toJson());
      print('Tutor added');
      final userDataDocToEdit = await firestore
          .collection(FirebaseCollection.userData.collectionName)
          .where('user_id', isEqualTo: _firebaseAuth.currentUser?.uid)
          .limit(1)
          .get();
      final id = userDataDocToEdit.docs.first.id;

      await firestore.collection(FirebaseCollection.userData.collectionName).doc(id).update({'is_tutor': true});
      print('User was edited');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createNewGame(GameModel model) async {
    try {
      final CollectionReference gamesTable = firestore.collection(FirebaseCollection.games.collectionName);
      await gamesTable.add(model.copyWith(creatorId: _firebaseAuth.currentUser!.uid, id: Uuid().v1()).toJson());
      print('Game added');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Stream<List<GameModel>>> getAllPublicGames(int page) async {
    try {
      //game is considered public when groups list is empty
      final Stream<QuerySnapshot<Json>> resultStream = firestore
          .collection(FirebaseCollection.games.collectionName)
          .where('groups', isEqualTo: [])
          .snapshots()
          .skip(page * 5)
          .take(5);
      return resultStream.map((event) => event.docs.map((doc) {
            return GameModel.fromJson(doc.data());
          }).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GameModel> getGameById(String id) async {
    try {
      final res =
          await firestore.collection(FirebaseCollection.games.collectionName).where('id', isEqualTo: id).limit(1).get();
      return GameModel.fromJson(res.docs.first.data());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GroupModel> getGroupByCode(String code) async {
    try {
      final res = await firestore
          .collection(FirebaseCollection.groups.collectionName)
          .where('code', isEqualTo: code)
          .limit(1)
          .get();
      return GroupModel.fromJson(res.docs.first.data());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Stream<List<GroupModel>>> getAllGroupsForCurrentUser({bool mustBeCreator = false}) async {
    try {
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
    } catch (e) {
      rethrow;
    }
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
    try {
      final newGroup = group.copyWith(creatorId: _firebaseAuth.currentUser!.uid, code: Uuid().v1());
      await firestore.collection(FirebaseCollection.groups.collectionName).add(newGroup.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TutorModel> getCurrentTutor() async {
    try {
      final tutorModelMap = await firestore
          .collection(FirebaseCollection.tutor.collectionName)
          .where('user_id', isEqualTo: _firebaseAuth.currentUser!.uid)
          .limit(1)
          .get();

      return TutorModel.fromJson(tutorModelMap.docs.first.data());
    } catch (e) {
      rethrow;
    }
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
    return GroupFullInfoModel(
      group,
      TutorModel.fromJson(resTutor.docs.first.data()),
      UserModel.fromJson(resUser.docs.first.data()),
      await getGameByGroupCode(group.code),
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
    final CollectionReference requestsTable = firestore.collection(FirebaseCollection.joinRequest.collectionName);
    await requestsTable.add(JoinRequestModel(
      groupId: code,
      userId: _firebaseAuth.currentUser!.uid,
      requestDate: DateTime.now(),
      id: Uuid().v1(),
    ).toJson());
    print('Request to join the channel is created');
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
  Future<void> getMyGames() {
    // TODO: implement getMyGames
    throw UnimplementedError();
  }

  @override
  Future<void> postGameResult(String id) {
    // TODO: implement postGameResult
    throw UnimplementedError();
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
}
