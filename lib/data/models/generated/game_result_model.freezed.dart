// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../game_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameResultModel _$GameResultModelFromJson(Map<String, dynamic> json) {
  return _GameResultModel.fromJson(json);
}

/// @nodoc
mixin _$GameResultModel {
  String get userId => throw _privateConstructorUsedError;
  String get gameId => throw _privateConstructorUsedError;
  double get result => throw _privateConstructorUsedError;
  int get timeFinished => throw _privateConstructorUsedError;
  List<GameErrorModel> get errors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameResultModelCopyWith<GameResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameResultModelCopyWith<$Res> {
  factory $GameResultModelCopyWith(
          GameResultModel value, $Res Function(GameResultModel) then) =
      _$GameResultModelCopyWithImpl<$Res, GameResultModel>;
  @useResult
  $Res call(
      {String userId,
      String gameId,
      double result,
      int timeFinished,
      List<GameErrorModel> errors});
}

/// @nodoc
class _$GameResultModelCopyWithImpl<$Res, $Val extends GameResultModel>
    implements $GameResultModelCopyWith<$Res> {
  _$GameResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? gameId = null,
    Object? result = null,
    Object? timeFinished = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as double,
      timeFinished: null == timeFinished
          ? _value.timeFinished
          : timeFinished // ignore: cast_nullable_to_non_nullable
              as int,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<GameErrorModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameResultModelImplCopyWith<$Res>
    implements $GameResultModelCopyWith<$Res> {
  factory _$$GameResultModelImplCopyWith(_$GameResultModelImpl value,
          $Res Function(_$GameResultModelImpl) then) =
      __$$GameResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String gameId,
      double result,
      int timeFinished,
      List<GameErrorModel> errors});
}

/// @nodoc
class __$$GameResultModelImplCopyWithImpl<$Res>
    extends _$GameResultModelCopyWithImpl<$Res, _$GameResultModelImpl>
    implements _$$GameResultModelImplCopyWith<$Res> {
  __$$GameResultModelImplCopyWithImpl(
      _$GameResultModelImpl _value, $Res Function(_$GameResultModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? gameId = null,
    Object? result = null,
    Object? timeFinished = null,
    Object? errors = null,
  }) {
    return _then(_$GameResultModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as double,
      timeFinished: null == timeFinished
          ? _value.timeFinished
          : timeFinished // ignore: cast_nullable_to_non_nullable
              as int,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<GameErrorModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameResultModelImpl implements _GameResultModel {
  const _$GameResultModelImpl(
      {required this.userId,
      required this.gameId,
      required this.result,
      required this.timeFinished,
      required final List<GameErrorModel> errors})
      : _errors = errors;

  factory _$GameResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameResultModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String gameId;
  @override
  final double result;
  @override
  final int timeFinished;
  final List<GameErrorModel> _errors;
  @override
  List<GameErrorModel> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'GameResultModel(userId: $userId, gameId: $gameId, result: $result, timeFinished: $timeFinished, errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameResultModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.timeFinished, timeFinished) ||
                other.timeFinished == timeFinished) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, gameId, result,
      timeFinished, const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameResultModelImplCopyWith<_$GameResultModelImpl> get copyWith =>
      __$$GameResultModelImplCopyWithImpl<_$GameResultModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameResultModelImplToJson(
      this,
    );
  }
}

abstract class _GameResultModel implements GameResultModel {
  const factory _GameResultModel(
      {required final String userId,
      required final String gameId,
      required final double result,
      required final int timeFinished,
      required final List<GameErrorModel> errors}) = _$GameResultModelImpl;

  factory _GameResultModel.fromJson(Map<String, dynamic> json) =
      _$GameResultModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get gameId;
  @override
  double get result;
  @override
  int get timeFinished;
  @override
  List<GameErrorModel> get errors;
  @override
  @JsonKey(ignore: true)
  _$$GameResultModelImplCopyWith<_$GameResultModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
