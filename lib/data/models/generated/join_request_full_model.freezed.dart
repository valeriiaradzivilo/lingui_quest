// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../join_request_full_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JoinRequestFullModel _$JoinRequestFullModelFromJson(Map<String, dynamic> json) {
  return _JoinRequestFullModel.fromJson(json);
}

/// @nodoc
mixin _$JoinRequestFullModel {
  GroupModel get group => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
  DateTime get requestDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JoinRequestFullModelCopyWith<JoinRequestFullModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinRequestFullModelCopyWith<$Res> {
  factory $JoinRequestFullModelCopyWith(JoinRequestFullModel value,
          $Res Function(JoinRequestFullModel) then) =
      _$JoinRequestFullModelCopyWithImpl<$Res, JoinRequestFullModel>;
  @useResult
  $Res call(
      {GroupModel group,
      UserModel user,
      @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
      DateTime requestDate});

  $GroupModelCopyWith<$Res> get group;
}

/// @nodoc
class _$JoinRequestFullModelCopyWithImpl<$Res,
        $Val extends JoinRequestFullModel>
    implements $JoinRequestFullModelCopyWith<$Res> {
  _$JoinRequestFullModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? user = null,
    Object? requestDate = null,
  }) {
    return _then(_value.copyWith(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupModel,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      requestDate: null == requestDate
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupModelCopyWith<$Res> get group {
    return $GroupModelCopyWith<$Res>(_value.group, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JoinRequestFullModelImplCopyWith<$Res>
    implements $JoinRequestFullModelCopyWith<$Res> {
  factory _$$JoinRequestFullModelImplCopyWith(_$JoinRequestFullModelImpl value,
          $Res Function(_$JoinRequestFullModelImpl) then) =
      __$$JoinRequestFullModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GroupModel group,
      UserModel user,
      @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
      DateTime requestDate});

  @override
  $GroupModelCopyWith<$Res> get group;
}

/// @nodoc
class __$$JoinRequestFullModelImplCopyWithImpl<$Res>
    extends _$JoinRequestFullModelCopyWithImpl<$Res, _$JoinRequestFullModelImpl>
    implements _$$JoinRequestFullModelImplCopyWith<$Res> {
  __$$JoinRequestFullModelImplCopyWithImpl(_$JoinRequestFullModelImpl _value,
      $Res Function(_$JoinRequestFullModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? user = null,
    Object? requestDate = null,
  }) {
    return _then(_$JoinRequestFullModelImpl(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupModel,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      requestDate: null == requestDate
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JoinRequestFullModelImpl extends _JoinRequestFullModel {
  const _$JoinRequestFullModelImpl(
      {required this.group,
      required this.user,
      @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
      required this.requestDate})
      : super._();

  factory _$JoinRequestFullModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JoinRequestFullModelImplFromJson(json);

  @override
  final GroupModel group;
  @override
  final UserModel user;
  @override
  @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
  final DateTime requestDate;

  @override
  String toString() {
    return 'JoinRequestFullModel(group: $group, user: $user, requestDate: $requestDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinRequestFullModelImpl &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.requestDate, requestDate) ||
                other.requestDate == requestDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, group, user, requestDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinRequestFullModelImplCopyWith<_$JoinRequestFullModelImpl>
      get copyWith =>
          __$$JoinRequestFullModelImplCopyWithImpl<_$JoinRequestFullModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinRequestFullModelImplToJson(
      this,
    );
  }
}

abstract class _JoinRequestFullModel extends JoinRequestFullModel {
  const factory _JoinRequestFullModel(
      {required final GroupModel group,
      required final UserModel user,
      @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
      required final DateTime requestDate}) = _$JoinRequestFullModelImpl;
  const _JoinRequestFullModel._() : super._();

  factory _JoinRequestFullModel.fromJson(Map<String, dynamic> json) =
      _$JoinRequestFullModelImpl.fromJson;

  @override
  GroupModel get group;
  @override
  UserModel get user;
  @override
  @JsonKey(fromJson: fromTimestamp, toJson: Timestamp.fromDate)
  DateTime get requestDate;
  @override
  @JsonKey(ignore: true)
  _$$JoinRequestFullModelImplCopyWith<_$JoinRequestFullModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
