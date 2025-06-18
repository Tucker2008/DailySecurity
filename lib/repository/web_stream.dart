//
// Web記事を読み込みEntryStructureへ格納する
// Providerの定義（関数系をまるごとProvider定義）
//
// import 'package:flutter/material.dart';
import 'package:cyber_interigence/global.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:cyber_interigence/repository/cache_manager.dart';
import 'package:cyber_interigence/model/post_structure.dart';

final webEntoryProvider = FutureProvider.autoDispose.family((ref, url) async {
  // URL引き渡し用
  // 引数のURLが読み込み先
  final String targetUrl = url as String;
  // 取得したHTMLから取り出したデータを格納する
  final PostStructure postStructure;

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
    blogDate = DateFormat("yyyy年MM月dd日", 'ja_JP')
        .parse(document.getElementsByClassName("date")[0].innerHtml);
    // カテゴリ指定があればそれをカテゴリとする
    if (document.getElementsByClassName("category-ttl").isNotEmpty) {
      categoryString =
          document.getElementsByClassName("category-ttl")[0].innerHtml;
    }
    titleString = document
        .getElementsByClassName("ttl --lv1 news-detail__ttl")[0]
        .innerHtml;

    // 記事概要を取得
    for (var item in document.getElementsByClassName("article-txt")) {
      // 「article-txt article-txt--right」こういうのがある
      // 「&nbsp;文字列」というパターンも無視
      // サブクラス指定は入れない
      if (item.className == "article-txt") {
        // 行の頭の空白を取り、特定のパターンを除去する
        String checkBuffer = item.innerHtml.trim();
        if ((checkBuffer.isNotEmpty) &&
            (!checkBuffer.startsWith('&')) &&
            (!checkBuffer.startsWith('注釈'))) {
          contentAbstractTmp.add(item.innerHtml);
        }
      }
    }

    // 記事本体を取得
    for (var item in document.getElementsByClassName("list --disc")) {
      contentDetailsTmp.add(item.innerHtml);
    }

    // リンク説明を取得
    contentLinkHrefTmp.add(titleString);
    // 記事リンクは読み込み先とする
    contentLinksTmp.add(Uri.parse(targetUrl));

    // カテゴリ文字列の内部変換はこのへんでやる
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
  if (debugEntryDetails) {
    //   debugPrint("webEntoryProvider:category: ${postStructure.category}");
    //   debugPrint("webEntoryProvider:title: ${postStructure.entoryTitle}");
    //   debugPrint("webEntoryProvider:date: ${postStructure.dateHeader}");
    // for (var item in postStructure.contentAbstract) {
    //   debugPrint("webEntoryProvider:Abstract: $item");
    // }
    //   for (var item in postStructure.contentDetails) {
    //     debugPrint("webEntoryProvider:Detais: $item");
    //   }
    //   for (var item in postStructure.contentHref) {
    //     debugPrint("webEntoryProvider:Href: $item");
    //   }
    //   for (var item in postStructure.contentLinks) {
    //     debugPrint("webEntoryProvider:link: $item");
    //   }
  }
  // Cacheに格納する
  cacheManeger.addPageCache(targetUrl, postStructure);
  // 処理終了
  return Future<PostStructure>.value(postStructure);
});
