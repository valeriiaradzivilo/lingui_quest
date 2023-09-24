// ignore_for_file: deprecated_consistency; invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';
import 'package:lingui_quest/data/models/user_model.dart';

part 'tutor_model.g.dart';

@JsonSerializable()
class TutorModel {
  final UserModel user;
  final String about;
  final Map<String, String> contacts;
  final String currency;
  final String preferences;
  final Map<String, double> price;
  TutorModel({
    required this.user,
    required this.about,
    required this.contacts,
    required this.currency,
    required this.preferences,
    required this.price,
  });
  factory TutorModel.fromJson(Json json) => _$TutorModelFromJson(json);
  Json toJson() => _$TutorModelToJson(this);

  factory TutorModel.empty() =>
      TutorModel(user: UserModel.empty(), about: '', contacts: {}, currency: '', preferences: '', price: {});
  @override
  bool operator ==(other) =>
      other is TutorModel &&
      user == other.user &&
      about == other.about &&
      contacts == other.contacts &&
      currency == other.currency &&
      preferences == other.preferences &&
      price == other.price;
  @override
  int get hashCode => identityHashCode(this);
}
