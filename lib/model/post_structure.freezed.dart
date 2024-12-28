// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_structure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostStructure _$PostStructureFromJson(Map<String, dynamic> json) {
  return _PostStructure.fromJson(json);
}

/// @nodoc
mixin _$PostStructure {
  String get category =>
      throw _privateConstructorUsedError; //記事カテゴリ(content_category)
  String get entoryTitle =>
      throw _privateConstructorUsedError; //投稿タイトル(entry_header)
  DateTime get dateHeader =>
      throw _privateConstructorUsedError; //投稿日(date_header)
  List<String> get contentAbstract =>
      throw _privateConstructorUsedError; // 発生事実（content_abstract）
  List<String> get contentDetails =>
      throw _privateConstructorUsedError; // 詳細説明（content_details）
  List<String> get contentHref =>
      throw _privateConstructorUsedError; // Link先説明（content_details）
  List<Uri> get contentLinks => throw _privateConstructorUsedError;

  /// Serializes this PostStructure to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostStructure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostStructureCopyWith<PostStructure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostStructureCopyWith<$Res> {
  factory $PostStructureCopyWith(
          PostStructure value, $Res Function(PostStructure) then) =
      _$PostStructureCopyWithImpl<$Res, PostStructure>;
  @useResult
  $Res call(
      {String category,
      String entoryTitle,
      DateTime dateHeader,
      List<String> contentAbstract,
      List<String> contentDetails,
      List<String> contentHref,
      List<Uri> contentLinks});
}

