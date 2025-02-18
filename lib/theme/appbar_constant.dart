import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/bookmark_manager.dart';
import 'package:cyber_interigence/util/logo_provider.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:cyber_interigence/util/bookmark_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
// AppBarを共通化する
// ほとんどのページでAppBar指定が必要なために作成
//

class AppbarConstant {
  // クラス内インスタンス
  static final AppbarConstant _instance = AppbarConstant._();
  // プライベートコンストラクタ
  AppbarConstant._();

  factory AppbarConstant() {
    return _instance;
  }

  // 共通AppBarを返す
  PreferredSizeWidget getAppbarConstant() {
    return PreferredSize(
      // AppBarの大きさ指定
      preferredSize: const Size.fromHeight(kToolbarHeight) *
          (sizeConfig.screenWidthTimes!),
      child: AppBar(
        title: LogoProvider().getServiceLogo(),
        centerTitle: true,
        // ICONサイズ
        iconTheme: IconThemeData(size: sizeConfig.mainMenuIconSize),
      ),
    );
  }

  // ブックマーク付きAppBarを返す
  PreferredSizeWidget getBookmarkedAppbarConstant(
      String url, RssInformation? rss, WidgetRef ref) {
    // そもそもRSSinformationが渡っていない場合にはブックマーク機能提供しない
    // RSSがダミーだった場合にはRSSがないものとする
    if ((rss == null) || (rss.title.isEmpty)) {
      // debugPrint("getBookmarkedAppbarConstant rss is null");
      return getAppbarConstant();
    }
    // ブックマークされているか否か
    // Bookmark Providerのwatchを定義
    Map<String, RssInformation> bookmarkMap = ref.watch(bookmarkProvider);
    bool bookMarked = BookmarkManager().getBookmarkState(url);
    if (bookmarkMap.containsKey(url) != bookMarked) {
      // どこかで狂った？
      NoteProvider()
          .setNote("BookmarkedAppbarConstant: Flag is something wrong");
    }
    // ブックマーク付きのAppBarを生成
    return PreferredSize(
      // AppBarの大きさ指定
      preferredSize: const Size.fromHeight(kToolbarHeight) *
          (sizeConfig.screenWidthTimes!),
      child: AppBar(
        title: LogoProvider().getServiceLogo(),
        centerTitle: true,
        // ICONサイズ
        iconTheme: IconThemeData(size: sizeConfig.mainMenuIconSize),
        // ブックマークアイコン及びその扱い
        actions: <Widget>[
          IconButton(
            icon: Icon(
              bookMarked ? Icons.bookmark : Icons.bookmark_outline,
              size: sizeConfig.mainMenuIconSize,
            ),
            onPressed: () {
              // アイコンが押されたときの処理
              final doFlag = bookmarkNotifier.flipBookmark(rss!);
              rss = rss!.copyWith(bookmarked: doFlag);
            },
          ),
          // ちょっとスペースを空ける
          SizedBox(
            width: sizeConfig.mainMenuIconSize/2,
          )
        ],
      ),
    );
  }
}
