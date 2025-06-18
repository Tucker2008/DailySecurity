import 'dart:convert';
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/model/atom_information.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/cache_manager.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed_plus/webfeed_plus.dart';

//
// 必要な全てのRSSを読んで、cocologのRSSInformationを返す
// 起動時に必要なニュース系RSSも同時に読む
//
Future<List<RssInformation>> allRssStreaming(String url) async {
  List<RssInformation>? rsss = [];
  // debugPrint("allRssStreaming: $url");
  await rssStreaming(url).then((value) {
    rsss = value;
  });
  // debugPrint("allRssStreaming: before");
  await startNewsRssStreaming();
  return Future<List<RssInformation>>.value(rsss);
}

//
// 起動最初に必要な全てのニュース系RSSを読む
//
Future<List<RssInformation>> startNewsRssStreaming() async {
  List<RssInformation> rsss = [];
  for (var rss in startRssUrls.keys) {
    // debugPrint("startNewsRssStreaming: $rss");
    await rssStreaming(rss).then((value) {
      rsss = value;
    }).whenComplete(() {
      // debugPrint("startNewsRssStreaming:Complete! $rss");
    }).catchError((error) {
      // debugPrint("startNewsRssStreaming:Error! $error $rss");
      NoteProvider().setNote("startNewsRssStreaming:Error! $error $rss");
    });
  }
  return Future<List<RssInformation>>.value(rsss);
}

//
// ニュース画面に必要な追加のニュース系RSSを読む
//
Future<List<RssInformation>> allNewsRssStreaming() async {
  List<RssInformation> rsss = [];
  for (var rss in rssUrls.keys) {
    // debugPrint("allNewsRssStreaming: $rss");
    await rssStreaming(rss).then((value) {
      rsss = value;
    }).whenComplete(() {
      // debugPrint("allNewsRssStreaming:Complete! $rss");
    }).catchError((error) {
      debugPrint("allNewsRssStreaming:Error! $error $rss");
      NoteProvider().setNote("allNewsRssStreaming:Error! $error $rss");
    });
  }
  return Future<List<RssInformation>>.value(rsss);
}

//
// ニュース画面に必要な追加のニュース系RSSを読む
//
Future<List<RssInformation>> foreignNewsRssStreaming(String url) async {
  List<RssInformation> rsss = [];
  for (var rss in foreignRssUrls.keys) {
    await rssStreaming(rss)
        .then((value) {
          rsss = value;
        })
        .whenComplete(() {})
        .catchError((error) {
          debugPrint("foreignNewsRssStreaming:Error! $error $rss");
          NoteProvider().setNote("foreignNewsRssStreaming:Error! $error $rss");
        });
  }
  return Future<List<RssInformation>>.value(rsss);
}

//
// RSSを読んでそれをRSSInformationのLISTに変換する
//
Future<List<RssInformation>> rssStreaming(String url) async {
  // chacheManagerからデータ領域を受ける
  List<RssInformation> informationList = [];
  // キャッシュ
  final cacheManeger = CacheManager();
  // 日付確認用
  DateTime? postDate;
  // 前回ログイン時を取得
  DateTime lastLogin = PreferenceManager().getLastLogin();
  // カウンター
  int feedCounter = 0;
  // ATOM処理のlink取り出し用
  String atomLinkString = "";

  // chache済みならそのままそれを帰す
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
  // else {
  //   if (debugRssFeed) {
  //     debugPrint("response.statusCode: ${response.statusCode} $url");
  //   }
  // }

  // ATOM処理
  //  取得したATOM/XMLをParseにかけて分解
  if (url.contains("atom")) {
    var atomFeed = AtomFeed.parse(utf8.decode(response.bodyBytes));

    // AtomLink対応用
    atomLinkString = "";
    //   itemsの個別データ分解
    for (var item in atomFeed.items!) {
      AtomInformation atom = AtomInformation.fromFeed(item);

      // AtomLinkの取り出し
      // AtomLinkがListで収められているので、HTMLしか取り出さない
      for (var atoms in item.links!) {
        // debugPrint("AtomInformation :${atoms.href.toString()}");
        if (atoms.href!.endsWith("html")) {
          // debugPrint("AtomInformation HTML :${atoms.href.toString()}");
          atomLinkString = atoms.href!;
        }
      }

      RssInformation rss = RssInformation(
          date: atom.date,
          title: atom.title,
          text: atom.text,
          link: atomLinkString.isNotEmpty ? atomLinkString : atom.link,
          category: atom.category);

      // if (debugRssFeed) {
      //   debugPrint("feed.items: ${rss.title}:${rss.link}");
      // debugPrint("feed.items: ${rss.text}:${rss.category}");
      // }

      // ここで英訳必要フラグをつける
      // launch_url.dart で起動ブラウザの区分に利用
      if (translateSite.contains(url)) {
        rss = rss.copyWith(lang: "Eng");
      }

      informationList.add(rss);
      // 投稿日を確認する
      postDate = item.updated as DateTime;
      // if (debugRssFeed) {
      //   debugPrint(
      //       "informationList.add: $postDate: ${lastLogin.difference(postDate).inDays} : $feedCounter");
      // }

      if ((lastLogin.difference(postDate).inDays > maxFeedDuration) ||
          (feedCounter > minFeedCount)) {
        break;
      }
      feedCounter++;
    }
  }
  // RSS処理
  // 取得したRSS/XMLをParseにかけて分解
  else {
    var feed = RssFeed.parse(utf8.decode(response.bodyBytes));

    //   itemsの個別データ分解
    for (var item in feed.items!) {
      // if (debugRssFeed) {
      //   debugPrint("feed.items: ${item.title}:${item.link}");
      //   debugPrint("feed.items: ${item.title}:${item.description}");
      // }
      // Feedを個別構造に分解する
      informationList.add(RssInformation.fromFeed(item));

      postDate = item.dc?.date;

      // 最大定義期間までしか取り込まない
      // LastLoginから規定(30日)以内で、規定内件数以内である

      if (item.dc?.date == null) {
        postDate = item.pubDate!;
        // 25を0025年と解釈するバグに対応,さらにmonth/dayのズレを謎の方法で解消
        postDate = postDate.copyWith(
            year:
                postDate.year < 2000 ? postDate.year + 2000 : postDate.year + 0,
            month: postDate.month + 0,
            day: postDate.day + 0);
      } else {
        postDate = item.dc?.date as DateTime;
      }

      // ここで英訳必要フラグをつける
      // launch_url.dart で起動ブラウザの区分に利用
      if (translateSite.contains(url)) {
        final RssInformation copyinfo = informationList.last;
        informationList.last = copyinfo.copyWith(lang: "Eng");
        // debugPrint("postDate?  ${item.pubDate.toString()}");
      }

      // if (debugRssFeed) {
      //   debugPrint(
      //       "informationList.add: $postDate: ${lastLogin.difference(postDate).inDays} : $feedCounter");
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
  // return Future<List<RssInformation>>.value(informationList);
  return informationList;
}
