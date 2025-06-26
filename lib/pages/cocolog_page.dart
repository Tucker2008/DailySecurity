import 'package:cyber_interigence/methods/splash_screen.dart';
import 'package:cyber_interigence/repository/bookmark_manager.dart';
import 'package:cyber_interigence/repository/launch_url.dart';
import 'package:cyber_interigence/repository/mearge_news.dart';
import 'package:cyber_interigence/theme/date_form.dart';
import 'package:cyber_interigence/util/bookmark_provider.dart';
import 'package:cyber_interigence/util/color_provider.dart';
import 'package:cyber_interigence/repository/rss_stream.dart';
import 'package:cyber_interigence/util/post_category.dart';
import 'package:cyber_interigence/util/widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/global.dart';

// RSSで取得したデータを格納する(rss_infomation.dart)
// データ元はCacheManager
List<RssInformation> informationList = [];

//
// ココログのRSS記事一覧画面
//
class CocologPage extends ConsumerWidget {
  CocologPage({super.key, required this.argCategory});

  final String argCategory;

  // Providerの定義（RSS読み込み関数をまるごとProvider定義）
  // インシデント系ニュースも同時に読み込む(2025.6.19)
  final cocologProvider = FutureProvider.autoDispose
      .family<List<RssInformation>, String>((ref, url) async {
    // return rssStreaming(cocologRss);
    return incidentRssStreaming(cocologRss);
  });

