import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/bookmark_store.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert' as convert;

class BookmarkManager extends BookmarkStore {
  // Singletonデザインパターン
  static final BookmarkManager _instance = BookmarkManager._();
  BookmarkManager._();

  factory BookmarkManager() {
    return _instance;
  }

  //Bookmark本体
  // String: URL
  // RssInformation: RSS情報
  Map<String, RssInformation> _bookmarks = {};

  RssInformation? getBookmarkedRssInformation(String url) {
    return _bookmarks.containsKey(url) ? _bookmarks[url] : null;
  }

  bool getBookmarkState(String url) {
    return _bookmarks.containsKey(url);
  }

  bool isNotEmpty() {
    return _bookmarks.isNotEmpty;
  }

  // デバッグオプション
  void debugBookmarkState() {
    if (kReleaseMode) {
      debugPrint("bookmark = ${convert.json.encode(_bookmarks)}");
    }
  }

  // ブックマークの追加
  void addBookmark(String url, RssInformation info) {
    if (!getBookmarkState(url)) {
      _bookmarks[url] = info.copyWith(bookmarked: true);
      saveBookmarks();
    }
  }

  // ブックマークの削除（１件）
  void removeBookmarks(String url) {
    if (getBookmarkState(url)) {
      _bookmarks.remove(url);
      saveBookmarks();
    }
  }

  // ブックマークの全RssInformationのリストを返す
  List<RssInformation> bookmarkStreaming() {
    List<RssInformation> bookList = [];
    _bookmarks.forEach((key, value) {
      bookList.add(value);
    });

    return bookList;
  }

  // RssInformationのリストにブックマークフラグをつけて返す
  //
  List<RssInformation> bookmarkedList(List<RssInformation> rssList) {
    List<RssInformation> bookList = [];
    for (var item in rssList) {
      bookList.add(item.copyWith(bookmarked: getBookmarkState(item.link!)));
    }
    return bookList;
  }

  // ブックマークの保存
  void saveBookmarks() {
    super.saveBookmark(_bookmarks);
  }

  // ブックマークのロード
  void loadBookmarks() async {
    _bookmarks = await super.loadBookmark();

    // 非同期の待ちを入れようとしたがうまく同期しないので諦める
    // final pref = super.loadBookmark();
    // pref.then(
    //   (value) {
    //     _bookmarks = value;
    //   },
    // ).whenComplete(() => ());

    // debugPrint("loadBookmarks 1 ${_bookmarks.toString()}");

    // 返り値の関係でダミーの１権が帰って来るが、それは消す
    _bookmarks.remove("zero");

    // debugPrint("loadBookmarks 2 ${_bookmarks.toString()}");
  }

  // ブックマーク記録内容の削除
  void deleteBookmarks() {
    _bookmarks = {};
    super.removeBookmark();
  }

  //
  // BookmarkProvider
  // ブックマーク設定を監視するStateNotifier
  //
  Map<String, RssInformation> getBookmarkedMap() {
    return _bookmarks;
  }
}
