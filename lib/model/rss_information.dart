// import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:webfeed_plus/webfeed_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// RssInformationをjson保存するためにfreezedを使う
part 'rss_information.freezed.dart';
part 'rss_information.g.dart';

@freezed
//
// Blogの記事情報
// factoryはRSSから記事情報を取得する
//
class RssInformation with _$RssInformation {
  const RssInformation._();

  const factory RssInformation({
    required String date, // 投稿日付
    required String title, // タイトル
    required String text, // 本文の一部など
    @Default("") String? link, // リンク先URL
    @Default("") String? imageUrl, // イメージファイルのURL（将来実装）
    @Default("") String? category, // カテゴリ（投稿、ニュースソース）
    @Default(false) bool bookmarked, // ブックマークされているか？
    @Default("") String? lang, // 言語：翻訳を必要とするか否かのフラグ
  }) = _RssInformation;

  // Cocologコンテンツ用の改造版
  factory RssInformation.fromFeed(RssItem feed) {
    return RssInformation(
      // メモ：このdateはUTC化されているのでLocalizationして+9する必要がある
      date: feed.dc!.date == null
          ? (feed.pubDate != null
              ? DateFormat('20yy/MM/dd(E)').format(feed.pubDate!.toLocal())
              : "N/A")
          : DateFormat('yyyy/MM/dd(E)').format(feed.dc!.date!.toLocal()),
      title: feed.title == null ? "N/A" : feed.title.toString(),
      text: feed.description == null ? "N/A" : feed.description.toString(),
      link: feed.link!,
      // カテゴリをdc領域から取得
      category:
          (feed.dc?.subject == null) ? "N/A" : feed.dc!.subject.toString(),
    );
  }

  // Map形式からの変換
  factory RssInformation.fromJson(Map<String, dynamic> json) =>
      _$RssInformationFromJson(json);
}
