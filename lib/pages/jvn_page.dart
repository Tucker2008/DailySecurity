import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/util/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/repository/feed_page.dart';

class JvnPage extends FeedPage {
  JvnPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    super.setFeedUrl(jvnRss);
    super.setServiceContainer(feedFirstContainerJVN);
    // WEBページ表示時の簡単な説明
    super.setWebContainer(feedFirstWebContainerJVN);
    return super.build(context, ref);
  }

  //
  // JVNの説明
  //
  final Widget feedFirstContainerJVN = Container(
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
          "$jvnName は、$jvnDetail",
          style: TextStyle(
            // color: Theme.of(context).colorScheme.primary,
            fontSize: fontSize.subTitle2,
          ),
        ),
      ],
    ),
  );

  //
  // IPAの説明
  //
  final Widget feedFirstWebContainerJVN = Container(
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
          jvntWebTitle,
          style: TextStyle(
            fontSize: fontSize.oberline,
          ),
        ),
      ],
    ),
  );
}
