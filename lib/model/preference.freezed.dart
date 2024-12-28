// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Preference _$PreferenceFromJson(Map<String, dynamic> json) {
  return _Preference.fromJson(json);
}

/// @nodoc
mixin _$Preference {
  int get notificationState =>
      throw _privateConstructorUsedError; //Notification OnとOffと未設定の区分情報
  DateTime get lastLoginDate =>
      throw _privateConstructorUsedError; //LastLogin(次回に使う)
  bool get browserState => throw _privateConstructorUsedError; //ブラウザの設定情報(未使用)
  bool get introductionState =>
      throw _privateConstructorUsedError; //初期イントロを表示したかの設定情報
  String get tokenId =>
      throw _privateConstructorUsedError; // 通知のトークン（登録されている場合）
  String get appleToken => throw _privateConstructorUsedError;

  /// Serializes this Preference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Preference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreferenceCopyWith<Preference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferenceCopyWith<$Res> {
  factory $PreferenceCopyWith(
          Preference value, $Res Function(Preference) then) =
      _$PreferenceCopyWithImpl<$Res, Preference>;
  @useResult
  $Res call(
      {int notificationState,
      DateTime lastLoginDate,
      bool browserState,
      bool introductionState,
      String tokenId,
      String appleToken});
}

/// @nodoc
class _$PreferenceCopyWithImpl<$Res, $Val extends Preference>
    implements $PreferenceCopyWith<$Res> {
  _$PreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Preference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationState = null,
    Object? lastLoginDate = null,
    Object? browserState = null,
    Object? introductionState = null,
    Object? tokenId = null,
    Object? appleToken = null,
  }) {
    return _then(_value.copyWith(
      notificationState: null == notificationState
          ? _value.notificationState
          : notificationState // ignore: cast_nullable_to_non_nullable
              as int,
      lastLoginDate: null == lastLoginDate
          ? _value.lastLoginDate
          : lastLoginDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      browserState: null == browserState
          ? _value.browserState
          : browserState // ignore: cast_nullable_to_non_nullable
              as bool,
      introductionState: null == introductionState
          ? _value.introductionState
          : introductionState // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      appleToken: null == appleToken
          ? _value.appleToken
          : appleToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreferenceImplCopyWith<$Res>
    implements $PreferenceCopyWith<$Res> {
  factory _$$PreferenceImplCopyWith(
          _$PreferenceImpl value, $Res Function(_$PreferenceImpl) then) =
      __$$PreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int notificationState,
      DateTime lastLoginDate,
      bool browserState,
      bool introductionState,
      String tokenId,
      String appleToken});
}

/// @nodoc
class __$$PreferenceImplCopyWithImpl<$Res>
    extends _$PreferenceCopyWithImpl<$Res, _$PreferenceImpl>
    implements _$$PreferenceImplCopyWith<$Res> {
  __$$PreferenceImplCopyWithImpl(
      _$PreferenceImpl _value, $Res Function(_$PreferenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Preference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationState = null,
    Object? lastLoginDate = null,
    Object? browserState = null,
    Object? introductionState = null,
    Object? tokenId = null,
    Object? appleToken = null,
  }) {
    return _then(_$PreferenceImpl(
      notificationState: null == notificationState
          ? _value.notificationState
          : notificationState // ignore: cast_nullable_to_non_nullable
              as int,
      lastLoginDate: null == lastLoginDate
          ? _value.lastLoginDate
          : lastLoginDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      browserState: null == browserState
          ? _value.browserState
          : browserState // ignore: cast_nullable_to_non_nullable
              as bool,
      introductionState: null == introductionState
          ? _value.introductionState
          : introductionState // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      appleToken: null == appleToken
          ? _value.appleToken
          : appleToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferenceImpl extends _Preference {
  const _$PreferenceImpl(
      {required this.notificationState,
      required this.lastLoginDate,
      this.browserState = false,
      this.introductionState = false,
      this.tokenId = "",
      this.appleToken = ""})
      : super._();

  factory _$PreferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferenceImplFromJson(json);

  @override
  final int notificationState;
//Notification OnとOffと未設定の区分情報
  @override
  final DateTime lastLoginDate;
//LastLogin(次回に使う)
  @override
  @JsonKey()
  final bool browserState;
//ブラウザの設定情報(未使用)
  @override
  @JsonKey()
  final bool introductionState;
//初期イントロを表示したかの設定情報
  @override
  @JsonKey()
  final String tokenId;
// 通知のトークン（登録されている場合）
  @override
  @JsonKey()
  final String appleToken;

  @override
  String toString() {
    return 'Preference(notificationState: $notificationState, lastLoginDate: $lastLoginDate, browserState: $browserState, introductionState: $introductionState, tokenId: $tokenId, appleToken: $appleToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferenceImpl &&
            (identical(other.notificationState, notificationState) ||
                other.notificationState == notificationState) &&
            (identical(other.lastLoginDate, lastLoginDate) ||
                other.lastLoginDate == lastLoginDate) &&
            (identical(other.browserState, browserState) ||
                other.browserState == browserState) &&
            (identical(other.introductionState, introductionState) ||
                other.introductionState == introductionState) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId) &&
            (identical(other.appleToken, appleToken) ||
                other.appleToken == appleToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, notificationState, lastLoginDate,
      browserState, introductionState, tokenId, appleToken);

  /// Create a copy of Preference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferenceImplCopyWith<_$PreferenceImpl> get copyWith =>
      __$$PreferenceImplCopyWithImpl<_$PreferenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferenceImplToJson(
      this,
    );
  }
}

abstract class _Preference extends Preference {
  const factory _Preference(
      {required final int notificationState,
      required final DateTime lastLoginDate,
      final bool browserState,
      final bool introductionState,
      final String tokenId,
      final String appleToken}) = _$PreferenceImpl;
  const _Preference._() : super._();

  factory _Preference.fromJson(Map<String, dynamic> json) =
      _$PreferenceImpl.fromJson;

  @override
  int get notificationState; //Notification OnとOffと未設定の区分情報
  @override
  DateTime get lastLoginDate; //LastLogin(次回に使う)
  @override
  bool get browserState; //ブラウザの設定情報(未使用)
  @override
  bool get introductionState; //初期イントロを表示したかの設定情報
  @override
  String get tokenId; // 通知のトークン（登録されている場合）
  @override
  String get appleToken;

  /// Create a copy of Preference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreferenceImplCopyWith<_$PreferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
