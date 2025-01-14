import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/bookmark_manager.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
// データ一覧からブックマークボタンを押したときのriverpod処理
// データ一覧<List<RssInformation>>を管理しようとしたが、LIST更新を検知しない
// ので単なるフラグ管理とする

class BookmarkNotifier extends StateNotifier<int> {
  BookmarkNotifier() : super(0);

  //
  // ブックマークのフラグを返す
  // BookmarkManager().bookmarkedList でRssinformationに移しているので
  // ここでは２重管理しない
  //
  bool flipBookmark(RssInformation info) {
    final manager = BookmarkManager();
    final bool bookmarkFlag = manager.getBookmarkState(info.link!);

    if (bookmarkFlag) {
      manager.removeBookmarks(info.link!);
    } else {
      manager.addBookmark(info.link!, info);
    }
    // デバッグ用
    // debugPrint("flipBookmak: ${info.bookmarked} ${info.link!}");
    // ここでstateを変更する
    state++;
    return (!bookmarkFlag);
  }
}

//Bookmark本体
// Widget bookmarkIcon(String url, RssInformation info) {
//   final manager = BookmarkManager();
//   final bool flag = manager.getBookmarkState(url);
//   return GestureDetector(
//       onTap: () {
//         flag ? manager.addBookmark(url, info) : manager.removeBookmarks(url);
//       },
//       child: flag
//           ? const Icon(Icons.bookmark, size: 24, color: Colors.red)
//           : const Icon(Icons.bookmark_outline, size: 24, color: Colors.black));
// }
