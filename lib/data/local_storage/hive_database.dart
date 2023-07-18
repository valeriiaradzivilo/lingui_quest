import 'package:hive/hive.dart';
import 'package:lingui_quest/shared/constants/hive_constants.dart';

class HiveDatabase {
  Future<void> openBox() async {
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
    await Hive.openBox(HiveConstants.currentUserDataBox);
    final userBox = Hive.box(HiveConstants.currentUserDataBox);
    if (userBox.isOpen && userBox.isNotEmpty) {
      return true;
    }
    return false;
  }
}
