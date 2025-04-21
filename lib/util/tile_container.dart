import 'dart:math';

import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/pages/main_screen.dart';
import 'package:cyber_interigence/repository/launch_url.dart';
import 'package:cyber_interigence/util/screen_provider.dart';
import 'package:flutter/material.dart';

//
// タイル型のContainerを創出する
// Thanks to https://qiita.com/jimborie/items/777c3990c91438c7cbbc
//

// 様々な色で出したいので、カラーテーブルを独自作成 primery/onprimeryを用意
const List<Color> _primaryColorTable = [
  Color(4283196971),
  Color(4287581240),
  Color(4283523183),
  Color(4281886307),
  Color(4286011214),
  // Color(4283982409),
];

const List<Color> _onPrimaryColorTable = [
  Color(4294967295),
  Color(4294958033),
  Color(4294967295),
  Color(4292142326),
  Color(4294958033),
  // Color(4294967295),
];

//
// 横並びタイル型コンテナ
// タップしたらリンク先ページを表示
//
Widget tileContainer(BuildContext context, RssInformation rssInfo) {
  const margin = EdgeInsets.only(
    right: 8,
  );
  return simpleTileContainer(
      context, rssInfo, margin, sizeConfig.tileContainerWidth!);
}

//
// パラーメータ指定可能な汎用タイル型コンテナ
// タップしたらリンク先ページを表示
//
Widget simpleTileContainer(BuildContext context, RssInformation rssInfo,
    EdgeInsets margin, double width) {
  // 色はランダムで設定
  final colorChoiceRect = Random(DateTime.now().microsecond).nextInt(10) %
      _primaryColorTable.length;
  final colorChoiceCircle = Random(DateTime.now().microsecond).nextInt(10) %
      _onPrimaryColorTable.length;
  final titleString = rssInfo.title;

  return GestureDetector(
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // テキスト表示領域
        Container(
          width: width,
          height: fontSize.body1 * 4,
          decoration: BoxDecoration(
            color: _primaryColorTable[colorChoiceRect],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(
            left: sizeConfig.tileCircleWidth! * 0.8,
            right: 4,
            top: 4 * sizeConfig.screenWidthTimes!,
          ),
          margin: const EdgeInsets.only(
            right: 16,
          ),
          child: Text(
            titleString,
            style: TextStyle(
              fontSize: fontSize.body1,
              color: _onPrimaryColorTable[colorChoiceRect],
              // 行間を少し狭く
              height: 1.2,
            ),
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // 少しずらして円を描いて、フォントアイコンを入れる
        Positioned(
          top: -1 * sizeConfig.tileCircleWidth! * 0.3,
          left: -1 * sizeConfig.tileCircleWidth! * 0.3,
          child: Container(
            width: sizeConfig.tileCircleWidth,
            height: sizeConfig.tileCircleWidth,
            decoration: BoxDecoration(
              color: _primaryColorTable[colorChoiceCircle],
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: (sizeConfig.tileCircleWidth! / 2),
              child: Text(
                _getDirstCharacter(titleString),
                style: TextStyle(
                  fontSize: 24.0 * sizeConfig.screenWidthTimes!,
                  color: _onPrimaryColorTable[colorChoiceCircle],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    onTap: () {
      launchUrlByRss(context, rssInfo);
    },
  );
}

//
// パラーメータ指定可能な汎用タイル型コンテナ
// 引数にWidgetを指定する
//
Widget containerTileContainer(BuildContext context, Widget content,
    String titleString, EdgeInsets margin, double width) {
  // 色はランダムで設定
  final colorChoiceRect = Random(DateTime.now().microsecond).nextInt(10) %
      _primaryColorTable.length;
  final colorChoiceCircle = Random(DateTime.now().microsecond).nextInt(10) %
      _onPrimaryColorTable.length;
  return SizedBox(
    width: width,
    height: sizeConfig.tileContainerHeight, // 72 + 32,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // テキスト表示領域
        Container(
          width: width,
          height: fontSize.body1 * 7.5,
          decoration: BoxDecoration(
            color: _primaryColorTable[colorChoiceRect],
            borderRadius: BorderRadius.circular(10),
          ),
          // marginでcontainerを右よりにしているのでテキストは左によせる
          padding: EdgeInsets.only(
            left: sizeConfig.tileCircleWidth! * 0.6,
            right: 8,
            top: 4 * sizeConfig.screenWidthTimes!,
          ),
          margin: margin,
          child: content,
        ),
        // 少しずらして円を描いて、フォントアイコンを入れる
        Positioned(
          top: -1 * sizeConfig.tileCircleWidth! * 0.1,
          left: -1 * sizeConfig.tileCircleWidth! * 0.1,
          child: Container(
            width: sizeConfig.tileCircleWidth,
            height: sizeConfig.tileCircleWidth,
            decoration: BoxDecoration(
              color: _primaryColorTable[colorChoiceCircle],
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: (sizeConfig.tileCircleWidth! / 2),
              child: Text(
                _getDirstCharacter(titleString),
                style: TextStyle(
                  fontSize: 24.0 * sizeConfig.screenWidthTimes!,
                  color: _onPrimaryColorTable[colorChoiceCircle],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

//
// ちょっと大きめのコンテナ
// タップしたら機能ページを呼ぶ

Widget largeTileContainer(
  double containerHeight,
  double containerWidth,
  IconData? iconImage,
  BuildContext context,
  RssInformation? rssInfo,
  String? title,
  int? screenNumber,
  ImageProvider<Object>? avatarImage,
) {
  // 色はランダムで設定
  final colorChoiceRect = Random(DateTime.now().microsecond).nextInt(10) %
      _primaryColorTable.length;
  final colorChoiceCircle = Random(DateTime.now().microsecond).nextInt(10) %
      _onPrimaryColorTable.length;
  final titleString = rssInfo != null ? rssInfo.title : title!;
  // タイル表示作成
  return GestureDetector(
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // テキスト表示領域
        Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: _primaryColorTable[colorChoiceRect],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(
            left: sizeConfig.tileCircleWidth! * 0.8,
            right: 4,
            top: 8 * sizeConfig.screenWidthTimes!,
            bottom: 4,
          ),
          child: Text(
            titleString,
            style: TextStyle(
              fontSize: fontSize.body1,
              color: _onPrimaryColorTable[colorChoiceRect],
              // 行間を少し狭く
              height: 1.2,
            ),
            // softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // 少しずらして円を描いて、フォントアイコンを入れる
        Positioned(
          top: -1 * sizeConfig.tileCircleWidth! * 0.3,
          left: -1 * sizeConfig.tileCircleWidth! * 0.3,
          child: Container(
            width: sizeConfig.tileCircleWidth,
            height: sizeConfig.tileCircleWidth,
            decoration: BoxDecoration(
              color: _primaryColorTable[colorChoiceCircle],
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: (sizeConfig.tileCircleWidth! / 2),
              child: iconImage != null
                  ? Icon(
                      iconImage,
                      size: 24.0 * (sizeConfig.screenWidthTimes!),
                    )
                  : CircleAvatar(
                      backgroundImage: avatarImage,
                      radius:
                          24.0 * (sizeConfig.screenWidthTimes!), //ここは半径を指定する
                    ),
            ),
          ),
        ),
      ],
    ),
    onTap: () {
      if (screenNumber != null) {
        // スクリーン番号をセットして
        ScreenProvider().setScreen(screenNumber);
        // ページを呼ぶ
        // このページの呼び方ではスタックしないので行ったきりに出来る
        // Thanks to StackOverflow
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      } else if (rssInfo != null) {
        launchUrlByRss(context, rssInfo);
      }
    },
  );
}

//
// 左上のテキストアイコン用の文字に記号が入ってしまうのを避ける
// 2025.2.2 from FirstFlight
String _getDirstCharacter(String origin) {
  final firstStr = origin.substring(0, 1);
  // 最初がタイトルに出てきそうな記号だったら、それを除く
  if ((firstStr == "「") ||
      (firstStr == "”") ||
      (firstStr == '"') ||
      (firstStr == '（')) {
    return origin.substring(1, 2);
  } else {
    return firstStr;
  }
}
