import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cyber_interigence/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:cyber_interigence/model/rss_information.dart';

class BookmarkStore {
  final String profKey = 'bookmark';

  // bookmarkをセーブする
  Future<void> saveBookmark(Map<String, RssInformation> bookmarkMap) async {
    final prefs = await SharedPreferences.getInstance();
    //この1行で保存のための変換を行なっている。
    String bookMarkStrings = convert.json.encode(bookmarkMap);
    // if (debugPreference) {
    //   debugPrint("saveBookmark: $bookMarkStrings");
    // }
    await prefs.setString(profKey, bookMarkStrings);
  }

  // bookmarkをロードする
  Future<Map<String, RssInformation>> loadBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encoded = prefs.getString(profKey);

    //何も保存されていない場合はダミーを１件生成して返す
    if (encoded == null) {
      if (debugPreference) {
        debugPrint("loadBookmark: nothing bookmark");
      }
      final RssInformation zeroInfo = RssInformation(
        date: DateTime.now().toString(),
        title: "",
        text: "",
      );
      final Map<String, RssInformation> zeroMap = {"zero": zeroInfo};
      return Future<Map<String, RssInformation>>.value(zeroMap);
    }
    // JSON変換を行なって取得データを返す
    // if (debugPreference) {
    //   debugPrint("loadBookmark: $encoded");
    // }
    // Mapの読み込みのクセを取り込む
    Map<String, RssInformation> getBookMarkMap = {};
    final Map<String, dynamic> getMap = convert.json.decode(encoded);

    // dynamicをRssInformationに変換
    for (var item in getMap.keys) {
      // debugPrint("loadBookmark keys: $item");
      getBookMarkMap[item] = RssInformation.fromJson(getMap[item]);
    }

    return Future<Map<String, RssInformation>>.value(
        getBookMarkMap as FutureOr<Map<String, RssInformation>>);
  }

  Future<void> removeBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(profKey);
  }
}
