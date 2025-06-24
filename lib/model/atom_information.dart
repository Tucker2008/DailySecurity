// import 'package:flutter/foundation.dart';
import 'package:cyber_interigence/theme/date_form.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:webfeed_plus/webfeed_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// json保存しないのでfreezed不使用でも良い
part 'atom_information.freezed.dart';
part 'atom_information.g.dart';

@freezed
//
// Blogの記事情報
// factoryはRSSから記事情報を取得する
//
class AtomInformation with _$AtomInformation {
  const factory AtomInformation({
    required String date, // 投稿日付
    required String title, // タイトル
    required String text, // 本文の一部など
    @Default("") String? link, // リンク先URL
    @Default("") String? category, // カテゴリ（投稿、ニュースソース）
  }) = _AtomInformation;

  // Cocologコンテンツ用の改造版
  factory AtomInformation.fromFeed(AtomItem feed) {
    return AtomInformation(
      // メモ：このdateはUTC化されているのでLocalizationして+9する必要がある
      date: feed.updated == null
          ? dateFormNA
          : DateFormat(dateFormJp,dateFormLocale).format(feed.updated!.toLocal()),
      title: feed.title == null ? dateFormNA : feed.title.toString(),
      text: feed.summary == null ? dateFormNA : feed.summary.toString(),
      link: feed.links!.first.href, //linksの中身が取れているのでヨシ
      // カテゴリをdc領域から取得
      category: (feed.categories == null) ? dateFormNA : feed.categories.toString(),
    );
  }

  // Map形式からの変換
  factory AtomInformation.fromJson(Map<String, dynamic> json) =>
      _$AtomInformationFromJson(json);
}
