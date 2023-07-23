import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:lingui_quest/shared/constants/hive_constants.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabase {
  static Future<void> openBox() async {
    if (!kIsWeb && !Hive.isBoxOpen(HiveConstants.currentUserDataBox)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    await Hive.openBox(HiveConstants.currentUserDataBox);
    print(Hive.box(HiveConstants.currentUserDataBox).values.toString());
  }

  static Future<void> addUserIdToBox(String userId) async {
    final userBox = Hive.box(HiveConstants.currentUserDataBox);
    if (!userBox.isOpen) {
      await openBox();
    }
    if (userBox.isNotEmpty) {
      await userBox.clear();
    }
    await userBox.add(userId);
    print(userBox.values.toString());
  }

  static Future<void> cleanUserId() async {
    final userBox = Hive.box(HiveConstants.currentUserDataBox);
    if (userBox.isNotEmpty) {
      await userBox.clear();
    }
  }

  static Future<bool> isSignedIn() async {
    await openBox();
    final userBox = Hive.box(HiveConstants.currentUserDataBox);
    print(userBox.values.toString());
    if (userBox.isOpen && userBox.isNotEmpty) {
      return true;
    }
    return false;
  }
}
