import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/methods/splash_screen.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/column_container.dart';
import 'package:cyber_interigence/repository/cycle_container.dart';
import 'package:cyber_interigence/repository/news_container.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/repository/rss_stream.dart';
import 'package:cyber_interigence/repository/slide_tile_container.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// メイン画面に表示する記事数
const entranceArticle = 4;

// 
// アプリのメイン画面
// 
class EntranceScreen extends ConsumerWidget {
  EntranceScreen({super.key});

  // Providerの定義（RSS読み込み関数をまるごとProvider定義）
  final cocologProvider = FutureProvider.autoDispose
      .family<List<RssInformation>, String>((ref, url) async {
    return allRssStreaming(cocologRss);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // エラーメッセージ伝達用
    final noteProvider = NoteProvider();

    // RSSの取得関連------------------------

    // RSSで取得したデータを格納する(rss_infomation.dart)
    // データ元はCacheManager
    List<RssInformation> informationList = [];
    List<RssInformation> newsList = [];
    List<RssInformation> columnList = [];
    List<RssInformation> publicNewsList = [];

    // Feedを読む(fetch_feed.dart)
    // Feedを読む機能をfeedProvider登録し、その返り値を取得する
    final AsyncValue<List<RssInformation>> activity =
        ref.watch(cocologProvider(cocologRss));
    activity.when(
      data: (data) {
        informationList = data;
        newsList = filteringList(informationList, "news", entranceArticle)!;
        columnList = filteringList(informationList, "column", entranceArticle)!;
      },
      error: (error, stacktrace) => noteProvider.setNote(error.toString()),
      loading: () => splashScreenNoContext(),
    );

    // これが表示されたという事は最初のログインとする
    PreferenceManager().updateLastLogin();
    // IPA等のニュースマージが間に合わない場合にはぐるぐるを出す
    if (meargeNews(entranceArticle) == null) {
      return splashScreen(context);
    } else {
      publicNewsList = meargeNews(4)!;
    }

    //ここまでRSS取得関連-----------

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // アップデート情報
            slideTileContainer(context, newsList),
            // セキュリティリマインダー
            // cycleContainer(context),
            cycleContainerEardog(context),
            // ちょっとスペース
            const SizedBox(
              height: 16,
            ),
            // インシデントに学ぶ
            columnContainer(context, columnList),
            // 他セキュリティ関連ニュース
            newsContainer(context, publicNewsList),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