  // 取得したリストにブックマークされているかフラグを付ける
  int _addBookmark2InfomationList() {
    informationList = BookmarkManager().bookmarkedList(informationList);
    return informationList.length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // エラーメッセージ伝達用
    final noteProvider = NoteProvider();
    // Webページ用のコンテナ初期化
    WidgetProvider().removeWidget();
    bool loadFault = false;

    // ココログのコラム コンテナ作成(context引き渡しのため関数化)
    final Widget cocologColumnContainer = _makeCocologColumnContainer(context);

    // Feedを読む(fetch_feed.dart)
    // Feedを読む機能をfeedProvider登録し、その返り値を取得する
    final AsyncValue<List<RssInformation>> activity =
        ref.watch(cocologProvider(cocologRss));
    activity.when(
      data: (data) {
        // カテゴリ指定されていた場合にはフィルタする
        if (argCategory.isNotEmpty) {
          informationList = filteringList(data, argCategory, minFeedCount)!;
        } else {
          informationList = data;
        }
      },
      error: (error, stacktrace) {
        noteProvider.setNote(error.toString());
        loadFault = true;
      },
      loading: () => splashScreenNoContext(),
    );

    // IPA等のニュースマージが間に合わない場合にはぐるぐるを出す
    if (informationList.isEmpty && (loadFault == false)) {
      // debugPrint("ぐるぐる ${informationList.length} $loadFault ");
      return splashScreen(context);
    }

    // Cocologコラムにインシデントニュース群を加えてマージする 2025.6.19
    informationList = meargeIncidentNews(0, informationList)!;

    // Bookmark Providerのwatchを定義
    final bookmarkMap = ref.watch(bookmarkProvider);
    bookmarkNotifier = ref.read(bookmarkProvider.notifier);

    return Scaffold(
        // AppBar Build5で表示方法変更のためappbarを表示しない
        // appBar: AppbarConstant().getAppbarConstant(),
        // 記事一覧表示
        body: SingleChildScrollView(
      child: Column(
        children: [
          // ここには記事カテゴリに関する説明やヘッダを入れる
          argCategory == "news" ? cocologNewsContainer : cocologColumnContainer,
          //
          // 記事一覧のRSS表示本体
          //
          ListView.builder(
            // 取得したリストにブックマークされているかフラグを付ける
            itemCount: _addBookmark2InfomationList(),

            scrollDirection: Axis.vertical, // スクロール方向を垂直に設定
            reverse: false, // 順序を逆にしない
            // リスト全体に8ピクセルの余白を追加
            // padding: const EdgeInsets.all(8.0),
            primary: true, // このリストがプライマリスクロールビューかどうかを指定

            // 以下の2つの設定はSingleScrollView内でListViewを使う場合に必要
            // shrinkWrap: false, // リストの高さをその内容に基づいて調整しない
            // physics: const BouncingScrollPhysics(), // スクロール挙動を指定
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            addAutomaticKeepAlives: true, // 各アイテムが自動的に保持されるかどうかを指定
            addRepaintBoundaries: true, // 各アイテムが再描画境界を持つかどうかを指定
            addSemanticIndexes: true, // 各アイテムがセマンティックインデックスを持つかどうかを指定

            itemBuilder: (context, index) {
              return Container(
                // margin: const EdgeInsets.symmetric(vertical: 1), // 4
                // 背景色と区切り線を定義
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  // 上下のみに薄い線を入れる
                  border: Border(
                    bottom: BorderSide(
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
                    // top: は入れない
                  ),
                ),
                child: ListTile(
                  // ヘッダ：日付
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // 日付から末尾の秒を取る(2025.6.26)
                      Text(informationList[index]
                          .date
                          .replaceAll(RegExp(regexDelSec), '')),
                      SizedBox(
                        width: fontSize.subTitle2,
                      ),
                      // Bookmarkマークは日付の前に移動(2025.2.12)
                      bookmarkMap.containsKey(informationList[index].link!)
                          ? Icon(Icons.bookmark,
                              size: fontSize.subTitle1,
                              color: Theme.of(context).colorScheme.primary)
                          : SizedBox(
                              width: fontSize.subTitle1,
                            ),
                    ],
                  ),

                  subtitleTextStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: fontSize.subTitle2,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: Text(
                    informationList[index].title,
                    // 長いタイトルを省略表示
                    // overflow: TextOverflow.ellipsis,を行数を指定して使うとちょうどいい
                    overflow: TextOverflow.ellipsis,
                    maxLines: titleLineMax,
                  ),
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize.subTitle1,
                    color: Theme.of(context).colorScheme.onSurface,
                    // 行間を少し狭く
                    height: 1.2,
                  ),
                  // タップされた時に記事を表示
                  onTap: () {
                    // ページ表示
                    launchUrlByRss(context, informationList[index]);
                  },
                  textColor: Theme.of(context).colorScheme.onSurface,
                  // カテゴリ毎のアイコン
                  // カテゴリ指定がない場合だけにアイコンを表示する
                  // 削除条件文：&&　argCategory.isEmpty 2026.6.19
                  leading: (informationList[index].category!.isNotEmpty &&
                          informationList[index].category! != dateFormNA)
                      ? (iconAvalable(informationList[index].category!)
                          ? Icon(
                              postCategoryIcon(
                                  informationList[index].category!),
                              size: 24,
                            )
                          : CircleAvatar(
                              backgroundImage: postCategotyImageicon(
                                  informationList[index].category!),
                              radius: 12.0, //ここは半径を指定する
                            ))
                      : null,
                  // 記事右のBookmarkマークは日付の前に移動(2025.2.12)
                ),
              );
            },
          ),
        ],
      ),
    )
        // --------------------------
        );
  }

  //
  // インシデントに学ぶセキュリティアクション（説明Container）
  //
  Widget _makeCocologColumnContainer(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          // const SizedBox(
          //   width: 30,
          // ),
          const Spacer(),
          Column(
            // 中央揃え
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                cocologTitle1,
                style: TextStyle(
                  color: frontColor,
                  fontSize: fontSize.subTitle2,
                ),
              ),
              Text(
                cocologTitle2,
                style: TextStyle(
                    color: frontColor,
                    fontSize: fontSize.subTitle1,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),

          const Spacer(),
          // ※2025.4.20 検索機能は作り直しなので、検索ボタンは封印
          // IconButton(
          //   icon: Icon(
          //     Icons.search_rounded, // content_paste_search_outlined,
          //     size: sizeConfig.mainMenuIconSize,
          //   ),
          //   // アイコンが押されたときの処理
          //   onPressed: () {
          //     inputDialog(context, '記事検索', '検索内容を入力', 'キャンセル', '検索');
          //     // String title, String hint,String cancelTitle, String goTitle

          //   },
          // ),
          // const SizedBox(
          //   width: 30,
          // ),
        ],
      ),
    );
  }

  //
  // インシデントに学ぶセキュリティアクション（説明Container）
  //
  final Widget cocologNewsContainer = Container(
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
          cocologNews1,
          style: TextStyle(
            color: frontColor,
            fontSize: fontSize.subTitle2,
          ),
        ),
        Text(
          cocologNews2,
          style: TextStyle(
              color: frontColor,
              fontSize: fontSize.subTitle1,
              fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}
