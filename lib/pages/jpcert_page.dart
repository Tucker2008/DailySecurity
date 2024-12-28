import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/util/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/repository/feed_page.dart';

class JpcertPage extends FeedPage {
  JpcertPage({super.key});

  // JPCERTのみRSSのURLがPC用で（スマホ用ではない）ので変換する
  @override
  String customUrl(String original) {
    String origin = Uri.parse(original).origin;
    String inner = Uri.parse(original).path;
    // debugPrint("customUrl $original");
    return Uri.parse("$origin/m$inner").toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    super.setFeedUrl(jpcertRss);
    super.setServiceContainer(feedFirstContainerJPCERT);
    // WEBページ表示時の簡単な説明
    super.setWebContainer(feedFirstWebContainerJPCERT);
    return super.build(context, ref);
  }

  //
  // JPCERT/CCの説明
  //
  final Widget feedFirstContainerJPCERT = Container(
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
          "$jpcertName は、$jpcertDetail",
          style: TextStyle(
            // color: Theme.of(context).colorScheme.primary,
            fontSize: fontSize.subTitle2,
          ),
        ),
      ],
    ),
  );

  //
  // JPCERTの説明
  //
  final Widget feedFirstWebContainerJPCERT = Container(
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
          jpcertWebTitle,
          style: TextStyle(
            fontSize: fontSize.oberline,
          ),
        ),
      ],
    ),
  );
}
