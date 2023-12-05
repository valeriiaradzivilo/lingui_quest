import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';

part 'generated/tutor_model.freezed.dart';
part 'generated/tutor_model.g.dart';

@freezed
class TutorModel with _$TutorModel {
  const factory TutorModel({
    required String userId,
    required String about,
    required Map<String, String> contacts,
    required String currency,
    required String preferences,
    required Map<String, double> price,
  }) = _TutorModel;

  const TutorModel._();

  factory TutorModel.fromJson(Json json) => _$TutorModelFromJson(json);

  factory TutorModel.empty() =>
      TutorModel(userId: '', about: '', contacts: {}, currency: '', preferences: '', price: {});

  @override
  bool operator ==(other) =>
      other is TutorModel &&
      userId == other.userId &&
      about == other.about &&
      DeepCollectionEquality().equals(contacts, other.contacts) &&
      currency == other.currency &&
      preferences == other.preferences &&
      DeepCollectionEquality().equals(price, other.price);
  @override
  int get hashCode => identityHashCode(this);
}
