// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      level: $enumDecode(_$EnglishLevelEnumMap, json['level']),
      isTeacher: json['isTeacher'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'level': _$EnglishLevelEnumMap[instance.level]!,
      'isTeacher': instance.isTeacher,
    };

const _$EnglishLevelEnumMap = {
  EnglishLevel.a1: 'a1',
  EnglishLevel.a2: 'a2',
  EnglishLevel.b1: 'b1',
  EnglishLevel.b2: 'b2',
  EnglishLevel.c1: 'c1',
  EnglishLevel.c2: 'c2',
};
