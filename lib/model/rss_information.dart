import 'package:intl/intl.dart' show DateFormat;
import 'package:webfeed_plus/webfeed_plus.dart';

//
// Blogの記事情報
// factoryはRSSから記事情報を取得する
//
class RssInformation {
  String date;
  String title;
  String text;
  String? link;
  String? imageUrl;
  String? category;
  RssInformation({
    required this.date,
    required this.title,
    required this.text,
    this.link,
    this.imageUrl,
    this.category,
  });

  // Cocologコンテンツ用の改造版
  factory RssInformation.fromFeed(RssItem feed) {
    return RssInformation(
      // メモ：このdateはUTC化されているのでLocalizationして+9する必要がある
      date: feed.dc!.date == null
          ? "N/A"
          : DateFormat('yyyy/MM/dd(E)').format(feed.dc!.date!.toLocal()),
      title: feed.title == null ? "N/A" : feed.title.toString(),
      text: feed.description == null ? "N/A" : feed.description.toString(),
      link: feed.link,
      // カテゴリをdc領域から取得
      category:
          (feed.dc?.subject == null) ? "N/A" : feed.dc?.subject.toString(),
    );
  }
}
