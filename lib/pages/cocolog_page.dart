import 'package:cyber_interigence/entry/display_feed.dart';
import 'package:cyber_interigence/repository/web_page.dart';
import 'package:cyber_interigence/util/color_provider.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/repository/rss_stream.dart';
import 'package:cyber_interigence/util/logo_provider.dart';
import 'package:cyber_interigence/util/url_provider.dart';
import 'package:cyber_interigence/util/widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/global.dart';

//
// ココログのRSS記事一覧画面
//
class CocologPage extends ConsumerWidget {
  CocologPage({super.key});

  // Providerの定義（RSS読み込み関数をまるごとProvider定義）
  final cocologProvider = FutureProvider.autoDispose
      .family<List<RssInformation>, String>((ref, url) async {
    return rssStreaming(cocologRss);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // RSSで取得したデータを格納する(rss_infomation.dart)
    // データ元はCacheManager
    List<RssInformation> informationList = [];
    // エラーメッセージ伝達用
    final noteProvider = NoteProvider();
    // Webページ用のコンテナ初期化
    WidgetProvider().removeWidget();

    // Feedを読む(fetch_feed.dart)
    // Feedを読む機能をfeedProvider登録し、その返り値を取得する
    final AsyncValue<List<RssInformation>> activity =
        ref.watch(cocologProvider(cocologRss));
    activity.when(
      data: (data) {
        informationList = data;
      },
      error: (error, stacktrace) => noteProvider.setNote(error.toString()),
      loading: () => (),
    );

    // これが表示されたという事は最初のログインとする
    PreferenceManager().updateLastLogin();

    return Scaffold(
      // AppBar ロゴを表示するだけ ----------------
      appBar: PreferredSize(
        // AppBarの大きさ指定
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: LogoProvider().getServiceLogo(),
          centerTitle: true,
        ),
      ),
      // Drawer ----------------

      drawer: SizedBox(
        width: 280, // iphoneでは狭すぎるのか？ 元256
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 140,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceDim,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "利用規約   及び\nプライバシーポリシー",
                        style: TextStyle(
                          fontSize: fontSize.body2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 利用規約の表示
              GestureDetector(
                onTap: () {
                  WidgetProvider().removeWidget();
                  UrlProvider().setUrl(termofusePage);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WebPage(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.assignment_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    "利用規約",
                    style: TextStyle(
                        fontSize: fontSize.body2,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
              ),
              // プライバシーポリシー表示
              GestureDetector(
                onTap: () {
                  WidgetProvider().removeWidget();
                  UrlProvider().setUrl(privercyPage);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WebPage(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.assignment_late_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    "プライバシーポリシー",
                    style: TextStyle(
                        fontSize: fontSize.body2,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
              ),
              // Drawerを閉じる
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.close_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    "閉じる",
                    style: TextStyle(
                        fontSize: fontSize.body2,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
              ),
              // 隠しボタン
              // GestureDetector(
              //   onTap: () {
              //     PreferenceManager().debugPrintState();
              //   },
              //   child: ListTile(
              //     leading: Icon(
              //       Icons.dashboard_customize,
              //       color: Theme.of(context).colorScheme.primary,
              //     ),
              //     title: Text(
              //       "サポート",
              //       style: TextStyle(
              //           fontSize: fontSize.body2,
              //           color: Theme.of(context).colorScheme.tertiary),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),

      // コンテンツ内容一覧 ----------------
      body: DisplayFeed(
              informationListArg: informationList,
              firstContainer: cocologFirstContainer)
          .displayFeed(context),
    );
  }

  //
  // インシデントに学ぶセキュリティアクション（説明Container）
  //
  final Widget cocologFirstContainer = Container(
    decoration: BoxDecoration(
      color: boxdecorationColor,
      border: Border(
        bottom: BorderSide(color: borderColor),
        top: BorderSide(color: borderColor),
      ),
    ),
    width: double.infinity,
    padding:
        const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
    margin: const EdgeInsets.all(4.0),
    child: Column(
      // 中央揃え
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          cocologTitle1,
          style: TextStyle(
            // color: frontColor,
            fontSize: fontSize.subTitle2,
          ),
        ),
        Text(
          cocologTitle2,
          style: TextStyle(
              // color: frontColor,
              fontSize: fontSize.subTitle1,
              fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}
