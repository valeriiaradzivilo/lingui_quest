// ignore_for_file: deprecated_consistency; invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int userId;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  UserModel(this.userId, this.username, this.email, this.firstName, this.lastName);
  factory UserModel.fromJson(Json json) => _$UserModelFromJson(json);
  Json toJson() => _$UserModelToJson(this);
}
