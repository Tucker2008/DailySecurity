import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/content/cocolog_content.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/pdf_page.dart';
// import 'package:daily_security_dev/util/url_provider.dart';
import 'package:flutter/material.dart';
// import 'package:daily_security_dev/content/cocolog_content.dart';
import 'package:cyber_interigence/repository/web_page.dart';
import 'package:intl/intl.dart';

//
// 別ページで当該記事を表示する
// Cocologサイト以外はブラウザ表示（統合のため）
// Cocologサイトは独自解析エンジン付き表示を呼ぶ
//
void launchURL(BuildContext context, String url) {
  // ダミーのRSSを作成しておいてWebページ表示する
  RssInformation rss = RssInformation(
      date: DateFormat('yyyy/MM/dd(E)').format(DateTime.now()), title: "", text: "",);
  // タイトル行をクリックしても反応しない様にここでガード
  if (url.isNotEmpty) {
    rss = rss.copyWith(link: url);
  
    // PDFの場合は別のviewerを起動する
    // 特にAndroidの場合はPDFを表示出来ない

      // ページを呼ぶ
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => url.endsWith('.pdf')
              ? PdfPage(rss: rss,)
              : WebPage(
                  rss: rss,
                ),
        ),
      );
  }
}

//
// 別ページで当該記事を表示する
// Cocologサイト以外はブラウザ表示（統合のため）
// Cocologサイトは独自解析エンジン付き表示を呼ぶ
// 2025.2.13 Build6 ブックマーク対応のためRSSを引数とする
//
void launchUrlByRss(BuildContext context, RssInformation rss) {
  // final urlProvider = UrlProvider();
  String url;

  // タイトル行をクリックしても反応しない様にここでガード
  if (rss.link!.isNotEmpty) {
    // チェックするURLをRSSから取得
    url = rss.link!;
    // ココログだったらCocologContent()を呼ぶ
    if (Uri.parse(url).host == cocologHost) {
      // urlProvider.setUrl(url);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CocologContent(
            cocologRss: rss,
          ),
        ),
      );
    }
    // Cocologコンテンツでなければそのまま表示する
    // PDFの場合は別のviewerを起動する
    // 特にAndroidの場合はPDFを表示出来ない
    else {
      // URLをセットして
      // urlProvider.setUrl(url);
      // ページを呼ぶ
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => url.endsWith('.pdf')
              ? PdfPage(rss: rss,)
              : WebPage(
                  rss: rss,
                ),
        ),
      );
    }
  }
}
