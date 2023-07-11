import 'package:hive/hive.dart';
import 'package:lingui_quest/shared/constants/hive_constants.dart';

class HiveDatabase {
  Future<void> openBox() async {
    await Hive.openBox(HiveConstants.currentUserDataBox);
  }

  // Future<void> addUserIdToBox(String userId) {
  //   final _userBox = Hive.box(HiveConstants.currentUserDataBox);

  // }
}
