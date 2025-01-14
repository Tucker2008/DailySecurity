import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/repository/cache_manager.dart';
import 'package:cyber_interigence/repository/launch_url.dart';
import 'package:cyber_interigence/repository/rss_stream.dart';
import 'package:flutter/material.dart';
import 'package:cyber_interigence/model/rss_information.dart';

// （旧：RSS一覧表示機能）
// Notification で更新情報が来たときの該当記事が表示する

class DisplayFeed {
  const DisplayFeed();

  bool findLaunchPage(BuildContext context, String title) {
    // キャッシュからRSSを引っ張る
    if (CacheManager().getRssCacheIsEmpty(cocologRss)) {
      // キャッシュにない？のでロードする
      rssStreaming(cocologRss);
    }
    List<RssInformation>? informationList =
        CacheManager().getRssCache(cocologRss);
    if (informationList == null) {
      return false;
    }
    for (var item in informationList) {
      if (item.title == title) {
        // デバッグ
        // debugPrint("findLaunchPage: find ${item.title}");
        launchURL(context, item.link!);
        return true;
      }
    }
    return false;
  }
}
