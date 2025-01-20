// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CycleSchedule _$CycleScheduleFromJson(Map<String, dynamic> json) {
  return _CycleSchedule.fromJson(json);
}

/// @nodoc
mixin _$CycleSchedule {
  DateTime? get winUpdate =>
      throw _privateConstructorUsedError; // Windows Updateの実施日
  DateTime? get passwordUpdate =>
      throw _privateConstructorUsedError; // パスワード Updateの実施日
  DateTime? get virusUpdate =>
      throw _privateConstructorUsedError; // ウィルスパターン Updateの実施日
  DateTime? get otherDodate =>
      throw _privateConstructorUsedError; // 以下その他パターンの実施日
  DateTime? get backupDodate =>
      throw _privateConstructorUsedError; // バックアップ実施パターンの実施日
  DateTime? get fishingDodate =>
      throw _privateConstructorUsedError; // フィッシング警戒の実施日
  DateTime? get handleDodate =>
      throw _privateConstructorUsedError; // 情報持ち出し警戒の実施日
  DateTime? get displayLockDodate => throw _privateConstructorUsedError;

  /// Serializes this CycleSchedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CycleSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CycleScheduleCopyWith<CycleSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CycleScheduleCopyWith<$Res> {
  factory $CycleScheduleCopyWith(
          CycleSchedule value, $Res Function(CycleSchedule) then) =
      _$CycleScheduleCopyWithImpl<$Res, CycleSchedule>;
  @useResult
  $Res call(
      {DateTime? winUpdate,
      DateTime? passwordUpdate,
      DateTime? virusUpdate,
      DateTime? otherDodate,
      DateTime? backupDodate,
      DateTime? fishingDodate,
      DateTime? handleDodate,
      DateTime? displayLockDodate});
}

