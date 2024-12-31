import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/repository/cache_manager.dart';
import 'package:cyber_interigence/repository/launch_url.dart';
import 'package:cyber_interigence/repository/rss_stream.dart';
import 'package:flutter/material.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:cyber_interigence/util/post_category.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/methods/splash_screen.dart';
import 'package:cyber_interigence/util/url_provider.dart';

// セキュリティ記事の一覧:XMLをページに仕立てる
// RSSも時々時間がかかってsplashScreen()が出る

class DisplayFeed {
  List<RssInformation>? informationListArg;
  DisplayFeed({required this.informationListArg, required this.firstContainer});

  final urlProvider = UrlProvider();
  final noteProvider = NoteProvider();

  //
  // RSSのリストの上のに表示するコンテンツを指定する
  //
  Widget firstContainer = Container();
  //
  // IPA等の他サイトのFeed表示
  // Cocolog記事表示
  //
  Widget displayFeed(BuildContext context) {
    List<RssInformation> informationList = informationListArg!;
    // まだデータができていない場合にはsplashを出して終える
    if (informationList.isEmpty) {
      final errNote = noteProvider.getNote();
      return errNote.isEmpty
          ? splashScreen(context)
          : splashScreenException(errNote);
    }

    // コンテンツ内容一覧 ----------------
    return SingleChildScrollView(
      child: Column(
        children: [
          // ここには記事カテゴリに関する説明やヘッダを入れる
          firstContainer,
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
                    top: BorderSide(
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
                  ),
                ),
                child: ListTile(
                  // ヘッダ：日付
                  subtitle: Align(
                    alignment: Alignment.centerRight,
                    child: Text(informationList[index].date),
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
                  onTap: () =>
                      {launchURL(context, informationList[index].link!)},
                  textColor: Theme.of(context).colorScheme.onSurface,
                  // カテゴリ毎のアイコン
                  // "N/A"は設定がない意味なので、アイコンも出さない
                  leading: (informationList[index].category!.isNotEmpty &&
                          informationList[index].category! != "N/A")
                      ? Icon(
                          postCategoryIcon(informationList[index].category!),
                          size: 24,
                        )
                      : null,
                  // 記事右のリンクアイコン
                  trailing: informationList[index].link!.isNotEmpty
                      ? const Icon(
                          Icons.link,
                          size: 24,
                        )
                      : null,
                ),
              );
            },
          ),
        ],
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }

  bool findLaunchPage(BuildContext context, String title) {
    // キャッシュからRSSを引っ張る
    if (CacheManager().getRssCacheIsEmpty(cocologRss)) {
      // キャッシュにない？のでロードする
      rssStreaming(cocologRss);
    }
    List<RssInformation>? informationList =
        CacheManager().getRssCache(cocologRss);
    if (informationList == null) {
      return false;
    }
    for (var item in informationList) {
      if (item.title == title) {
        // デバッグ
        // debugPrint("findLaunchPage: find ${item.title}");
        launchURL(context, item.link!);
        return true;
      }
    }
    return false;
  }
}
