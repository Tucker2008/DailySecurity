import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/content/cocolog_content.dart';
// import 'package:daily_security_dev/methods/associate_methods.dart';
import 'package:cyber_interigence/methods/splash_screen.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/column_container.dart';
import 'package:cyber_interigence/repository/cycle_container.dart';
import 'package:cyber_interigence/repository/mearge_news.dart';
import 'package:cyber_interigence/repository/news_container.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/repository/push_notification_service.dart';
import 'package:cyber_interigence/repository/rss_stream.dart';
import 'package:cyber_interigence/repository/slide_tile_container.dart';
import 'package:cyber_interigence/theme/date_form.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:cyber_interigence/util/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// メイン画面に表示する記事数
const entranceArticle = 4;

// //
// // アプリのメイン画面
// //
@immutable
class EntranceScreen extends ConsumerStatefulWidget {
  const EntranceScreen({super.key});
  @override
  EntranceScreenState createState() => EntranceScreenState();
}

// class EntranceScreenState extends ConsumerState<EntranceScreen>
//     with AfterLayoutMixin<EntranceScreen> {
class EntranceScreenState extends ConsumerState<EntranceScreen> {
  // Build6でConsumerStatefulWidget化にした
  // class EntranceScreen extends ConsumerWidget {
  //   EntranceScreen({super.key});

  @override
  void initState() {
    super.initState();
    // Buildが完了したら移動先ページ処理をする登録をしておく
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  // Build完了を捉えて、移動先ページがあれば移動する
  // @override
  void afterFirstLayout(BuildContext context) {
    // 通知のPayloadが指定されていれば移動
    if (MessageProvider().getMsg().isNotEmpty) {
      setState(() {});
      // RssInfomationを作成（URLしか有効ではない）
      RssInformation rss = RssInformation(
        date: DateFormat(dateFormJp,dateFormLocale).format(DateTime.now()),
        title: "",
        text: "",
        link: MessageProvider().getMsg(),
      );
      // ここで移動先URLを削除しておく
      MessageProvider().removeMsg();
      // 指定されたページへ移動する
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CocologContent(
            cocologRss: rss,
          ),
        ),
      );
    }
  }

  // Providerの定義（RSS読み込み関数をまるごとProvider定義）
  final cocologProvider = FutureProvider.autoDispose
      .family<List<RssInformation>, String>((ref, url) async {
    return allRssStreaming(cocologRss);
  });

  //
  // Buid
  //
  @override
  Widget build(BuildContext context) {
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
        // トップニュースをCocologのnewsカテゴリからJpcertへ変更(2025.6.18)
        // newsList = filteringList(informationList, "news", entranceArticle)!;
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
      // トップニュースをCocologのnewsカテゴリからJpcertへ変更(2025.6.18)
      newsList = meargeTopNews(0)!;
      // インシデントニュースをCocologのColumnカテゴリに加える(2025.6.19)
      columnList = meargeIncidentNews(entranceArticle, columnList)!;
    }

    //ここまでRSS取得関連-----------

    // Notificationをタップしたら起動する様に設定する
    // Build6 (2025.2.16)
    PushNotificationService().setLocalNotificationTap(context);

    //画面描画-----------
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
