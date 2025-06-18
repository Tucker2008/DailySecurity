import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/pages/bookmark_page.dart';
import 'package:cyber_interigence/repository/bookmark_manager.dart';
import 'package:cyber_interigence/util/logo_provider.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:cyber_interigence/util/bookmark_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cyber_interigence/methods/associate_methods.dart';

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
  PreferredSizeWidget getAppbarConstant(BuildContext? ctx) {
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
              Icons.bookmarks_outlined,
              size: sizeConfig.mainMenuIconSize,
            ),
            // アイコンが押されたときの処理
            onPressed: () {
              Navigator.of(ctx!).push(
                  MaterialPageRoute(builder: (context) => BookmarkPage()));
            },
          ),
          // ちょっとスペースを空ける
          SizedBox(
            width: sizeConfig.mainMenuIconSize / 2,
          )
        ],
      ),
    );
  }

  // ブックマークページを呼ばない共通AppBar(2025.6.18)
  PreferredSizeWidget getAppbarConstantNoBookmark(BuildContext? ctx) {
    return PreferredSize(
      // AppBarの大きさ指定
      preferredSize: const Size.fromHeight(kToolbarHeight) *
          (sizeConfig.screenWidthTimes!),
      child: AppBar(
        title: LogoProvider().getServiceLogo(),
        centerTitle: true,
        // ICONサイズ
        iconTheme: IconThemeData(size: sizeConfig.mainMenuIconSize),
        // ブックマークページは呼ばない
      ),
    );
  }


  // ブックマーク付きAppBarを返す
  PreferredSizeWidget getBookmarkedAppbarConstant(
      String url, RssInformation? rss, WidgetRef ref, BuildContext? ctx) {
    // そもそもRSSinformationが渡っていない場合にはブックマーク機能提供しない
    // RSSがダミーだった場合にはRSSがないものとする
    if ((rss == null) || (rss.title.isEmpty)) {
      // debugPrint("getBookmarkedAppbarConstant rss is null");
      return getAppbarConstant(ctx);
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
          // 共有ボタン
          IconButton(
              icon: Icon(
                Icons.share,
                size: sizeConfig.mainMenuIconSize,
              ),
              onPressed: () {
                final msg = _shareButtonPressed(ctx!, rss!);
                AssociateMethods().showSnackBarMsg("共有機能の処理が$msg", ctx);
              }),
          // BookMarkボタン
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
            width: sizeConfig.mainMenuIconSize / 2,
          )
        ],
      ),
    );
  }

  // 共有ボタンの実装
  // 2025.4.20
  Future<String> _shareButtonPressed(
      BuildContext ctx, RssInformation rss) async {
    final box = ctx.findRenderObject() as RenderBox?;
    ShareResult shareResult;
    // 2025.5.14 SharePlusの使い方修正 合わせてFlutter3.7対応
    shareResult = await SharePlus.instance.share(
        ShareParams(
          uri: Uri.parse(
          rss.link!,
        ),
        title: rss.title.isEmpty ? null: rss.title,
        subject: rss.text.isEmpty ? null: rss.text,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,),);

    final String msg =
        shareResult.status == ShareResultStatus.success ? "完了しました" : "失敗しました";
    // debugPrint("_shareButtonPressed: $shareResult");
    return msg;
  }
}
