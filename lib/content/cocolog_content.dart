import 'dart:convert';
import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/entry/display_entry.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';
import 'package:cyber_interigence/methods/splash_screen.dart';
import 'package:cyber_interigence/model/post_structure.dart';
import 'package:cyber_interigence/util/url_provider.dart';
import 'package:cyber_interigence/repository/cache_manager.dart';

// 取得したHTMLから取り出したデータを格納する
PostStructure? postStructure;
// 何故か引数のURLが渡らないので受け渡し用
String targetUrl = "";

class CocologContent extends ConsumerStatefulWidget {
  const CocologContent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CocologContentState();
}

class _CocologContentState extends ConsumerState<CocologContent>
    with TickerProviderStateMixin {
  // URL引き渡し用
  final urlProvider = UrlProvider();

  // Build
  @override
  Widget build(BuildContext context) {
    // URLとRSS引き渡し（ここで取得しないと正常に取得出来ない）
    targetUrl = urlProvider.getUrl();
    // entryを読む(fetch_feed.dart)
    // entryを読む機能をentryProvider登録し、その返り値を取得する
    AsyncValue activity = ref.watch(entryProvider(targetUrl));
    activity.when(
      data: (data) {
        postStructure = data;
      },
      error: (error, stacktrace) => splashScreenException(error.toString()),
      loading: () {
        const CircularProgressIndicator();
      },
    );
    // 本来はBuild()がコールされるのでここでトラップする
    if (postStructure == null) {
      return splashScreen(context);
    }

    return Scaffold(
      appBar: AppbarConstant().getAppbarConstant(),
      body: DisplayEntry(postStructure: postStructure).displayEntry(context),
    );
  }

  // Providerの定義（関数系をまるごとProvider定義）
  final entryProvider = FutureProvider.autoDispose.family((ref, url) async {
    // キャッシュマネージャ
    final cacheManeger = CacheManager();
    // Cacheに保持されていたらcacheから返して終了
    if (cacheManeger.pageCacheIsNotEmpty(targetUrl)) {
      return Future<PostStructure>.value(cacheManeger.getPageCache(targetUrl));
    }
    // HTMLを読み込む。
    final response = await http.get(Uri.parse(targetUrl));
    //   正常に取れたか？
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch HTML');
    }

    //   取得したHTMLをParseにかけて分解
    var document = parse(utf8.decode(response.bodyBytes));

    // ブログの中身から要素を取り出す
    // 取り出し自体が記述ミスなどで例外が出るのに備える必要がある
    DateTime blogDate = DateTime.now();
    String categoryString = "";
    String titleString = "";
    List<String> contentAbstractTmp = [];
    List<String> contentDetailsTmp = []; // 詳細説明（content_details）
    List<String> contentLinkHrefTmp = []; // 詳細説明（content_details）
    List<Uri> contentLinksTmp = []; // 参照リンク（content_links）
    try {
      blogDate = DateFormat("y/M/d")
          .parse(document.getElementsByClassName("date-header")[0].innerHtml);
      // カテゴリ指定があればそれをカテゴリとする
      if (document.getElementsByClassName("content_category").isNotEmpty) {
        categoryString =
            document.getElementsByClassName("content_category")[0].innerHtml;
      }
      titleString =
          document.getElementsByClassName("entry-header")[0].innerHtml;

      // 記事概要を取得
      for (var item in document.getElementsByClassName("content_abstract")) {
        contentAbstractTmp.add(item.innerHtml);
      }

      // 記事本体を取得
      for (var item in document.getElementsByClassName("content_details")) {
        contentDetailsTmp.add(item.innerHtml);
      }

      // リンク説明を取得
      for (var item in document.getElementsByClassName("content_href")) {
        contentLinkHrefTmp.add(item.innerHtml);
      }

      // 記事リンクを取得
      for (var item in document.getElementsByClassName("content_links")) {
        contentLinksTmp.add(Uri.parse(item.innerHtml));
      }

      // カテゴリを取得
      if (categoryString.isEmpty) {
        var item = document.getElementsByClassName("post-footers");
        // 本来は配列で取得するものだが、複数個はないと決め打ちして[0]指定
        categoryString = item[0].innerHtml.split('>')[1].split('<')[0];
      }
    } catch (e) {
      // 変換に失敗した場合の処理

      throw Exception(e);
    }

    //   主たるデータ分解格納(主な要素)
    postStructure = PostStructure(
      category: categoryString,
      entoryTitle: titleString,
      dateHeader: blogDate,
      contentAbstract: contentAbstractTmp,
      contentDetails: contentDetailsTmp,
      contentHref: contentLinkHrefTmp,
      contentLinks: contentLinksTmp,
    );

    //   デバッグ確認
    // if (debugEntryDetails) {
    //   debugPrint("category: ${postStructure!.category}");
    //   debugPrint("title: ${postStructure!.entoryTitle}");
    //   debugPrint("date: ${postStructure!.dateHeader}");
    //   for (var item in postStructure!.contentAbstract) {
    //     debugPrint("Abstract: $item");
    //   }
    //   for (var item in postStructure!.contentDetails) {
    //     debugPrint("Detais: $item");
    //   }
    //   for (var item in postStructure!.contentHref) {
    //     debugPrint("Href: $item");
    //   }
    //   for (var item in postStructure!.contentLinks) {
    //     debugPrint("link: $item");
    //   }
    // }
    // Cacheに格納する
    cacheManeger.addPageCache(targetUrl, postStructure!);
    // 処理終了
    return Future<PostStructure>.value(postStructure);
  });
}
