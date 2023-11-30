import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lingui_quest/core/extensions/custom_exceptions.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';
import 'package:lingui_quest/data/data_source/firebase_remote_data_source.dart';
import 'package:lingui_quest/data/firebase/firebase_constants.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
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
  Future<Stream<List<GameModel>>> getAllGames(int page) async {
    try {
      final Stream<QuerySnapshot<Json>> resultStream =
          firestore.collection(FirebaseCollection.games.collectionName).snapshots().skip(page * 10).take(10);
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
  Future<Stream<List<GroupModel>>> getAllGroupsForCurrentUser() async {
    try {
      final resAsCreator = firestore
          .collection(FirebaseCollection.groups.collectionName)
          .where('creator_id', isEqualTo: _firebaseAuth.currentUser!.uid)
          .snapshots();
      final resAsStudent = firestore
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
          .where('userId', isEqualTo: _firebaseAuth.currentUser!.uid)
          .limit(1)
          .get();

      return TutorModel.fromJson(tutorModelMap.docs.first.data());
    } catch (e) {
      rethrow;
    }
  }
}
