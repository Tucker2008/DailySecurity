import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/bookmark_manager.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
// データ一覧からブックマークボタンを押したときのriverpod処理
// Map型をStateNotifierで管理してBookMarkと同じ使い方が出来る

// BookmarkProviderの定義
// 関係モジュール共用
var bookmarkProvider =
    StateNotifierProvider<BookmarkNotifier, Map<String, RssInformation>>((ref) {
  return BookmarkNotifier();
});
BookmarkNotifier bookmarkNotifier = BookmarkNotifier();

//
//Bookmark Notiferクラス本体
//
class BookmarkNotifier extends StateNotifier<Map<String, RssInformation>> {
  BookmarkNotifier() : super(BookmarkManager().getBookmarkedMap());

  //
  // ブックマークのフラグを返す
  //
  bool flipBookmark(RssInformation info) {
    final manager = BookmarkManager();
    final bool bookmarkFlag = manager.getBookmarkState(info.link!);

    if (bookmarkFlag) {
      _removeItem(info.link!);
      manager.removeBookmarks(info.link!);
    } else {
      _addItem(info.link!, info);
      manager.addBookmark(info.link!, info);
    }
    // デバッグ用
    // debugPrint(
    //     "flipBookmak: $bookmarkFlag ${info.bookmarked} ${info.link!} ${_checkItem(info.link!)} ${manager.getBookmarkState(info.link!)}");
    // if (_checkItem(info.link!) != manager.getBookmarkState(info.link!)) {
    //   debugPrint(
    //       "flipBookmak: status異常 ${_checkItem(info.link!)} ${manager.getBookmarkState(info.link!)}");
    // }

    return (!bookmarkFlag);
  }

  void voidFlipBookmark(RssInformation info) {
    flipBookmark(info);
  }

  void _addItem(String key, RssInformation value) {
    state = {...state, key: value};
  }

  void _removeItem(String key) {
    final newState = Map<String, RssInformation>.from(state);
    newState.remove(key);
    state = newState;
  }
// デバッグ用
  // bool _checkItem(String key) {
  //   return Map<String, RssInformation>.from(state).containsKey(key);
  // }
}
