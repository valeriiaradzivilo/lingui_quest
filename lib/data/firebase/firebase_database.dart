import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lingui_quest/core/extensions/custom_exceptions.dart';
import 'package:lingui_quest/data/models/test_task_model.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:simple_logger/simple_logger.dart';

class FirebaseDatabaseImpl {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
              isTeacher: false));
        } catch (e) {
          rethrow;
        }
        // HiveDatabase.addUserIdToBox(user.uid);
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

  Future<void> saveUserData(UserModel user) async {
    try {
      final CollectionReference userData = firestore.collection('userData');
      await userData.add(user.toJson());
      print('User added');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      SimpleLogger().info('Signed user $email in');
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        // HiveDatabase.addUserIdToBox(user.uid);
        SimpleLogger().info('Created an account for $email');
      } else {
        throw Exception();
      }
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

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();

      // HiveDatabase.cleanUserId();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> crateNewTestTask(TestTaskModel task) async {
    try {
      final CollectionReference testTasks = firestore.collection('testTasks');
      await testTasks.add(task.toJson());
      print('Task added');
    } catch (e) {
      rethrow;
    }
  }

  Future<Stream<List<TestTaskModel>>> readTasks() async {
    try {
      return firestore
          .collection('testTasks')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => TestTaskModel.fromJson(doc.data())).toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<Stream<List<UserModel>>> getAllUserDataTeachers() async {
    try {
      return firestore.collection('userData').snapshots().map((event) => event.docs
          .map((e) {
            if (e.data()['isTeacher']) {
              return UserModel.fromJson(e.data());
            }
          })
          .whereType<UserModel>()
          .toList());
    } catch (e) {
      rethrow;
    }
  }

  // Future<Stream<List<TutorModel>>> getAllTutors() async {
  //   try {
  //     final Stream<List<UserModel>> usersData = await getAllUserDataTeachers();
  //     final Stream<List<Json>> tutorsData =
  //         firestore.collection('tutorInfo').snapshots().map((event) => event.docs.map((e) => e.data()).toList());

  //     return Rx.combineLatest2(
  //       usersData,
  //       tutorsData,
  //       (List<UserModel> users, List<Map<String, dynamic>> tutors) {
  //         final Map<String, UserModel> usersMap = Map.fromEntries(users.map((user) => MapEntry(user.userId, user)));

  //         final List<TutorModel> combinedData = [];
  //         for (final tutor in tutors) {
  //           final userId = tutor['userId'] as String;
  //           final user = usersMap[userId];
  //           if (user != null) {
  //             final Map<String, dynamic> allData = {'user': user.toJson(), ...tutor};
  //             print(allData);
  //             final model = TutorModel.fromJson(allData);
  //             combinedData.add(model);
  //           }
  //         }

  //         return combinedData;
  //       },
  //     ).asBroadcastStream();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<UserModel> getCurrentUserData() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        final data = await firestore
            .collection('userData')
            .where('userId', isEqualTo: _firebaseAuth.currentUser?.uid)
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

  Future<void> createNewTutor(TutorModel tutor) async {
    try {
      final CollectionReference tutorInfoTable = firestore.collection('tutorInfo');
      await tutorInfoTable.add(tutor.toJson());
      print('Tutor added');
      final userDataDocToEdit = await firestore
          .collection('userData')
          .where('userId', isEqualTo: _firebaseAuth.currentUser?.uid)
          .limit(1)
          .get();
      final id = userDataDocToEdit.docs.first.id;

      await firestore.collection('userData').doc(id).update({'isTeacher': true});
      print('User was edited');
    } catch (e) {
      rethrow;
    }
  }
}