/// @nodoc
class _$CycleScheduleCopyWithImpl<$Res, $Val extends CycleSchedule>
    implements $CycleScheduleCopyWith<$Res> {
  _$CycleScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CycleSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? winUpdate = freezed,
    Object? passwordUpdate = freezed,
    Object? virusUpdate = freezed,
    Object? otherDodate = freezed,
    Object? backupDodate = freezed,
    Object? fishingDodate = freezed,
    Object? handleDodate = freezed,
    Object? displayLockDodate = freezed,
  }) {
    return _then(_value.copyWith(
      winUpdate: freezed == winUpdate
          ? _value.winUpdate
          : winUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      passwordUpdate: freezed == passwordUpdate
          ? _value.passwordUpdate
          : passwordUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      virusUpdate: freezed == virusUpdate
          ? _value.virusUpdate
          : virusUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      otherDodate: freezed == otherDodate
          ? _value.otherDodate
          : otherDodate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      backupDodate: freezed == backupDodate
          ? _value.backupDodate
          : backupDodate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fishingDodate: freezed == fishingDodate
          ? _value.fishingDodate
          : fishingDodate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      handleDodate: freezed == handleDodate
          ? _value.handleDodate
          : handleDodate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      displayLockDodate: freezed == displayLockDodate
          ? _value.displayLockDodate
          : displayLockDodate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CycleScheduleImplCopyWith<$Res>
    implements $CycleScheduleCopyWith<$Res> {
  factory _$$CycleScheduleImplCopyWith(
          _$CycleScheduleImpl value, $Res Function(_$CycleScheduleImpl) then) =
      __$$CycleScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? winUpdate,
      DateTime? passwordUpdate,
      DateTime? virusUpdate,
      DateTime? otherDodate,
      DateTime? backupDodate,
      DateTime? fishingDodate,
      DateTime? handleDodate,
      DateTime? displayLockDodate});
}

/// @nodoc
class __$$CycleScheduleImplCopyWithImpl<$Res>
    extends _$CycleScheduleCopyWithImpl<$Res, _$CycleScheduleImpl>
    implements _$$CycleScheduleImplCopyWith<$Res> {
  __$$CycleScheduleImplCopyWithImpl(
      _$CycleScheduleImpl _value, $Res Function(_$CycleScheduleImpl) _then)
      : super(_value, _then);

  /// Create a copy of CycleSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? winUpdate = freezed,
    Object? passwordUpdate = freezed,
    Object? virusUpdate = freezed,
    Object? otherDodate = freezed,
    Object? backupDodate = freezed,
    Object? fishingDodate = freezed,
    Object? handleDodate = freezed,
    Object? displayLockDodate = freezed,
  }) {
    return _then(_$CycleScheduleImpl(
      winUpdate: freezed == winUpdate
          ? _value.winUpdate
          : winUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      passwordUpdate: freezed == passwordUpdate
          ? _value.passwordUpdate
          : passwordUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      virusUpdate: freezed == virusUpdate
          ? _value.virusUpdate
          : virusUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      otherDodate: freezed == otherDodate
          ? _value.otherDodate
          : otherDodate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      backupDodate: freezed == backupDodate
          ? _value.backupDodate
          : backupDodate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fishingDodate: freezed == fishingDodate
          ? _value.fishingDodate
          : fishingDodate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      handleDodate: freezed == handleDodate
          ? _value.handleDodate
          : handleDodate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      displayLockDodate: freezed == displayLockDodate
          ? _value.displayLockDodate
          : displayLockDodate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CycleScheduleImpl extends _CycleSchedule {
  const _$CycleScheduleImpl(
      {this.winUpdate = null,
      this.passwordUpdate = null,
      this.virusUpdate = null,
      this.otherDodate = null,
      this.backupDodate = null,
      this.fishingDodate = null,
      this.handleDodate = null,
      this.displayLockDodate = null})
      : super._();

  factory _$CycleScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$CycleScheduleImplFromJson(json);

  @override
  @JsonKey()
  final DateTime? winUpdate;
// Windows Updateの実施日
  @override
  @JsonKey()
  final DateTime? passwordUpdate;
// パスワード Updateの実施日
  @override
  @JsonKey()
  final DateTime? virusUpdate;
// ウィルスパターン Updateの実施日
  @override
  @JsonKey()
  final DateTime? otherDodate;
// 以下その他パターンの実施日
  @override
  @JsonKey()
  final DateTime? backupDodate;
// バックアップ実施パターンの実施日
  @override
  @JsonKey()
  final DateTime? fishingDodate;
// フィッシング警戒の実施日
  @override
  @JsonKey()
  final DateTime? handleDodate;
// 情報持ち出し警戒の実施日
  @override
  @JsonKey()
  final DateTime? displayLockDodate;

  @override
  String toString() {
    return 'CycleSchedule(winUpdate: $winUpdate, passwordUpdate: $passwordUpdate, virusUpdate: $virusUpdate, otherDodate: $otherDodate, backupDodate: $backupDodate, fishingDodate: $fishingDodate, handleDodate: $handleDodate, displayLockDodate: $displayLockDodate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CycleScheduleImpl &&
            (identical(other.winUpdate, winUpdate) ||
                other.winUpdate == winUpdate) &&
            (identical(other.passwordUpdate, passwordUpdate) ||
                other.passwordUpdate == passwordUpdate) &&
            (identical(other.virusUpdate, virusUpdate) ||
                other.virusUpdate == virusUpdate) &&
            (identical(other.otherDodate, otherDodate) ||
                other.otherDodate == otherDodate) &&
            (identical(other.backupDodate, backupDodate) ||
                other.backupDodate == backupDodate) &&
            (identical(other.fishingDodate, fishingDodate) ||
                other.fishingDodate == fishingDodate) &&
            (identical(other.handleDodate, handleDodate) ||
                other.handleDodate == handleDodate) &&
            (identical(other.displayLockDodate, displayLockDodate) ||
                other.displayLockDodate == displayLockDodate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      winUpdate,
      passwordUpdate,
      virusUpdate,
      otherDodate,
      backupDodate,
      fishingDodate,
      handleDodate,
      displayLockDodate);

  /// Create a copy of CycleSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CycleScheduleImplCopyWith<_$CycleScheduleImpl> get copyWith =>
      __$$CycleScheduleImplCopyWithImpl<_$CycleScheduleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CycleScheduleImplToJson(
      this,
    );
  }
}

abstract class _CycleSchedule extends CycleSchedule {
  const factory _CycleSchedule(
      {final DateTime? winUpdate,
      final DateTime? passwordUpdate,
      final DateTime? virusUpdate,
      final DateTime? otherDodate,
      final DateTime? backupDodate,
      final DateTime? fishingDodate,
      final DateTime? handleDodate,
      final DateTime? displayLockDodate}) = _$CycleScheduleImpl;
  const _CycleSchedule._() : super._();

  factory _CycleSchedule.fromJson(Map<String, dynamic> json) =
      _$CycleScheduleImpl.fromJson;

  @override
  DateTime? get winUpdate; // Windows Updateの実施日
  @override
  DateTime? get passwordUpdate; // パスワード Updateの実施日
  @override
  DateTime? get virusUpdate; // ウィルスパターン Updateの実施日
  @override
  DateTime? get otherDodate; // 以下その他パターンの実施日
  @override
  DateTime? get backupDodate; // バックアップ実施パターンの実施日
  @override
  DateTime? get fishingDodate; // フィッシング警戒の実施日
  @override
  DateTime? get handleDodate; // 情報持ち出し警戒の実施日
  @override
  DateTime? get displayLockDodate;

  /// Create a copy of CycleSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CycleScheduleImplCopyWith<_$CycleScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
