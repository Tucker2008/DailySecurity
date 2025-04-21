//
// エントランスのコラム一覧Containerを生成する
//
import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/pages/main_screen.dart';
import 'package:cyber_interigence/util/screen_provider.dart';
import 'package:cyber_interigence/util/tile_container.dart';
import 'package:flutter/material.dart';

Widget columnContainer(BuildContext context, List<RssInformation> columnList) {
  // インシデントから学ぶ＆セキュリティニュース
  // 各ボックス共通の定義
  const BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
        bottomLeft: Radius.circular(15.0)), //角を丸める
  );

  // 表示コンテナの仕込み
  List<Widget> tiles = [];
  const tileMargin = EdgeInsets.only(left: 16, top: 16, right: 8, bottom: 16);
  for (var item in columnList) {
    tiles.add(const SizedBox(
      height: 16,
    ));
    tiles.add(simpleTileContainer(context, item, tileMargin, double.infinity));
  }

  // 表示コンテナ本体
  return SizedBox(
    height: sizeConfig.columnContainerHeight,
    width: double.infinity,
    child: Container(
      height: double.infinity, //ここはデカくしても最大が決まっている
      padding: const EdgeInsets.only(
        left: 16.0,
      ),
      margin: const EdgeInsets.only(left: 8, right: 4, top: 4, bottom: 4),

      decoration: boxDecoration.copyWith(
        color: Theme.of(context).colorScheme.surfaceDim,
        // ※背景にテクスチャを貼ると表示が遅いので不必要なら表示しない方がいい
        // image: const DecorationImage(
        //   image: AssetImage('images/paper-texture.jpg'),
        //   fit: BoxFit.fill,
        //   opacity: 0.7, //透明度は常に検討
        // ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entranceTitleArticle,
                      style: TextStyle(
                        fontSize: fontSize.headlineH6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      cocologTitle3,
                      style: TextStyle(
                        fontSize: fontSize.body2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // スクリーン番号をセットして
                  ScreenProvider().setScreen(cocologPageNum);
                  // ページを呼ぶ
                  // このページの呼び方ではスタックしないので行ったきりに出来る
                  // Thanks to StackOverflow
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
              const Spacer(),
              // 2025.4.17 ブックマークへ誘導 からColumnページへ変更
              GestureDetector(
                child: Icon(
                  Icons.article_outlined,
                  size: sizeConfig.tileIconSize,
                ),
                onTap: () {
                  // スクリーン番号をセットして
                  ScreenProvider().setScreen(cocologPageNum);
                  // ページを呼ぶ
                  // このページの呼び方ではスタックしないので行ったきりに出来る
                  // Thanks to StackOverflow
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
              ),

              const SizedBox(
                width: 16,
              )
            ],
          ),

          // columnカテゴリを表示する ----------------
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tiles,
          ),
          // columnカテゴリを表示する (end)----------------
        ],
      ),
    ),
  );
}
