// ignore_for_file: deprecated_consistency; invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';

part 'generated/tutor_model.g.dart';

@JsonSerializable()
class TutorModel {
  final String userId;
  final String about;
  final Map<String, String> contacts;
  final String currency;
  final String preferences;
  final Map<String, double> price;
  TutorModel({
    required this.userId,
    required this.about,
    required this.contacts,
    required this.currency,
    required this.preferences,
    required this.price,
  });
  factory TutorModel.fromJson(Json json) => _$TutorModelFromJson(json);
  Json toJson() => _$TutorModelToJson(this);

  factory TutorModel.empty() =>
      TutorModel(userId: '', about: '', contacts: {}, currency: '', preferences: '', price: {});
  @override
  bool operator ==(other) =>
      other is TutorModel &&
      userId == other.userId &&
      about == other.about &&
      contacts == other.contacts &&
      currency == other.currency &&
      preferences == other.preferences &&
      price == other.price;
  @override
  int get hashCode => identityHashCode(this);
}
