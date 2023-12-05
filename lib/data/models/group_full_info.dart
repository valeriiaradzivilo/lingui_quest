import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';

class GroupFullInfoModel {
  final GroupModel group;
  final TutorModel tutor;
  final UserModel tutorUserData;

  GroupFullInfoModel(this.group, this.tutor, this.tutorUserData);
}
