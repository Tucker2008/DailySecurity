// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_structure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostStructureImpl _$$PostStructureImplFromJson(Map<String, dynamic> json) =>
    _$PostStructureImpl(
      category: json['category'] as String,
      entoryTitle: json['entoryTitle'] as String,
      dateHeader: DateTime.parse(json['dateHeader'] as String),
      contentAbstract: (json['contentAbstract'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      contentDetails: (json['contentDetails'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      contentHref: (json['contentHref'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      contentLinks: (json['contentLinks'] as List<dynamic>?)
              ?.map((e) => Uri.parse(e as String))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PostStructureImplToJson(_$PostStructureImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'entoryTitle': instance.entoryTitle,
      'dateHeader': instance.dateHeader.toIso8601String(),
      'contentAbstract': instance.contentAbstract,
      'contentDetails': instance.contentDetails,
      'contentHref': instance.contentHref,
      'contentLinks': instance.contentLinks.map((e) => e.toString()).toList(),
    };