/// @nodoc
class _$PostStructureCopyWithImpl<$Res, $Val extends PostStructure>
    implements $PostStructureCopyWith<$Res> {
  _$PostStructureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostStructure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? entoryTitle = null,
    Object? dateHeader = null,
    Object? contentAbstract = null,
    Object? contentDetails = null,
    Object? contentHref = null,
    Object? contentLinks = null,
  }) {
    return _then(_value.copyWith(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      entoryTitle: null == entoryTitle
          ? _value.entoryTitle
          : entoryTitle // ignore: cast_nullable_to_non_nullable
              as String,
      dateHeader: null == dateHeader
          ? _value.dateHeader
          : dateHeader // ignore: cast_nullable_to_non_nullable
              as DateTime,
      contentAbstract: null == contentAbstract
          ? _value.contentAbstract
          : contentAbstract // ignore: cast_nullable_to_non_nullable
              as List<String>,
      contentDetails: null == contentDetails
          ? _value.contentDetails
          : contentDetails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      contentHref: null == contentHref
          ? _value.contentHref
          : contentHref // ignore: cast_nullable_to_non_nullable
              as List<String>,
      contentLinks: null == contentLinks
          ? _value.contentLinks
          : contentLinks // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostStructureImplCopyWith<$Res>
    implements $PostStructureCopyWith<$Res> {
  factory _$$PostStructureImplCopyWith(
          _$PostStructureImpl value, $Res Function(_$PostStructureImpl) then) =
      __$$PostStructureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String category,
      String entoryTitle,
      DateTime dateHeader,
      List<String> contentAbstract,
      List<String> contentDetails,
      List<String> contentHref,
      List<Uri> contentLinks});
}

/// @nodoc
class __$$PostStructureImplCopyWithImpl<$Res>
    extends _$PostStructureCopyWithImpl<$Res, _$PostStructureImpl>
    implements _$$PostStructureImplCopyWith<$Res> {
  __$$PostStructureImplCopyWithImpl(
      _$PostStructureImpl _value, $Res Function(_$PostStructureImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostStructure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? entoryTitle = null,
    Object? dateHeader = null,
    Object? contentAbstract = null,
    Object? contentDetails = null,
    Object? contentHref = null,
    Object? contentLinks = null,
  }) {
    return _then(_$PostStructureImpl(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      entoryTitle: null == entoryTitle
          ? _value.entoryTitle
          : entoryTitle // ignore: cast_nullable_to_non_nullable
              as String,
      dateHeader: null == dateHeader
          ? _value.dateHeader
          : dateHeader // ignore: cast_nullable_to_non_nullable
              as DateTime,
      contentAbstract: null == contentAbstract
          ? _value._contentAbstract
          : contentAbstract // ignore: cast_nullable_to_non_nullable
              as List<String>,
      contentDetails: null == contentDetails
          ? _value._contentDetails
          : contentDetails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      contentHref: null == contentHref
          ? _value._contentHref
          : contentHref // ignore: cast_nullable_to_non_nullable
              as List<String>,
      contentLinks: null == contentLinks
          ? _value._contentLinks
          : contentLinks // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostStructureImpl extends _PostStructure {
  const _$PostStructureImpl(
      {required this.category,
      required this.entoryTitle,
      required this.dateHeader,
      final List<String> contentAbstract = const [],
      final List<String> contentDetails = const [],
      final List<String> contentHref = const [],
      final List<Uri> contentLinks = const []})
      : _contentAbstract = contentAbstract,
        _contentDetails = contentDetails,
        _contentHref = contentHref,
        _contentLinks = contentLinks,
        super._();

  factory _$PostStructureImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostStructureImplFromJson(json);

  @override
  final String category;
//記事カテゴリ(content_category)
  @override
  final String entoryTitle;
//投稿タイトル(entry_header)
  @override
  final DateTime dateHeader;
//投稿日(date_header)
  final List<String> _contentAbstract;
//投稿日(date_header)
  @override
  @JsonKey()
  List<String> get contentAbstract {
    if (_contentAbstract is EqualUnmodifiableListView) return _contentAbstract;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contentAbstract);
  }

// 発生事実（content_abstract）
  final List<String> _contentDetails;
// 発生事実（content_abstract）
  @override
  @JsonKey()
  List<String> get contentDetails {
    if (_contentDetails is EqualUnmodifiableListView) return _contentDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contentDetails);
  }

// 詳細説明（content_details）
  final List<String> _contentHref;
// 詳細説明（content_details）
  @override
  @JsonKey()
  List<String> get contentHref {
    if (_contentHref is EqualUnmodifiableListView) return _contentHref;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contentHref);
  }

// Link先説明（content_details）
  final List<Uri> _contentLinks;
// Link先説明（content_details）
  @override
  @JsonKey()
  List<Uri> get contentLinks {
    if (_contentLinks is EqualUnmodifiableListView) return _contentLinks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contentLinks);
  }

  @override
  String toString() {
    return 'PostStructure(category: $category, entoryTitle: $entoryTitle, dateHeader: $dateHeader, contentAbstract: $contentAbstract, contentDetails: $contentDetails, contentHref: $contentHref, contentLinks: $contentLinks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostStructureImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.entoryTitle, entoryTitle) ||
                other.entoryTitle == entoryTitle) &&
            (identical(other.dateHeader, dateHeader) ||
                other.dateHeader == dateHeader) &&
            const DeepCollectionEquality()
                .equals(other._contentAbstract, _contentAbstract) &&
            const DeepCollectionEquality()
                .equals(other._contentDetails, _contentDetails) &&
            const DeepCollectionEquality()
                .equals(other._contentHref, _contentHref) &&
            const DeepCollectionEquality()
                .equals(other._contentLinks, _contentLinks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      category,
      entoryTitle,
      dateHeader,
      const DeepCollectionEquality().hash(_contentAbstract),
      const DeepCollectionEquality().hash(_contentDetails),
      const DeepCollectionEquality().hash(_contentHref),
      const DeepCollectionEquality().hash(_contentLinks));

  /// Create a copy of PostStructure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostStructureImplCopyWith<_$PostStructureImpl> get copyWith =>
      __$$PostStructureImplCopyWithImpl<_$PostStructureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostStructureImplToJson(
      this,
    );
  }
}

abstract class _PostStructure extends PostStructure {
  const factory _PostStructure(
      {required final String category,
      required final String entoryTitle,
      required final DateTime dateHeader,
      final List<String> contentAbstract,
      final List<String> contentDetails,
      final List<String> contentHref,
      final List<Uri> contentLinks}) = _$PostStructureImpl;
  const _PostStructure._() : super._();

  factory _PostStructure.fromJson(Map<String, dynamic> json) =
      _$PostStructureImpl.fromJson;

  @override
  String get category; //記事カテゴリ(content_category)
  @override
  String get entoryTitle; //投稿タイトル(entry_header)
  @override
  DateTime get dateHeader; //投稿日(date_header)
  @override
  List<String> get contentAbstract; // 発生事実（content_abstract）
  @override
  List<String> get contentDetails; // 詳細説明（content_details）
  @override
  List<String> get contentHref; // Link先説明（content_details）
  @override
  List<Uri> get contentLinks;

  /// Create a copy of PostStructure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostStructureImplCopyWith<_$PostStructureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
