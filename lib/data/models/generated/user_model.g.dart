// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['user_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      level: $enumDecode(_$EnglishLevelEnumMap, json['level']),
      isTutor: json['is_tutor'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'level': _$EnglishLevelEnumMap[instance.level]!,
      'is_tutor': instance.isTutor,
    };

const _$EnglishLevelEnumMap = {
  EnglishLevel.a1: 'a1',
  EnglishLevel.a2: 'a2',
  EnglishLevel.b1: 'b1',
  EnglishLevel.b2: 'b2',
  EnglishLevel.c1: 'c1',
  EnglishLevel.c2: 'c2',
};
