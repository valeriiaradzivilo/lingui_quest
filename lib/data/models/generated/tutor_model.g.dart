// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tutor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TutorModelImpl _$$TutorModelImplFromJson(Map<String, dynamic> json) =>
    _$TutorModelImpl(
      userId: json['user_id'] as String,
      about: json['about'] as String,
      contacts: Map<String, String>.from(json['contacts'] as Map),
      currency: json['currency'] as String,
      preferences: json['preferences'] as String,
      price: (json['price'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$$TutorModelImplToJson(_$TutorModelImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'about': instance.about,
      'contacts': instance.contacts,
      'currency': instance.currency,
      'preferences': instance.preferences,
      'price': instance.price,
    };
