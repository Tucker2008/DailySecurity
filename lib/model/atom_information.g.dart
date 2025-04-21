// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atom_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AtomInformationImpl _$$AtomInformationImplFromJson(
        Map<String, dynamic> json) =>
    _$AtomInformationImpl(
      date: json['date'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
      link: json['link'] as String? ?? "",
      category: json['category'] as String? ?? "",
    );

Map<String, dynamic> _$$AtomInformationImplToJson(
        _$AtomInformationImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'title': instance.title,
      'text': instance.text,
      'link': instance.link,
      'category': instance.category,
    };
