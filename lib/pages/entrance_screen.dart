import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/methods/splash_screen.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/pages/cocolog_page.dart';
import 'package:cyber_interigence/pages/cycle_screen.dart';
import 'package:cyber_interigence/pages/news_main_page.dart';
import 'package:cyber_interigence/repository/cycle_manager.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/repository/rss_stream.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:cyber_interigence/util/post_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntranceScreen extends ConsumerWidget {
  EntranceScreen({super.key});

  // Providerの定義（RSS読み込み関数をまるごとProvider定義）
  final cocologProvider = FutureProvider.autoDispose
      .family<List<RssInformation>, String>((ref, url) async {
    return allRssStreaming(cocologRss);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 各ボックス共通の定義
    BoxDecoration boxDecortion = BoxDecoration(
      // color: Theme.of(context).colorScheme.tertiary,  //色は上書き個別指定
      borderRadius: BorderRadius.circular(15), //角を丸める
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.secondary,
          spreadRadius: 3, //影の幅
          blurRadius: 10, //影のぼやけ（小さいと濃い）
          offset: const Offset(5, 5), //光の当たる角度5:5は左上
        ),
      ],
    );

    // エラーメッセージ伝達用
    final noteProvider = NoteProvider();

    // RSSの取得関連------------------------

    // RSSで取得したデータを格納する(rss_infomation.dart)
    // データ元はCacheManager
    List<RssInformation> informationList = [];
    List<RssInformation> newsList = [];
    List<RssInformation> columnList = [];
    List<RssInformation> publicNewsList = [];

    // Feedを読む(fetch_feed.dart)
    // Feedを読む機能をfeedProvider登録し、その返り値を取得する
    //
    final AsyncValue<List<RssInformation>> activity =
        ref.watch(cocologProvider(cocologRss));
    activity.when(
      data: (data) {
        informationList = data;
        newsList =
            filteringList(informationList, newsCategory, entranceNewsMax)!;
        columnList =
            filteringList(informationList, columnCategory, entranceNewsMax)!;
      },
      error: (error, stacktrace) => noteProvider.setNote(error.toString()),
      loading: () => splashScreenNoContext(),
    );

    // これが表示されたという事は最初のログインとする
    PreferenceManager().updateLastLogin();
    // IPA等のニュースマージが間に合わない場合にはぐるぐるを出す
    if (meargeNews(entranceNewsMax) == null) {
      return splashScreen(context);
    } else {
      publicNewsList = meargeNews(entranceNewsMax)!;
    }

    //ここまでRSS取得関連-----------
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // アップデート情報
            Expanded(
              // 比率指定
              flex: 6, // 3 * 2
              child: GestureDetector(
                // タップ処理
                onTap: () {
                  //  CocologPageのカテゴリ指定で起動
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CocologPage(argCategory: "news"),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(
                      left: 8, right: 8, top: 0, bottom: 4),
                  width: double.infinity, //ここはデカくしても最大が決まっている
                  decoration: boxDecortion.copyWith(
                    color: Theme.of(context).colorScheme.tertiaryFixedDim,
                    image: const DecorationImage(
                      image: AssetImage('images/Entrance_screen_update.png'),
                      fit: BoxFit.fill,
                      opacity: 0.5, //透明度は常に検討
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // タイルタイトル
                      Text(
                        entranceTitleUpdate,
                        style: TextStyle(
                          fontSize: fontSize.body1,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onTertiaryFixed,
                        ),
                      ),
                      // newsカテゴリを表示する ----------------
                      ListView.builder(
                        // ★行の高さ指定
                        itemExtent: fontSize.body1 * 1.6,
                        // アイテムの数を設定するフリをしてリストのフィルタ実施
                        itemCount: newsList.length, //informationList.length,

                        // scrollDirection: Axis.vertical, // スクロール方向を垂直に設定
                        reverse: false, // 順序を逆にしない
                        // リスト全体に余白を削除
                        padding: const EdgeInsets.all(0.0),
                        primary: true, // このリストがプライマリスクロールビューかどうかを指定

                        // 以下の2つの設定はSingleScrollView内でListViewを使う場合に必要
                        // shrinkWrap: false, // リストの高さをその内容に基づいて調整しない
                        // physics: const BouncingScrollPhysics(), // スクロール挙動を指定
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        addAutomaticKeepAlives: true, // 各アイテムが自動的に保持されるかどうかを指定
                        addRepaintBoundaries: true, // 各アイテムが再描画境界を持つかどうかを指定
                        addSemanticIndexes:
                            true, // 各アイテムがセマンティックインデックスを持つかどうかを指定

                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              newsList[index].title,
                              // 長いタイトルを省略表示
                              // overflow: TextOverflow.ellipsis,を行数を指定して使うとちょうどいい
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                            titleTextStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: fontSize.body1,
                              color:
                                  Theme.of(context).colorScheme.onTertiaryFixed,
                              // 行間を少し狭く
                              height: 1.5,
                            ),
                            // onTap: () => {}, //個別タップはない

                            textColor:
                                Theme.of(context).colorScheme.onTertiaryFixed,
                          );
                        },
                      ),

                      // newsカテゴリを表示する (end)----------------
                    ],
                  ),
                ),
              ),
            ),

            // インシデントから学ぶ＆セキュリティニュース
            Expanded(
              flex: 14, // 7 * 2
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //  CocologPageのカテゴリ指定で起動
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CocologPage(argCategory: "column"),
                            ),
                          );
                        },
                        child: Container(
                          height: double.infinity, //ここはデカくしても最大が決まっている
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(
                              left: 8, right: 4, top: 4, bottom: 4),
                          decoration: boxDecortion.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            image: const DecorationImage(
                              image: AssetImage(
                                  'images/Entrance_screen_design.png'),
                              fit: BoxFit.fill,
                              opacity: 0.5, //透明度は常に検討
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cocologTitle1,
                                style: TextStyle(
                                  fontSize: fontSize.body2,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              // columnカテゴリを表示する ----------------
                              ListView.builder(
                                // ★行の高さ指定
                                itemExtent: fontSize.headlineH6 * 4.2,
                                // アイテムの数を設定するフリをしてリストのフィルタ実施
                                itemCount:
                                    columnList.length, //informationList.length,

                                // scrollDirection: Axis.vertical, // スクロール方向を垂直に設定
                                reverse: false, // 順序を逆にしない
                                // リスト全体に余白を削除
                                padding: const EdgeInsets.all(0.0),
                                primary: true, // このリストがプライマリスクロールビューかどうかを指定

                                // 以下の2つの設定はSingleScrollView内でListViewを使う場合に必要
                                // shrinkWrap: false, // リストの高さをその内容に基づいて調整しない
                                // physics: const BouncingScrollPhysics(), // スクロール挙動を指定
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                addAutomaticKeepAlives:
                                    true, // 各アイテムが自動的に保持されるかどうかを指定
                                addRepaintBoundaries:
                                    true, // 各アイテムが再描画境界を持つかどうかを指定
                                addSemanticIndexes:
                                    true, // 各アイテムがセマンティックインデックスを持つかどうかを指定

                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      columnList[index].title,
                                      // 長いタイトルを省略表示
                                      // overflow: TextOverflow.ellipsis,を行数を指定して使うとちょうどいい
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3, //titleLineMax -> 1
                                      softWrap: true,
                                    ),
                                    titleTextStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: fontSize.body1,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiaryFixed,
                                      // 行間を少し狭く
                                      height: 1.3,
                                    ),
                                    // onTap: () => {}, //個別タップはない
                                    // {launchURL(context, informationList[index].link!)},
                                    textColor: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryFixed,
                                  );
                                },
                              ),
                              // columnカテゴリを表示する (end)----------------
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 他セキュリティ関連ニュース
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NewsMainPage(
                                arg: true,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: double.infinity, //ここはデカくしても最大が決まっている
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(
                              left: 4, right: 8, top: 4, bottom: 4),
                          decoration: boxDecortion.copyWith(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            image: const DecorationImage(
                              image:
                                  AssetImage('images/Entrance_screen_news.png'),
                              fit: BoxFit.fill,
                              opacity: 0.15, //透明度は常に検討
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entranceTitleNews,
                                style: TextStyle(
                                  fontSize: fontSize.body2,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inverseSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              // 他ニュースを表示する ----------------
                              ListView.builder(
                                // ★行の高さ指定
                                itemExtent: fontSize.headlineH6 * 4.3,
                                // アイテムの数を設定するフリをしてリストのフィルタ実施
                                itemCount: publicNewsList.length, //

                                // scrollDirection: Axis.vertical, // スクロール方向を垂直に設定
                                reverse: false, // 順序を逆にしない
                                // リスト全体に余白を削除
                                padding: const EdgeInsets.all(0.0),
                                primary: true, // このリストがプライマリスクロールビューかどうかを指定

                                // 以下の2つの設定はSingleScrollView内でListViewを使う場合に必要
                                // shrinkWrap: false, // リストの高さをその内容に基づいて調整しない
                                // physics: const BouncingScrollPhysics(), // スクロール挙動を指定
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                addAutomaticKeepAlives:
                                    true, // 各アイテムが自動的に保持されるかどうかを指定
                                addRepaintBoundaries:
                                    true, // 各アイテムが再描画境界を持つかどうかを指定
                                addSemanticIndexes:
                                    true, // 各アイテムがセマンティックインデックスを持つかどうかを指定

                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      publicNewsList[index].title,
                                      // 長いタイトルを省略表示
                                      // overflow: TextOverflow.ellipsis,を行数を指定して使うとちょうどいい
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      softWrap: true,
                                    ),
                                    titleTextStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSize.body1, //subTitle1 ->
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiaryFixed,
                                      // 行間を少し狭く
                                      height: 1.3,
                                    ),
                                    // onTap: () => {}, //個別タップはない

                                    textColor: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 3.0, color: Colors.black),
                                    ),
                                  );
                                },
                              ),
                              // columnカテゴリを表示する (end)----------------
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // セキュリティリマインダー
            Expanded(
              flex: 3, // 2 * 2
              child: GestureDetector(
                onTap: () {
                  //  CocologPageのカテゴリ指定で起動
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CycleScreen(
                        appbar: true,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(
                      left: 8, right: 8, top: 4, bottom: 4),
                  width: double.infinity, //ここはデカくしても最大が決まっている
                  decoration: boxDecortion.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    image: const DecorationImage(
                      image: AssetImage('images/Entrance_screen_reminder.png'),
                      fit: BoxFit.fill,
                      opacity: 0.3,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entranceTitleReminder,
                        style: TextStyle(
                          fontSize: fontSize.body1,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        CycleManager().getScenarioNumberText(),
                        style: TextStyle(
                          fontSize: fontSize.body2,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 特集記事（ver1.1に掲載予定）
            // Expanded(
            //   flex: 2,
            //   child: Container(
            //     padding: const EdgeInsets.all(8.0),
            //     margin:
            //         const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
            //     width: double.infinity, //ここはデカくしても最大が決まっている
            //     decoration: boxDecortion.copyWith(
            //       color: Theme.of(context).colorScheme.tertiary,
            //       image: const DecorationImage(
            //         image: AssetImage('images/Entrance_screen_edit.png'),
            //         fit: BoxFit.fill,
            //         opacity: 0.3,
            //       ),
            //     ),
            //     child: Text(
            //       '特集記事',
            //       style: TextStyle(
            //         fontSize: fontSize.body1,
            //         color: Theme.of(context).colorScheme.onTertiary,
            //       ),
            //     ),
            //   ),
            // ),
            // ここまで 特集記事（ver1.1に掲載予定）
          ],
        ),
      ),
    );
  }
}
