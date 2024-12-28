// 様々なネットワークから取得するデータをキャッシュする
// 対象：cocolog関連:XML及び本文

import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/model/post_structure.dart';
import 'package:cyber_interigence/model/rss_information.dart';
// import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';

class CacheManager {
  // Singletonデザインパターン
  static final CacheManager _instance = CacheManager._();
  CacheManager._();

  factory CacheManager() {
    return _instance;
  }

  // スレッドセーフの実験
  static final _classLock = Lock();

  // キャッシュの有効期限を管理する
  Map<String, DateTime> _cacheDateTime = {};

  // キャッシュタイムアウトのチェックロジック
  // キャッシュがない(false) タイムアウトしている(false)
  // キャッシュは規定時間内のものである true
  bool _checkCacheTime(String url) {
    // 有効期限を確認する
    if (_cacheDateTime.containsKey(url)) {
      // debugPrint(
      //     "_checkCacheTime: $url ${DateTime.now().difference(_cacheDateTime[url]!).inHours}");
      return (DateTime.now().difference(_cacheDateTime[url]!).inHours >
              cacheTerm)
          ? false
          : true;
    }
    // debugPrint(
    //     "_checkCacheTime: $url cache hit NON ${_cacheDateTime.containsKey(url)}");
    // _cacheDateTime.forEach(
    //   (key, value) {
    //     debugPrint("_checkCacheTime: $url cache $key $value");
    //   },
    // );

    return false;
  }

  void _startCheckTime(String url) {
    // _cacheDateTime.forEach(
    //   (key, value) {
    //     debugPrint("_startCheckTimeBefore:$url=cache|$key|$value|");
    //   },
    // );
    _cacheDateTime[url] = DateTime.now();
  }

  // ----------- 管理データ:cocolog/IPA/JVN/jpcertのRSS
  Map<String, List<RssInformation>> _rssCache = {};

  List<RssInformation>? getRssCache(rssUrl) {
    return _rssCache.containsKey(rssUrl) ? _rssCache[rssUrl] : null;
  }

  bool getRssCacheIsEmpty(String rssUrl) {
    // キャッシュヒット？
    if (_rssCache.containsKey(rssUrl)) {
      // タイムスタンプチェック
      if (!_checkCacheTime(rssUrl)) {
        // debugPrint(
        //     "getRssCache Timeout: $rssUrl ${_rssCache.containsKey(rssUrl)}");
        return true;
      }
      // キャッシュがあってタイムスタンプもOK
      return false;
    }
    return true;
  }

  Future<void> addRssCache(String url, List<RssInformation> info) async {
    // スレッドセーブでキャッシュにいれる
    return _classLock.synchronized(() async {
      _cacheDateTime[url] = DateTime.now();
      // cloneをキャッシュに保持する
      _rssCache[url] = [...info];
      // デバッグ
      // _cacheDateTime.forEach(
      //   (key, value) {
      //     debugPrint("addRssCache:$url=cache|$key|$value|");
      //   },
      // );
    });
  }

  // ------------ ページキャッシュ(cocologの個別ページ向け)
  Map<String, PostStructure> _pageCache = {};

  bool pageCacheIsNotEmpty(String url) {
    if (!_checkCacheTime(url)) {
      return false;
    }
    return _pageCache.containsKey(url);
  }

  void addPageCache(String url, PostStructure postStructure) {
    _startCheckTime(url);
    _pageCache[url] = postStructure.copyWith();
  }

  PostStructure? getPageCache(String url) {
    return pageCacheIsNotEmpty(url) ? _pageCache[url] : null;
  }

  // 初期化処理
  void initCache() {
    _pageCache = {};
    _rssCache = {};
    _cacheDateTime = {};
    // debugPrint("initCache");
  }
}
