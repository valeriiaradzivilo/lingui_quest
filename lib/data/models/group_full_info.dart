import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';

class GroupFullInfoModel {
  final GroupModel group;
  final TutorModel tutor;
  final UserModel tutorUserData;
  final Stream<List<GameModel>> games;
  final List<UserModel> students;

  GroupFullInfoModel(this.group, this.tutor, this.tutorUserData, this.games, this.students);

  factory GroupFullInfoModel.empty() =>
      GroupFullInfoModel(GroupModel.empty(), TutorModel.empty(), UserModel.empty(), Stream.empty(), []);

  bool get isEmpty =>
      group == GroupModel.empty() &&
      tutor == TutorModel.empty() &&
      tutorUserData == UserModel.empty() &&
      students.isEmpty;
}
