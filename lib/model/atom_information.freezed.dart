// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'atom_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AtomInformation _$AtomInformationFromJson(Map<String, dynamic> json) {
  return _AtomInformation.fromJson(json);
}

/// @nodoc
mixin _$AtomInformation {
  String get date => throw _privateConstructorUsedError; // 投稿日付
  String get title => throw _privateConstructorUsedError; // タイトル
  String get text => throw _privateConstructorUsedError; // 本文の一部など
  String? get link => throw _privateConstructorUsedError; // リンク先URL
  String? get category => throw _privateConstructorUsedError;

  /// Serializes this AtomInformation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AtomInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AtomInformationCopyWith<AtomInformation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AtomInformationCopyWith<$Res> {
  factory $AtomInformationCopyWith(
          AtomInformation value, $Res Function(AtomInformation) then) =
      _$AtomInformationCopyWithImpl<$Res, AtomInformation>;
  @useResult
  $Res call(
      {String date, String title, String text, String? link, String? category});
}

/// @nodoc
class _$AtomInformationCopyWithImpl<$Res, $Val extends AtomInformation>
    implements $AtomInformationCopyWith<$Res> {
  _$AtomInformationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AtomInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? text = null,
    Object? link = freezed,
    Object? category = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AtomInformationImplCopyWith<$Res>
    implements $AtomInformationCopyWith<$Res> {
  factory _$$AtomInformationImplCopyWith(_$AtomInformationImpl value,
          $Res Function(_$AtomInformationImpl) then) =
      __$$AtomInformationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date, String title, String text, String? link, String? category});
}

/// @nodoc
class __$$AtomInformationImplCopyWithImpl<$Res>
    extends _$AtomInformationCopyWithImpl<$Res, _$AtomInformationImpl>
    implements _$$AtomInformationImplCopyWith<$Res> {
  __$$AtomInformationImplCopyWithImpl(
      _$AtomInformationImpl _value, $Res Function(_$AtomInformationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AtomInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? text = null,
    Object? link = freezed,
    Object? category = freezed,
  }) {
    return _then(_$AtomInformationImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AtomInformationImpl implements _AtomInformation {
  const _$AtomInformationImpl(
      {required this.date,
      required this.title,
      required this.text,
      this.link = "",
      this.category = ""});

  factory _$AtomInformationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AtomInformationImplFromJson(json);

  @override
  final String date;
// 投稿日付
  @override
  final String title;
// タイトル
  @override
  final String text;
// 本文の一部など
  @override
  @JsonKey()
  final String? link;
// リンク先URL
  @override
  @JsonKey()
  final String? category;

  @override
  String toString() {
    return 'AtomInformation(date: $date, title: $title, text: $text, link: $link, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AtomInformationImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, date, title, text, link, category);

  /// Create a copy of AtomInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AtomInformationImplCopyWith<_$AtomInformationImpl> get copyWith =>
      __$$AtomInformationImplCopyWithImpl<_$AtomInformationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AtomInformationImplToJson(
      this,
    );
  }
}

abstract class _AtomInformation implements AtomInformation {
  const factory _AtomInformation(
      {required final String date,
      required final String title,
      required final String text,
      final String? link,
      final String? category}) = _$AtomInformationImpl;

  factory _AtomInformation.fromJson(Map<String, dynamic> json) =
      _$AtomInformationImpl.fromJson;

  @override
  String get date; // 投稿日付
  @override
  String get title; // タイトル
  @override
  String get text; // 本文の一部など
  @override
  String? get link; // リンク先URL
  @override
  String? get category;

  /// Create a copy of AtomInformation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AtomInformationImplCopyWith<_$AtomInformationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
