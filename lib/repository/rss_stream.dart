import 'dart:convert';
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/cache_manager.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed_plus/webfeed_plus.dart';

//
// 最初にキャッシュにロードしておく
// RSSを読んでそれをRSSInformationのLISTに変換してキャッシュしておく
// computeでスレッドを起こそうとしたがうまくキャッシュされない
// cocologRssはメイン画面のロードが始まるのでここではキャッシュしない
//
Future<void> initialLoadCache() async {
  await rssStreaming(ipaRss);
  await rssStreaming(jvnRss);
  await rssStreaming(jpcertRss);
}

//
// RSSを読んでそれをRSSInformationのLISTに変換する
//
Future<List<RssInformation>> rssStreaming(String url) async {
  // chacheManagerからデータ領域を受ける
  List<RssInformation> informationList = [];
  // キャッシュ
  final cacheManeger = CacheManager();

  // chache済みならそのままそれを帰す
  // if (debugCache) {
  // debugPrint(
  //     "cocologProvider.cacheStatus: $url ${cacheManeger.getRssCacheIsEmpty(url) ? "EMPTY" : "FIND"}");
  // }

  if (!cacheManeger.getRssCacheIsEmpty(url)) {
    informationList = cacheManeger.getRssCache(url)!;
    // if (debugCache) {
    // debugPrint("cocologProvider.status: ${informationList.length}");
    // }
    return Future<List<RssInformation>>.value(informationList);
  }

  // chacheされていないので読み込み開始
  // RSSを読み込む。読み込みURLは global.dartに定義されているものを引数に指定
  final response = await http.get(Uri.parse(url));
  //   正常に取れたか？
  if (response.statusCode != 200) {
    // if (debugRssFeed) {
    //   debugPrint("response.statusCode: ${response.statusCode}");
    // }
    throw Exception('Failed to fetch RSS');
  }

  // debugPrint("rssStreaming.statusCode: $url ${response.statusCode}");

  //   取得したRSS/XMLをParseにかけて分解
  var feed = RssFeed.parse(utf8.decode(response.bodyBytes));
  int feedCounter = 0;
  DateTime lastLogin = PreferenceManager().getLastLogin();

  //   itemsの個別データ分解

  for (var item in feed.items!) {
    // Feedを個別構造に分解する
    informationList.add(RssInformation.fromFeed(item));

    // 最大定義期間までしか取り込まない
    // LastLoginから規定(30日)以内で、規定内件数以内である
    DateTime postDate = item.dc?.date as DateTime;

    // if (debugRssFeed) {
    //   debugPrint(
    //       "informationList.add: ${lastLogin.difference(postDate).inDays} : $feedCounter");
    // }

    if ((lastLogin.difference(postDate).inDays > maxFeedDuration) ||
        (feedCounter > minFeedCount)) {
      break;
    }
    feedCounter++;

    // debugPrint(
    //     "duration: ${lastLogin.difference(postDate).inDays},counter $feedCounter");

    // if (debugRssFeed) {
    //   debugPrint("item author: ${item.author}");
    //   debugPrint("item categories: ${item.categories?.toList().toString()}");
    //   debugPrint("item comments: ${item.comments}");
    //   debugPrint("item content: ${item.content?.value}");
    //   debugPrint("item dc subject【 ${item.dc?.subject}】");
    //   debugPrint("item dc creater: ${item.dc?.creator}");
    //   debugPrint("item description: ${item.description}");
    //   debugPrint("item guid: ${item.guid}");
    //   debugPrint("item link: ${item.link}");
    //   debugPrint("item title: ${item.title}");
    //   debugPrint("item pubDate: ${item.pubDate.toString()}");
    //   debugPrint("item source: ${item.source.toString()}");
    //   debugPrint("item media: ${item.media.toString()}");
    //   debugPrint("item enclosure: ${item.enclosure.toString()}");
    // }
  }
  //   デバッグ確認
  // if (debugRssFeed || debugCache) {
  //   debugPrint("title: ${feed.title}");
  //   debugPrint("description: ${feed.description}");
  //   debugPrint("link: ${feed.link}");
  //   debugPrint("size: ${informationList.length}");
  // }

  // Cacheに追加
  cacheManeger.addRssCache(url, informationList);
  // リストを返す
  return Future<List<RssInformation>>.value(informationList);
}
