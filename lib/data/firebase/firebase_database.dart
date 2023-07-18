import 'package:firebase_auth/firebase_auth.dart';
import 'package:lingui_quest/core/extentions/custom_exceptions.dart';
import 'package:lingui_quest/data/local_storage/hive_database.dart';
import 'package:simple_logger/simple_logger.dart';

class FirebaseDatabaseImpl {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        HiveDatabase().addUserIdToBox(user.uid);
        SimpleLogger().info('Created an account for $email');
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      SimpleLogger().shout('Could not create an account for $email');
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw AccountAlreadyExistsException();
      }
    } catch (e) {
      SimpleLogger().shout('Could not create an account for $email');
      rethrow;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      SimpleLogger().info('Signed user $email in');
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        HiveDatabase().addUserIdToBox(user.uid);
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
      HiveDatabase().cleanUserId();
    } catch (e) {
      rethrow;
    }
  }
}
