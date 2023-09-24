// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorModel _$TutorModelFromJson(Map<String, dynamic> json) => TutorModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      about: json['about'] as String,
      contacts: Map<String, String>.from(json['contacts'] as Map),
      currency: json['currency'] as String,
      preferences: json['preferences'] as String,
      price: (json['price'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$TutorModelToJson(TutorModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'about': instance.about,
      'contacts': instance.contacts,
      'currency': instance.currency,
      'preferences': instance.preferences,
      'price': instance.price,
    };
