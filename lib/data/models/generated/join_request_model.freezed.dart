// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../join_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JoinRequestModel _$JoinRequestModelFromJson(Map<String, dynamic> json) {
  return _JoinRequestModel.fromJson(json);
}

/// @nodoc
mixin _$JoinRequestModel {
  String get groupId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
  DateTime get requestDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JoinRequestModelCopyWith<JoinRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinRequestModelCopyWith<$Res> {
  factory $JoinRequestModelCopyWith(
          JoinRequestModel value, $Res Function(JoinRequestModel) then) =
      _$JoinRequestModelCopyWithImpl<$Res, JoinRequestModel>;
  @useResult
  $Res call(
      {String groupId,
      String userId,
      @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
      DateTime requestDate});
}

/// @nodoc
class _$JoinRequestModelCopyWithImpl<$Res, $Val extends JoinRequestModel>
    implements $JoinRequestModelCopyWith<$Res> {
  _$JoinRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? userId = null,
    Object? requestDate = null,
  }) {
    return _then(_value.copyWith(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      requestDate: null == requestDate
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JoinRequestModelImplCopyWith<$Res>
    implements $JoinRequestModelCopyWith<$Res> {
  factory _$$JoinRequestModelImplCopyWith(_$JoinRequestModelImpl value,
          $Res Function(_$JoinRequestModelImpl) then) =
      __$$JoinRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String groupId,
      String userId,
      @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
      DateTime requestDate});
}

/// @nodoc
class __$$JoinRequestModelImplCopyWithImpl<$Res>
    extends _$JoinRequestModelCopyWithImpl<$Res, _$JoinRequestModelImpl>
    implements _$$JoinRequestModelImplCopyWith<$Res> {
  __$$JoinRequestModelImplCopyWithImpl(_$JoinRequestModelImpl _value,
      $Res Function(_$JoinRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? userId = null,
    Object? requestDate = null,
  }) {
    return _then(_$JoinRequestModelImpl(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      requestDate: null == requestDate
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JoinRequestModelImpl extends _JoinRequestModel {
  const _$JoinRequestModelImpl(
      {required this.groupId,
      required this.userId,
      @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
      required this.requestDate})
      : super._();

  factory _$JoinRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JoinRequestModelImplFromJson(json);

  @override
  final String groupId;
  @override
  final String userId;
  @override
  @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
  final DateTime requestDate;

  @override
  String toString() {
    return 'JoinRequestModel(groupId: $groupId, userId: $userId, requestDate: $requestDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinRequestModelImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.requestDate, requestDate) ||
                other.requestDate == requestDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, groupId, userId, requestDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinRequestModelImplCopyWith<_$JoinRequestModelImpl> get copyWith =>
      __$$JoinRequestModelImplCopyWithImpl<_$JoinRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinRequestModelImplToJson(
      this,
    );
  }
}

abstract class _JoinRequestModel extends JoinRequestModel {
  const factory _JoinRequestModel(
      {required final String groupId,
      required final String userId,
      @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
      required final DateTime requestDate}) = _$JoinRequestModelImpl;
  const _JoinRequestModel._() : super._();

  factory _JoinRequestModel.fromJson(Map<String, dynamic> json) =
      _$JoinRequestModelImpl.fromJson;

  @override
  String get groupId;
  @override
  String get userId;
  @override
  @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
  DateTime get requestDate;
  @override
  @JsonKey(ignore: true)
  _$$JoinRequestModelImplCopyWith<_$JoinRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
