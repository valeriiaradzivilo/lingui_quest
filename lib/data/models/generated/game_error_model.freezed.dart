// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../game_error_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameErrorModel _$GameErrorModelFromJson(Map<String, dynamic> json) {
  return _GameErrorModel.fromJson(json);
}

/// @nodoc
mixin _$GameErrorModel {
  QuestionModel get question => throw _privateConstructorUsedError;
  String get expectedResult => throw _privateConstructorUsedError;
  String get actualResult => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameErrorModelCopyWith<GameErrorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameErrorModelCopyWith<$Res> {
  factory $GameErrorModelCopyWith(
          GameErrorModel value, $Res Function(GameErrorModel) then) =
      _$GameErrorModelCopyWithImpl<$Res, GameErrorModel>;
  @useResult
  $Res call(
      {QuestionModel question, String expectedResult, String actualResult});

  $QuestionModelCopyWith<$Res> get question;
}

/// @nodoc
class _$GameErrorModelCopyWithImpl<$Res, $Val extends GameErrorModel>
    implements $GameErrorModelCopyWith<$Res> {
  _$GameErrorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? expectedResult = null,
    Object? actualResult = null,
  }) {
    return _then(_value.copyWith(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as QuestionModel,
      expectedResult: null == expectedResult
          ? _value.expectedResult
          : expectedResult // ignore: cast_nullable_to_non_nullable
              as String,
      actualResult: null == actualResult
          ? _value.actualResult
          : actualResult // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QuestionModelCopyWith<$Res> get question {
    return $QuestionModelCopyWith<$Res>(_value.question, (value) {
      return _then(_value.copyWith(question: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameErrorModelImplCopyWith<$Res>
    implements $GameErrorModelCopyWith<$Res> {
  factory _$$GameErrorModelImplCopyWith(_$GameErrorModelImpl value,
          $Res Function(_$GameErrorModelImpl) then) =
      __$$GameErrorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {QuestionModel question, String expectedResult, String actualResult});

  @override
  $QuestionModelCopyWith<$Res> get question;
}

/// @nodoc
class __$$GameErrorModelImplCopyWithImpl<$Res>
    extends _$GameErrorModelCopyWithImpl<$Res, _$GameErrorModelImpl>
    implements _$$GameErrorModelImplCopyWith<$Res> {
  __$$GameErrorModelImplCopyWithImpl(
      _$GameErrorModelImpl _value, $Res Function(_$GameErrorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? expectedResult = null,
    Object? actualResult = null,
  }) {
    return _then(_$GameErrorModelImpl(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as QuestionModel,
      expectedResult: null == expectedResult
          ? _value.expectedResult
          : expectedResult // ignore: cast_nullable_to_non_nullable
              as String,
      actualResult: null == actualResult
          ? _value.actualResult
          : actualResult // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameErrorModelImpl implements _GameErrorModel {
  const _$GameErrorModelImpl(
      {required this.question,
      required this.expectedResult,
      required this.actualResult});

  factory _$GameErrorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameErrorModelImplFromJson(json);

  @override
  final QuestionModel question;
  @override
  final String expectedResult;
  @override
  final String actualResult;

  @override
  String toString() {
    return 'GameErrorModel(question: $question, expectedResult: $expectedResult, actualResult: $actualResult)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameErrorModelImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.expectedResult, expectedResult) ||
                other.expectedResult == expectedResult) &&
            (identical(other.actualResult, actualResult) ||
                other.actualResult == actualResult));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, question, expectedResult, actualResult);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameErrorModelImplCopyWith<_$GameErrorModelImpl> get copyWith =>
      __$$GameErrorModelImplCopyWithImpl<_$GameErrorModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameErrorModelImplToJson(
      this,
    );
  }
}

abstract class _GameErrorModel implements GameErrorModel {
  const factory _GameErrorModel(
      {required final QuestionModel question,
      required final String expectedResult,
      required final String actualResult}) = _$GameErrorModelImpl;

  factory _GameErrorModel.fromJson(Map<String, dynamic> json) =
      _$GameErrorModelImpl.fromJson;

  @override
  QuestionModel get question;
  @override
  String get expectedResult;
  @override
  String get actualResult;
  @override
  @JsonKey(ignore: true)
  _$$GameErrorModelImplCopyWith<_$GameErrorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
