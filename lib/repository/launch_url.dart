import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/repository/pdf_page.dart';
import 'package:cyber_interigence/util/url_provider.dart';
import 'package:flutter/material.dart';
import 'package:cyber_interigence/content/cocolog_content.dart';
import 'package:cyber_interigence/repository/web_page.dart';

//
// 別ページで当該記事を表示する
// Cocologサイト以外はブラウザ表示（統合のため）
// Cocologサイトは独自解析エンジン付き表示を呼ぶ
//
void launchURL(BuildContext context, String url) {
  final urlProvider = UrlProvider();

  // タイトル行をクリックしても反応しない様にここでガード
  if (url.isNotEmpty) {
    if (Uri.parse(url).host == cocologHost) {
      urlProvider.setUrl(url);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CocologContent(),
        ),
      );
    }
    // Cocologコンテンツでなければそのまま表示する
    // PDFの場合は別のviewerを起動する
    // 特にAndroidの場合はPDFを表示出来ない
    else {
      // URLをセットして
      urlProvider.setUrl(url);
      // debugPrint("!!! _launchURL ${url.endsWith('.pdf')}  $url");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              url.endsWith('.pdf') ? const PdfPage() : const WebPage(),
        ),
      );
    }
  }
}
