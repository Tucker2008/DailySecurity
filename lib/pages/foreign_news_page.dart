import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/global.dart';
// import 'package:cyber_interigence/methods/associate_methods.dart';
import 'package:cyber_interigence/methods/splash_screen.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/bookmark_manager.dart';
import 'package:cyber_interigence/repository/launch_url.dart';
import 'package:cyber_interigence/repository/mearge_news.dart';
import 'package:cyber_interigence/repository/rss_stream.dart';
import 'package:cyber_interigence/util/bookmark_provider.dart';
import 'package:cyber_interigence/util/color_provider.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:cyber_interigence/util/post_category.dart';
import 'package:cyber_interigence/util/widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
// 海外ニュース専用ページ
// 2025.4.17

class ForeignNewsPage extends ConsumerWidget {
  ForeignNewsPage({super.key});

  // Providerの定義（RSS読み込み関数をまるごとProvider定義）
  final feedProvider = FutureProvider.autoDispose
      .family<List<RssInformation>, String>((ref, url) async {
    return foreignNewsRssStreaming(url);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // RSSで取得したデータを格納する(rss_infomation.dart)
    List<RssInformation> informationList = [];
    // エラーメッセージ伝達用
    final noteProvider = NoteProvider();

    // WebPage表示時のContainer指定
    WidgetProvider().setWidget(feedFirstWebContainer);

    // Feedを読む(fetch_feed.dart)
    // Feedを読む機能をfeedProvider登録し、その返り値を取得する
    final AsyncValue<List<RssInformation>> activity =
        ref.watch(feedProvider(""));
    activity.when(
      data: (data) {
        informationList = data;
      },
      error: (error, stacktrace) => noteProvider.setNote(error.toString()),
      loading: () => splashScreenNoContext(),
    );

    // NewsFeedのまとめソートを受け取る
    // IPA等のニュースマージが間に合わない場合にはぐるぐるを出す
    if (meargeForeignNews(0) == null) {
      return splashScreen(context);
    } else {
      // 取得したリストにブックマークされているかフラグを付ける
      informationList = BookmarkManager().bookmarkedList(meargeForeignNews(0)!);
    }

    // BookMarkProviderにWatch定義
    Map<String, RssInformation> bookmarkMap = ref.watch(bookmarkProvider);
    bookmarkNotifier = ref.read(bookmarkProvider.notifier);

    // 何かエラーが発生していたら表示
    // ここで表示するとbuild中のエラー表示で停止するのでコメントアウト 2025.6.20
    // if (!noteProvider.isEmpty()) {
    //   AssociateMethods associateMethods = AssociateMethods();
    //   associateMethods.showSnackBarMsg(noteProvider.getNote(), context);
    // }

    // 画面build
    return Scaffold(
        // AppBar は main_screenにて対応済みの場合には出さず
        body: SingleChildScrollView(
      child: Column(
        children: [
          // ここには記事カテゴリに関する説明やヘッダを入れる
          foreignFirstContainer,
          //
          // 記事一覧のRSS表示本体
          //
          ListView.builder(
            itemCount: informationList.length,

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
                      // 翻訳マークを付ける 2025.6.20
                      (informationList[index].lang!.isNotEmpty)
                          ? Icon(Icons.translate,
                              size: fontSize.subTitle1,
                              color: Theme.of(context).colorScheme.primary)
                          : SizedBox(
                              width: fontSize.subTitle1,
                            ),
                      // 空白サイズ縮小 subTitle2->caption  2026.5.20
                      SizedBox(
                        width: fontSize.caption,
                      ),
                      Text(informationList[index].date),
                      // 空白サイズ縮小 subTitle2->caption  2026.5.20
                      SizedBox(
                        width: fontSize.caption,
                      ),
                      // Bookmarkマークは日付の後に移動(2025.2.12)
                      bookmarkMap.containsKey(informationList[index].link!)
                          ? Icon(Icons.bookmark,
                              size: fontSize.subTitle2,
                              color: Theme.of(context).colorScheme.primary)
                          : SizedBox(
                              width: fontSize.subTitle2,
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
                  onTap: () {
                    // debugPrint('foreign_news URL: ${informationList[index]}');
                    launchUrlByRss(context, informationList[index]);
                  },
                  textColor: Theme.of(context).colorScheme.onSurface,
                  // カテゴリ毎のアイコン
                  // カテゴリ指定がない場合だけにアイコンを表示する
                  leading: (informationList[index].category!.isNotEmpty &&
                          informationList[index].category! != "N/A")
                      ? (iconAvalable(informationList[index].category!)
                          ? Icon(
                              postCategoryIcon(
                                  informationList[index].category!),
                              size: 24 * (sizeConfig.screenWidthTimes!),
                            )
                          : CircleAvatar(
                              backgroundImage: postCategotyImageicon(
                                  informationList[index].category!),
                              radius: 16.0 *
                                  (sizeConfig.screenWidthTimes!), //ここは半径を指定する
                            ))
                      : null,
                  // 記事右のリンクアイコン
                  // Bookmarkマークは日付の前に移動(2025.2.12)
                ),
              );
            },
          ),
        ],
      ),
    ));
  }

  //
  // ニュースの説明
  //
  final Widget foreignFirstContainer = Container(
    decoration: BoxDecoration(
      color: boxdecorationColor,
      border: Border(
        bottom: BorderSide(color: borderColor),
        top: BorderSide(color: borderColor),
      ),
    ),
    width: double.infinity,
    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "海外のニュースサイトの$newsDetail",
          style: TextStyle(
            color: frontColor,
            fontSize: fontSize.subTitle2,
          ),
        ),
      ],
    ),
  );

  //
  // WEBページの説明
  //
  final Widget feedFirstWebContainer = Container(
    decoration: BoxDecoration(
      color: boxdecorationColor,
      border: Border(
        bottom: BorderSide(color: borderColor),
        top: BorderSide(color: borderColor),
      ),
    ),
    width: double.infinity,
    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          webTitle,
          style: TextStyle(
            color: frontColor,
            fontSize: fontSize.oberline,
          ),
        ),
      ],
    ),
  );
}
