// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rss_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RssInformationImpl _$$RssInformationImplFromJson(Map<String, dynamic> json) =>
    _$RssInformationImpl(
      date: json['date'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
      link: json['link'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
      category: json['category'] as String? ?? "",
      bookmarked: json['bookmarked'] as bool? ?? false,
    );

Map<String, dynamic> _$$RssInformationImplToJson(
        _$RssInformationImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'title': instance.title,
      'text': instance.text,
      'link': instance.link,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'bookmarked': instance.bookmarked,
    };
