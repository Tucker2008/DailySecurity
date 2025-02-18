import 'package:cyber_interigence/constant/bookmark_constant.dart';
import 'package:cyber_interigence/repository/bookmark_manager.dart';
import 'package:cyber_interigence/repository/launch_url.dart';
import 'package:cyber_interigence/util/bookmark_provider.dart';
import 'package:cyber_interigence/util/color_provider.dart';
import 'package:cyber_interigence/util/post_category.dart';
import 'package:cyber_interigence/util/widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/global.dart';

//
// ブックマークされた記事一覧画面
//
class BookmarkPage extends ConsumerWidget {
  BookmarkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Webページ用のコンテナ初期化
    WidgetProvider().removeWidget();

    // Bookmark Providerのwatchを定義
    Map<String, RssInformation> bookmarkMap = ref.watch(bookmarkProvider);
    bookmarkNotifier = ref.read(bookmarkProvider.notifier);

    // RSSで取得したデータを格納する(rss_infomation.dart)
    // データ元はCacheManager
    List<RssInformation> informationList =
        BookmarkManager().bookmarkStreaming();

    // ブックマークリストがなければ利用方法を表示して終わり
    if (!BookmarkManager().isNotEmpty()) {
      return bookmarkIsEmptyContainer;
    }

    return Scaffold(
        // AppBar ロゴはmainMenuで表示されている ----------------
        // コンテンツ内容一覧 ----------------
        body: SingleChildScrollView(
      child: Column(
        children: [
          // 説明やヘッダを入れる
          bookmarkContainer,
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
                  // 記事右のBookmarkマークは日付の前に移動(2025.2.12)
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(informationList[index].date),
                      SizedBox(
                        width: fontSize.subTitle2,
                      ),
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
                  onTap: () {
                    // ページ表示
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
                              size: 32 * (sizeConfig.screenWidthTimes!),
                            )
                          : CircleAvatar(
                              backgroundImage: postCategotyImageicon(
                                  informationList[index].category!),
                              radius: 16.0 *
                                  (sizeConfig.screenWidthTimes!), //ここは半径を指定する
                            ))
                      : null,
                  // 記事右のBookmarkマークは日付の前に移動(2025.2.12)
                ),
              );
            },
          ),
        ],
      ),
    )); // This trailing comma makes auto-formatting nicer for build methods.
  }

  //
  // インシデントに学ぶセキュリティアクション（説明Container）
  //
  final Widget bookmarkContainer = Container(
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
          bookmarkTitle1,
          style: TextStyle(
            // color: frontColor,
            fontSize: fontSize.subTitle2,
          ),
        ),
        Text(
          bookmarkTitle,
          style: TextStyle(
              // color: frontColor,
              fontSize: fontSize.subTitle1,
              fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );

  //
  // ブックマークがカラの場合の説明ページ
  //
  final Widget bookmarkIsEmptyContainer = Container(
    width: double.infinity,
    height: double.infinity,
    padding: const EdgeInsets.all(24.0),
    child: SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Text(
            bookmarkIsEmpty,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 32),
          const Text(
            bookmarkGuide,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 32),
          Image.asset(
            'images/BookmarkPageImage.png',
            width: 370,
            height: 231,
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}
