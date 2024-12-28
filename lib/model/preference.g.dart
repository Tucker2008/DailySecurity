// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreferenceImpl _$$PreferenceImplFromJson(Map<String, dynamic> json) =>
    _$PreferenceImpl(
      notificationState: (json['notificationState'] as num).toInt(),
      lastLoginDate: DateTime.parse(json['lastLoginDate'] as String),
      browserState: json['browserState'] as bool? ?? false,
      introductionState: json['introductionState'] as bool? ?? false,
      tokenId: json['tokenId'] as String? ?? "",
      appleToken: json['appleToken'] as String? ?? "",
    );

Map<String, dynamic> _$$PreferenceImplToJson(_$PreferenceImpl instance) =>
    <String, dynamic>{
      'notificationState': instance.notificationState,
      'lastLoginDate': instance.lastLoginDate.toIso8601String(),
      'browserState': instance.browserState,
      'introductionState': instance.introductionState,
      'tokenId': instance.tokenId,
      'appleToken': instance.appleToken,
    };
