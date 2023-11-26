// ignore_for_file: deprecated_consistency; invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';

part 'generated/user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String userId;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final EnglishLevel level;
  final bool isTutor;
  UserModel(
      {required this.userId,
      required this.username,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.level,
      required this.isTutor});
  factory UserModel.fromJson(Json json) => _$UserModelFromJson(json);
  Json toJson() => _$UserModelToJson(this);

  factory UserModel.empty() => UserModel(
      userId: '', username: '', email: '', firstName: '', lastName: '', level: EnglishLevel.a1, isTutor: false);
  @override
  bool operator ==(other) =>
      other is UserModel &&
      userId == other.userId &&
      username == other.username &&
      email == other.email &&
      firstName == other.firstName &&
      lastName == other.lastName &&
      level == other.level &&
      isTutor == other.isTutor;
  @override
  int get hashCode => identityHashCode(this);
}
