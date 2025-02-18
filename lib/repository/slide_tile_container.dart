import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/util/tile_container.dart';
import 'package:flutter/material.dart';

//
// タイル型のContainerの横スライドを作成
//
Widget slideTileContainer(BuildContext context, List<RssInformation> info) {

  // 表示するタイル（コンテンツ）を準備
  List<Widget> tiles = [];
  for (var item in info) {
    tiles.add(tileContainer(context, item ));
  }

  // タイルを横並びにする（外枠込の）コンテナ
  return SizedBox(
    height: sizeConfig.updateInfoHeight!,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(left: 8, right: 0, top: 0, bottom: 8),
      width: double.infinity,

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceDim,
      // ※背景にテクスチャを貼ると表示が遅いので不必要なら表示しない方がいい
      //   image: const DecorationImage(
      //     image: AssetImage('images/paper-texture.jpg'),
      //     fit: BoxFit.fill,
      //     opacity: 0.7, //透明度は常に検討
      //   ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // タイルタイトル
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                entranceTitleUpdate,
                style: TextStyle(
                  fontSize: fontSize.headlineH6,
                  fontWeight: FontWeight.w700,
                  // color:
                  //     Theme.of(context).colorScheme.onTertiaryFixed,
                ),
              ),
              // 件数を表示する
              Text(
                '  (${info.length}件)',
                style: TextStyle(
                  fontSize: fontSize.subTitle1,
                  fontWeight: FontWeight.w500,
                  // color:
                  //     Theme.of(context).colorScheme.onTertiaryFixed,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          // newsカテゴリを表示する ----------------
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // スクロールの向きを水平方向に指定
            clipBehavior: Clip.none,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: tiles,
            ),
          ),
          // newsカテゴリを表示する (end)----------------
        ],
      ),
    ),
  );
}

