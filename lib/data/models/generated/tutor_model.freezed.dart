// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../tutor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TutorModel _$TutorModelFromJson(Map<String, dynamic> json) {
  return _TutorModel.fromJson(json);
}

/// @nodoc
mixin _$TutorModel {
  String get userId => throw _privateConstructorUsedError;
  String get about => throw _privateConstructorUsedError;
  Map<String, String> get contacts => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get preferences => throw _privateConstructorUsedError;
  Map<String, double> get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TutorModelCopyWith<TutorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TutorModelCopyWith<$Res> {
  factory $TutorModelCopyWith(
          TutorModel value, $Res Function(TutorModel) then) =
      _$TutorModelCopyWithImpl<$Res, TutorModel>;
  @useResult
  $Res call(
      {String userId,
      String about,
      Map<String, String> contacts,
      String currency,
      String preferences,
      Map<String, double> price});
}

/// @nodoc
class _$TutorModelCopyWithImpl<$Res, $Val extends TutorModel>
    implements $TutorModelCopyWith<$Res> {
  _$TutorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? about = null,
    Object? contacts = null,
    Object? currency = null,
    Object? preferences = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      about: null == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String,
      contacts: null == contacts
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TutorModelImplCopyWith<$Res>
    implements $TutorModelCopyWith<$Res> {
  factory _$$TutorModelImplCopyWith(
          _$TutorModelImpl value, $Res Function(_$TutorModelImpl) then) =
      __$$TutorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String about,
      Map<String, String> contacts,
      String currency,
      String preferences,
      Map<String, double> price});
}

/// @nodoc
class __$$TutorModelImplCopyWithImpl<$Res>
    extends _$TutorModelCopyWithImpl<$Res, _$TutorModelImpl>
    implements _$$TutorModelImplCopyWith<$Res> {
  __$$TutorModelImplCopyWithImpl(
      _$TutorModelImpl _value, $Res Function(_$TutorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? about = null,
    Object? contacts = null,
    Object? currency = null,
    Object? preferences = null,
    Object? price = null,
  }) {
    return _then(_$TutorModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      about: null == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String,
      contacts: null == contacts
          ? _value._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value._price
          : price // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TutorModelImpl extends _TutorModel {
  const _$TutorModelImpl(
      {required this.userId,
      required this.about,
      required final Map<String, String> contacts,
      required this.currency,
      required this.preferences,
      required final Map<String, double> price})
      : _contacts = contacts,
        _price = price,
        super._();

  factory _$TutorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TutorModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String about;
  final Map<String, String> _contacts;
  @override
  Map<String, String> get contacts {
    if (_contacts is EqualUnmodifiableMapView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_contacts);
  }

  @override
  final String currency;
  @override
  final String preferences;
  final Map<String, double> _price;
  @override
  Map<String, double> get price {
    if (_price is EqualUnmodifiableMapView) return _price;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_price);
  }

  @override
  String toString() {
    return 'TutorModel(userId: $userId, about: $about, contacts: $contacts, currency: $currency, preferences: $preferences, price: $price)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TutorModelImplCopyWith<_$TutorModelImpl> get copyWith =>
      __$$TutorModelImplCopyWithImpl<_$TutorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TutorModelImplToJson(
      this,
    );
  }
}

abstract class _TutorModel extends TutorModel {
  const factory _TutorModel(
      {required final String userId,
      required final String about,
      required final Map<String, String> contacts,
      required final String currency,
      required final String preferences,
      required final Map<String, double> price}) = _$TutorModelImpl;
  const _TutorModel._() : super._();

  factory _TutorModel.fromJson(Map<String, dynamic> json) =
      _$TutorModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get about;
  @override
  Map<String, String> get contacts;
  @override
  String get currency;
  @override
  String get preferences;
  @override
  Map<String, double> get price;
  @override
  @JsonKey(ignore: true)
  _$$TutorModelImplCopyWith<_$TutorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
