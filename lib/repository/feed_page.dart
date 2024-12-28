import 'package:cyber_interigence/entry/display_feed.dart';
import 'package:cyber_interigence/util/widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/repository/rss_stream.dart';

//
// RSSを読み込む（表示はDisplayFeedTest）
//
abstract class FeedPage extends ConsumerWidget {
  FeedPage({super.key});

// WebPage表示時のContainer指定
  void setWebContainer(Widget widget) {
    WidgetProvider().setWidget(widget);
  }

  // 特殊なURL変換が必要な場合の上書き関数
  static String feedUrl = "";
  void setFeedUrl(String url) {
    feedUrl = url;
  }

  // extendsした実装クラスがチャネル説明のContainerを設定する
  static Widget feedFirstContainer = Container();
  void setServiceContainer(Widget firstContainer) {
    feedFirstContainer = firstContainer;
  }

  // FeedのURLから特定サイトのURL変換が必要な場合の置き換え用関数
  // JPCERTのみRSSのURLがPC用で（スマホ用ではない）
  String customUrl(String original) {
    return original;
  }

  // Providerの定義（RSS読み込み関数をまるごとProvider定義）
  final feedProvider = FutureProvider.autoDispose
      .family<List<RssInformation>, String>((ref, url) async {
    return rssStreaming(url);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // RSSで取得したデータを格納する(rss_infomation.dart)
    List<RssInformation> informationList = [];
    // エラーメッセージ伝達用
    final noteProvider = NoteProvider();

    // Feedを読む(fetch_feed.dart)
    // Feedを読む機能をfeedProvider登録し、その返り値を取得する
    final AsyncValue<List<RssInformation>> activity =
        ref.watch(feedProvider(feedUrl));
    activity.when(
        data: (data) {
          // 特定の条件下で複数回呼ばれた時に_urlExchanger()でパスが異常になるのでここで変換
          informationList = _urlExchanger(data);
        },
        error: (error, stacktrace) => noteProvider.setNote(error.toString()),
        loading: CircularProgressIndicator.new);

    // Feed表示
    return Scaffold(
      body: DisplayFeed(
              informationListArg: informationList,
              firstContainer: feedFirstContainer)
          .displayFeed(context),
    );
  }

  // JPCERTのみRSSのURLがPC用で（スマホ用ではないので）URLをまとめて変換する
  List<RssInformation> _urlExchanger(List<RssInformation> infoList) {
    for (var item in infoList) {
      if (item.link!.isNotEmpty) {
        String exchangeUrl = customUrl(item.link!);
        item.link = exchangeUrl;
      }
    }
    return infoList;
  }
}
