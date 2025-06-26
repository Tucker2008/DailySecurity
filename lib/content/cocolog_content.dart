import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/cocolog_stream.dart';
import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:cyber_interigence/theme/date_form.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/methods/splash_screen.dart';
import 'package:cyber_interigence/model/post_structure.dart';
import 'package:cyber_interigence/util/url_provider.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/repository/launch_url.dart';
import 'package:cyber_interigence/util/tile_container.dart';
import 'package:cyber_interigence/util/widget_provider.dart';
import 'package:cyber_interigence/util/bookmark_provider.dart';

//
// ポストされた内容を保持する
//
PostStructure postStructure = PostStructure(
  category: "",
  entoryTitle: "",
  dateHeader: DateTime.now(),
);

//
// ココログ記事を取得表示する
// 引数のURLはURLプロバイダが受け渡し
//
class CocologContent extends ConsumerWidget {
  final RssInformation? cocologRss; // ココログのURL
  CocologContent({super.key, this.cocologRss});

  // 情報源リスト
  final List<Widget> linkList = [];
  final double debugBoarderWith = 0.0;

  // Build
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 引数の処理（渡っていたら取り出す）
    RssInformation? rssInfo = cocologRss;
    // 引数のURLを強引に渡す
    String targetUrl = rssInfo == null ? UrlProvider().getUrl() : rssInfo.link!;

    // entryを読む機能をentryProvider登録し、その返り値を取得する
    AsyncValue activity = ref.watch(entryProvider(targetUrl));
    activity.when(
      data: (data) {
        postStructure = data;
      },
      error: (error, stacktrace) => splashScreenException(error.toString()),
      loading: () {
        splashScreenNoContext();
      },
    );
    // カラの状態で抜けてきたらBuild()が再度コールされるのでここでトラップする
    if (postStructure.entoryTitle.isEmpty) {
      // 何等かの障害でエラーの場合はエラー表示
      if (NoteProvider().isEmpty()) {
        return splashScreen(context);
      } else {
        return splashScreenException(NoteProvider().getNote());
      }
    }

    // 情報源リスト
    linkList.clear();
    _buildLinkList(context);

    // BookMarkProviderにWatch定義
    Map<String, RssInformation> bookmarkMap = ref.watch(bookmarkProvider);
    bookmarkNotifier = ref.read(bookmarkProvider.notifier);

    return Scaffold(
      // appBar: AppbarConstant().getAppbarConstant(),
      appBar: AppbarConstant().getBookmarkedAppbarConstant(
        targetUrl,
        rssInfo!,
        ref,
        context,
      ),
      // DisplayEntry合体
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Tile型Containerでタイトル部分を表示（統一デザイン）
                containerTileContainer(
                  context,
                  Container(
                    // 画面比率で計算 sizeConfig
                    // 64は上のicon,sizedbox,paddingの合計値
                    width: sizeConfig.screenWidth! -
                        (64 * sizeConfig.screenWidthTimes!),
                    padding: const EdgeInsets.only(
                        left: 0, top: 4, bottom: 4, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 記事のタイトル
                        Text(
                          postStructure.entoryTitle,
                          style: TextStyle(
                            fontSize: fontSize.subTitle1,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w700,
                            color: const Color(4294967295),
                            // 行間を少し狭く
                            height: 1.2,
                          ),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // ブックマークのマークと投稿日付
                        // サイズはfontSize.captionに統一
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            bookmarkMap.containsKey(targetUrl)
                                ? Icon(Icons.bookmark,
                                    size: fontSize.caption,
                                    color:
                                        Theme.of(context).colorScheme.primary)
                                : SizedBox(
                                    width: fontSize.caption,
                                  ),
                            SizedBox(
                              width: fontSize.caption,
                            ),
                            // 日付から末尾の秒を取る(2025.6.26)
                            Text(
                              "${DateFormat(dateFormJpDisp, dateFormLocale).format(postStructure.dateHeader)} 投稿記事",
                              style: TextStyle(
                                fontSize: fontSize.caption,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                color: const Color(4294967295),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  postStructure.entoryTitle, // String titleString
                  // marginは丸文字を目立たせるために少し右より表示
                  const EdgeInsets.only(
                    right: 4,
                    left: 24,
                    top: 8,
                  ),
                  double.infinity, // double width
                ),
                // ２段めとのスペース
                const SizedBox(
                  height: 8,
                ),
                // ２段め（本文）
                Container(
                  // height: の指定をしないでTextの大きさのままとする
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    _listToString(postStructure.contentAbstract),
                    style: TextStyle(
                      fontSize: fontSize.body1,
                      color:
                          Theme.of(context).colorScheme.onSurface, // onSurface
                      decoration: TextDecoration.none,
                      // w500とw600は値が隣り合わせだが、w600は本文には強いイメージ
                      fontWeight: FontWeight.w600,
                      // 行間を少し広げる
                      height: 1.6,
                    ),
                  ),
                ),
                // 3段めとのスペース
                const SizedBox(
                  height: 16,
                ),
                // 詳細説明
                Container(
                  // コラムの大事な部分を囲ったり色を入れたりしてみる
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 2.0),
                  ),
                  // height: の指定をしないでTextの大きさのままとする
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    _listToString(postStructure.contentDetails),
                    style: TextStyle(
                      fontSize: fontSize.body1,
                      color:
                          Theme.of(context).colorScheme.onSurface, // onSurface
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      // 行間を少しだけ広げる
                      height: 1.5,
                    ),
                  ),
                ),
                // 4段めとのスペース
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 24 * (sizeConfig.screenWidthTimes!),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "ニュースソース",
                        style: TextStyle(
                          fontSize: fontSize.subTitle2,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                // 4段め  リンク集
                Column(
                  children: linkList,
                ),
                // 4段め  リンク集の下にスペースがないとタップ出来ない
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ニュースソースのリンクリストを作成する
  //
  void _buildLinkList(BuildContext context) {
    for (int itemCount = 0;
        itemCount < postStructure.contentLinks.length;
        itemCount++) {
      linkList.add(
        // ボタンを押すとリンク先のWEBページを表示する
        GestureDetector(
          onTap: () {
            // 区切りコンテナは線にする（いちいち説明しない）
            WidgetProvider().removeWidget();
            launchURL(
                context, postStructure.contentLinks[itemCount].toString());
          },
          child: Container(
            // リンク領域の背景色（secondaryContainer）
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surface, // secondaryContainer
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 8,
                ),
                // アイコン表示部分
                Container(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.web,
                    size: 16.0 * (sizeConfig.screenWidthTimes!),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  // height: 32,
                  // 画面比率で設定 sizeConfig
                  // 36は上のicon,sizedbox,paddingの合計値
                  width: sizeConfig.screenWidth! -
                      (36 * sizeConfig.screenWidthTimes!),
                  child: Text(
                    postStructure.contentHref[itemCount].toString(),
                    style: TextStyle(
                      fontSize: fontSize.body2,
                      color: Theme.of(context).colorScheme.onSurface,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

// List<String>をtoString()で出すと'[]'が付いて面倒なのでちゃんと連結する
  String _listToString(List<String> list) {
    return list.map<String>((String value) => value.toString()).join('\n');
  }
}
