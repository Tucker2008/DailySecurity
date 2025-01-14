// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rss_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RssInformation _$RssInformationFromJson(Map<String, dynamic> json) {
  return _RssInformation.fromJson(json);
}

/// @nodoc
mixin _$RssInformation {
  String get date => throw _privateConstructorUsedError; // 投稿日付
  String get title => throw _privateConstructorUsedError; // タイトル
  String get text => throw _privateConstructorUsedError; // 本文の一部など
  String? get link => throw _privateConstructorUsedError; // リンク先URL
  String? get imageUrl =>
      throw _privateConstructorUsedError; // イメージファイルのURL（将来実装）
  String? get category =>
      throw _privateConstructorUsedError; // カテゴリ（投稿、ニュースソース）
  bool get bookmarked => throw _privateConstructorUsedError;

  /// Serializes this RssInformation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RssInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RssInformationCopyWith<RssInformation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RssInformationCopyWith<$Res> {
  factory $RssInformationCopyWith(
          RssInformation value, $Res Function(RssInformation) then) =
      _$RssInformationCopyWithImpl<$Res, RssInformation>;
  @useResult
  $Res call(
      {String date,
      String title,
      String text,
      String? link,
      String? imageUrl,
      String? category,
      bool bookmarked});
}

/// @nodoc
class _$RssInformationCopyWithImpl<$Res, $Val extends RssInformation>
    implements $RssInformationCopyWith<$Res> {
  _$RssInformationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RssInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? text = null,
    Object? link = freezed,
    Object? imageUrl = freezed,
    Object? category = freezed,
    Object? bookmarked = null,
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
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      bookmarked: null == bookmarked
          ? _value.bookmarked
          : bookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RssInformationImplCopyWith<$Res>
    implements $RssInformationCopyWith<$Res> {
  factory _$$RssInformationImplCopyWith(_$RssInformationImpl value,
          $Res Function(_$RssInformationImpl) then) =
      __$$RssInformationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      String title,
      String text,
      String? link,
      String? imageUrl,
      String? category,
      bool bookmarked});
}

/// @nodoc
class __$$RssInformationImplCopyWithImpl<$Res>
    extends _$RssInformationCopyWithImpl<$Res, _$RssInformationImpl>
    implements _$$RssInformationImplCopyWith<$Res> {
  __$$RssInformationImplCopyWithImpl(
      _$RssInformationImpl _value, $Res Function(_$RssInformationImpl) _then)
      : super(_value, _then);

  /// Create a copy of RssInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? text = null,
    Object? link = freezed,
    Object? imageUrl = freezed,
    Object? category = freezed,
    Object? bookmarked = null,
  }) {
    return _then(_$RssInformationImpl(
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
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      bookmarked: null == bookmarked
          ? _value.bookmarked
          : bookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RssInformationImpl extends _RssInformation {
  const _$RssInformationImpl(
      {required this.date,
      required this.title,
      required this.text,
      this.link = "",
      this.imageUrl = "",
      this.category = "",
      this.bookmarked = false})
      : super._();

  factory _$RssInformationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RssInformationImplFromJson(json);

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
  final String? imageUrl;
// イメージファイルのURL（将来実装）
  @override
  @JsonKey()
  final String? category;
// カテゴリ（投稿、ニュースソース）
  @override
  @JsonKey()
  final bool bookmarked;

  @override
  String toString() {
    return 'RssInformation(date: $date, title: $title, text: $text, link: $link, imageUrl: $imageUrl, category: $category, bookmarked: $bookmarked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RssInformationImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, title, text, link, imageUrl, category, bookmarked);

  /// Create a copy of RssInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RssInformationImplCopyWith<_$RssInformationImpl> get copyWith =>
      __$$RssInformationImplCopyWithImpl<_$RssInformationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RssInformationImplToJson(
      this,
    );
  }
}

abstract class _RssInformation extends RssInformation {
  const factory _RssInformation(
      {required final String date,
      required final String title,
      required final String text,
      final String? link,
      final String? imageUrl,
      final String? category,
      final bool bookmarked}) = _$RssInformationImpl;
  const _RssInformation._() : super._();

  factory _RssInformation.fromJson(Map<String, dynamic> json) =
      _$RssInformationImpl.fromJson;

  @override
  String get date; // 投稿日付
  @override
  String get title; // タイトル
  @override
  String get text; // 本文の一部など
  @override
  String? get link; // リンク先URL
  @override
  String? get imageUrl; // イメージファイルのURL（将来実装）
  @override
  String? get category; // カテゴリ（投稿、ニュースソース）
  @override
  bool get bookmarked;

  /// Create a copy of RssInformation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RssInformationImplCopyWith<_$RssInformationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
