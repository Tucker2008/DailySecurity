import 'package:cyber_interigence/global.dart';
// import 'package:cyber_interigence/model/rss_information.dart';
// import 'package:cyber_interigence/repository/bookmark_manager.dart';
import 'package:cyber_interigence/util/logo_provider.dart';
import 'package:flutter/material.dart';

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
  // ※各コンテンツ表示ページに実装しようとしたが、riverpodコントローラと
  // データの受け渡しが難しくて断念
  // PreferredSizeWidget getBookmarkedAppbarConstant(
  //     String url, RssInformation? rss) {
  //   // そもそもRSSinformationが渡っていない場合にはブックマーク機能提供しない
  //   if (rss == null) {
  //     return getAppbarConstant();
  //   }
  //   // ブックマークされているか否か
  //   final bookMarked = BookmarkManager().getBookmarkState(url);
  //   // ブックマーク付きのAppBarを生成
  //   return PreferredSize(
  //     // AppBarの大きさ指定
  //     preferredSize: const Size.fromHeight(kToolbarHeight) *
  //         (sizeConfig.screenWidthTimes!),
  //     child: AppBar(
  //       title: LogoProvider().getServiceLogo(),
  //       centerTitle: true,
  //       actions: <Widget>[
  //         IconButton(
  //           icon: Icon(bookMarked ? Icons.bookmark : Icons.bookmark_outline),
  //           onPressed: () {
  //             // アイコンが押されたときの処理
  //             if (bookMarked) {
  //               BookmarkManager().removeBookmarks(url);
  //             } else {
  //               BookmarkManager().addBookmark(url, rss);
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
