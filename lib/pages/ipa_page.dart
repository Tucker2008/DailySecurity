import 'package:cyber_interigence/util/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/repository/feed_page.dart';
import 'package:cyber_interigence/global.dart';

//
//  IPAのページ
//
class IpaPage extends FeedPage {
  IpaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // URLを指定
    super.setFeedUrl(ipaRss);
    // フィード一覧の説明コンテナ指定
    super.setServiceContainer(feedFirstContainerIPA);
    // WEBページ表示時の簡単な説明
    super.setWebContainer(feedFirstWebContainerIPA);
    return super.build(context, ref);
  }

  //
  // IPAの説明
  //
  final Widget feedFirstContainerIPA = Container(
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
          "$ipaName は、$ipaDetail",
          style: TextStyle(
            fontSize: fontSize.subTitle2,
          ),
        ),
      ],
    ),
  );

  //
  // IPAの説明
  //
  final Widget feedFirstWebContainerIPA = Container(
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
          ipaWebTitle,
          style: TextStyle(
            fontSize: fontSize.oberline,
          ),
        ),
      ],
    ),
  );
}
