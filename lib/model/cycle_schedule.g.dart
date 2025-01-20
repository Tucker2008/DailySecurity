// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CycleScheduleImpl _$$CycleScheduleImplFromJson(Map<String, dynamic> json) =>
    _$CycleScheduleImpl(
      winUpdate: json['winUpdate'] == null
          ? null
          : DateTime.parse(json['winUpdate'] as String),
      passwordUpdate: json['passwordUpdate'] == null
          ? null
          : DateTime.parse(json['passwordUpdate'] as String),
      virusUpdate: json['virusUpdate'] == null
          ? null
          : DateTime.parse(json['virusUpdate'] as String),
      otherDodate: json['otherDodate'] == null
          ? null
          : DateTime.parse(json['otherDodate'] as String),
      backupDodate: json['backupDodate'] == null
          ? null
          : DateTime.parse(json['backupDodate'] as String),
      fishingDodate: json['fishingDodate'] == null
          ? null
          : DateTime.parse(json['fishingDodate'] as String),
      handleDodate: json['handleDodate'] == null
          ? null
          : DateTime.parse(json['handleDodate'] as String),
      displayLockDodate: json['displayLockDodate'] == null
          ? null
          : DateTime.parse(json['displayLockDodate'] as String),
    );

Map<String, dynamic> _$$CycleScheduleImplToJson(_$CycleScheduleImpl instance) =>
    <String, dynamic>{
      'winUpdate': instance.winUpdate?.toIso8601String(),
      'passwordUpdate': instance.passwordUpdate?.toIso8601String(),
      'virusUpdate': instance.virusUpdate?.toIso8601String(),
      'otherDodate': instance.otherDodate?.toIso8601String(),
      'backupDodate': instance.backupDodate?.toIso8601String(),
      'fishingDodate': instance.fishingDodate?.toIso8601String(),
      'handleDodate': instance.handleDodate?.toIso8601String(),
      'displayLockDodate': instance.displayLockDodate?.toIso8601String(),
    };
