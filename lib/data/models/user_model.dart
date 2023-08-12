// ignore_for_file: deprecated_consistency; invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String userId;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  UserModel(
      {required this.userId,
      required this.username,
      required this.email,
      required this.firstName,
      required this.lastName});
  factory UserModel.fromJson(Json json) => _$UserModelFromJson(json);
  Json toJson() => _$UserModelToJson(this);

  factory UserModel.empty() => UserModel(userId: '', username: '', email: '', firstName: '', lastName: '');
}
