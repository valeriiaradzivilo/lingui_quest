import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:lingui_quest/shared/constants/hive_constants.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabase {
  Future<void> openBox() async {
    if (!kIsWeb && !Hive.isBoxOpen(HiveConstants.currentUserDataBox)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    await Hive.openBox(HiveConstants.currentUserDataBox);
  }

  Future<void> addUserIdToBox(String userId) async {
    final userBox = Hive.box(HiveConstants.currentUserDataBox);
    if (!userBox.isOpen) {
      await openBox();
    }
    if (userBox.isNotEmpty) {
      await userBox.clear();
    }
    await userBox.add(userId);
  }

  Future<void> cleanUserId() async {
    final userBox = Hive.box(HiveConstants.currentUserDataBox);
    if (userBox.isNotEmpty) {
      await userBox.clear();
    }
  }

  Future<bool> isSignedIn() async {
    await openBox();
    final userBox = Hive.box(HiveConstants.currentUserDataBox);
    if (userBox.isOpen && userBox.isNotEmpty) {
      return true;
    }
    return false;
  }
}
