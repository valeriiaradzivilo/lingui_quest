// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../game_search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameSearchModel {
  String get name =>
      throw _privateConstructorUsedError; // text that will be looked up in a name or description
  List<EnglishLevel> get level => throw _privateConstructorUsedError;
  List<String> get theme => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameSearchModelCopyWith<GameSearchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameSearchModelCopyWith<$Res> {
  factory $GameSearchModelCopyWith(
          GameSearchModel value, $Res Function(GameSearchModel) then) =
      _$GameSearchModelCopyWithImpl<$Res, GameSearchModel>;
  @useResult
  $Res call({String name, List<EnglishLevel> level, List<String> theme});
}

/// @nodoc
class _$GameSearchModelCopyWithImpl<$Res, $Val extends GameSearchModel>
    implements $GameSearchModelCopyWith<$Res> {
  _$GameSearchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? level = null,
    Object? theme = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as List<EnglishLevel>,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameSearchModelImplCopyWith<$Res>
    implements $GameSearchModelCopyWith<$Res> {
  factory _$$GameSearchModelImplCopyWith(_$GameSearchModelImpl value,
          $Res Function(_$GameSearchModelImpl) then) =
      __$$GameSearchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<EnglishLevel> level, List<String> theme});
}

/// @nodoc
class __$$GameSearchModelImplCopyWithImpl<$Res>
    extends _$GameSearchModelCopyWithImpl<$Res, _$GameSearchModelImpl>
    implements _$$GameSearchModelImplCopyWith<$Res> {
  __$$GameSearchModelImplCopyWithImpl(
      _$GameSearchModelImpl _value, $Res Function(_$GameSearchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? level = null,
    Object? theme = null,
  }) {
    return _then(_$GameSearchModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value._level
          : level // ignore: cast_nullable_to_non_nullable
              as List<EnglishLevel>,
      theme: null == theme
          ? _value._theme
          : theme // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$GameSearchModelImpl extends _GameSearchModel {
  const _$GameSearchModelImpl(
      {required this.name,
      required final List<EnglishLevel> level,
      required final List<String> theme})
      : _level = level,
        _theme = theme,
        super._();

  @override
  final String name;
// text that will be looked up in a name or description
  final List<EnglishLevel> _level;
// text that will be looked up in a name or description
  @override
  List<EnglishLevel> get level {
    if (_level is EqualUnmodifiableListView) return _level;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_level);
  }

  final List<String> _theme;
  @override
  List<String> get theme {
    if (_theme is EqualUnmodifiableListView) return _theme;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_theme);
  }

  @override
  String toString() {
    return 'GameSearchModel(name: $name, level: $level, theme: $theme)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameSearchModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._level, _level) &&
            const DeepCollectionEquality().equals(other._theme, _theme));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_level),
      const DeepCollectionEquality().hash(_theme));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameSearchModelImplCopyWith<_$GameSearchModelImpl> get copyWith =>
      __$$GameSearchModelImplCopyWithImpl<_$GameSearchModelImpl>(
          this, _$identity);
}

abstract class _GameSearchModel extends GameSearchModel {
  const factory _GameSearchModel(
      {required final String name,
      required final List<EnglishLevel> level,
      required final List<String> theme}) = _$GameSearchModelImpl;
  const _GameSearchModel._() : super._();

  @override
  String get name;
  @override // text that will be looked up in a name or description
  List<EnglishLevel> get level;
  @override
  List<String> get theme;
  @override
  @JsonKey(ignore: true)
  _$$GameSearchModelImplCopyWith<_$GameSearchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
