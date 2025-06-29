import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/cache_manager.dart';
import 'package:cyber_interigence/theme/date_form.dart';
import 'package:cyber_interigence/util/url_provider.dart';
// import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

//
// キャッシュにロードしておいたニュースソースのRSSinformationをマージ
// 時系列ソートしてcategoryにソース名を入れる
// こちらは国内ニュース用
List<RssInformation>? meargeNews(int max) {
  return _multiMeargeNews(max, rssUrls, null);
}

// こちらは海外ニュース用
List<RssInformation>? meargeForeignNews(int max) {
  return _multiMeargeNews(max, foreignRssUrls, null);
}

// EntranceScreenトップニュースに表示するニュース(2025.6.18)
List<RssInformation>? meargeTopNews(int max) {
  return _multiMeargeNews(max, topNewsRssUrls, null);
}

// インシデントニュース　ココログのColumnとインシデントニュースをマージする(2025.6.18)
List<RssInformation>? meargeIncidentNews(
    int max, List<RssInformation> columnList) {
  return _multiMeargeNews(max, incidentRssUrls, columnList);
}

// URLのマップに従ってキャッシュからRSSinformation群を取り出す
// 上限件数とソートを実施する（上限なしなら0とする）
//
List<RssInformation>? _multiMeargeNews(
    int max, Map<String, String> urlMap, List<RssInformation>? addList) {
  List<RssInformation> margeList = [];
  List<RssInformation> margedList = [];
  List<RssInformation>? tmpList;

  // キャッシュがないなら早すぎるので返す
  if (CacheManager().getRssCacheIsEmpty(urlMap.keys.first)) {
    // debugPrint("_multiMeargeNews: getRssCacheIsEmpty ${urlMap.keys.first}");
    // 元リストがあれば、それをそのまま帰す(2025.06.19)
    if (addList != null) {
      return addList;
    } else {
      return null;
    }
  }

  // 元リストが指定されている場合には、あらかじめそれを入れておく(2025.6.19)
  if (addList != null) {
    margeList.addAll(addList);
  }

  // キャッシュから読み込んでマージする
  // for分でまとめて実施 2025.4.15
  for (var rss in urlMap.keys) {
    tmpList = CacheManager().getRssCache(rss);
    if (tmpList != null) {
      for (var element in tmpList) {
        // JPCERTはURLのモバイル変換が必要
        if (rss.startsWith(jpcertStartURL)) {
          margeList.add(element.copyWith(
            category: "jcr",
            link: UrlProvider().jpcertUrl(element.link!),
          ));
        } else {
          margeList.add(element.copyWith(category: urlMap[rss]));
        }
      }
      // debugPrint("meargeNews loop: $rss ");
    } else {
      // debugPrint("meargeNews: $rss : null");
    }
  }

  // DEBUG

  // for (var item in margeList) {
  //   debugPrint("MargeNews: ${item.title}:${item.date}");
  // }

  // マージしたリストを時系列にソートする
  margeList.sort((a, b) => DateFormat(dateFormJp, dateFormLocale)
      .parse(b.date)
      .compareTo(DateFormat(dateFormJp,dateFormLocale).parse(a.date)));

  // ここで件数指定があれば規定数にして返す
  if (max > 0) {
    for (int i = 0; i < max; i++) {
      margedList.add(margeList[i]);
    }
    return margedList;
  }
  return margeList;
}

// カテゴリ毎にRSSをフィルタする（ついでに件数も制限する）
List<RssInformation>? filteringList(
    List<RssInformation> originList, String category, int maxCount) {
  List<RssInformation> processedList = [];
  int counter = 0;
  // nullチェック
  if (originList.isEmpty) {
    return processedList;
  }
  // カテゴリチェック
  for (var item in originList) {
    // カテゴリとカウントのチェック
    if (((category.isNotEmpty) && (item.category == category)) &&
        (counter < maxCount)) {
      processedList.add(item);
      counter++;
    }
  }
  // debugPrint("filteringList: $category : ${originList.length} -> $counter");
  return processedList;
}
