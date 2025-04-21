import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/repository/launch_url.dart';
import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:cyber_interigence/util/bookmark_provider.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
// アプリ内でWebページを表示する
//
class WebPageInappview extends ConsumerStatefulWidget {
  const WebPageInappview({super.key, required this.rss});

  final RssInformation rss;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      WebPageInappviewState();
}

class WebPageInappviewState extends ConsumerState<WebPageInappview> {
  // 引数のRSSinformation
  RssInformation? rss;
  // 行き先のURL(後で引数から引っ張ってくる)
  String url = "";
  // 翻訳用URL
  String sourceUrl = "";
  // Webページローディングのため１度だけ実施するフラグ
  bool _isFirst = true;
  bool _translate = true;
  // Webページローディング進捗
  double _progress = 0.0;
  // 翻訳ページの生成
  final googleTransUrl = "https://translate.google.com/translate";
  // 翻訳ページへの遷移のためのRSSinfomationを作成しておく
  RssInformation? translateRss;

  @override
  Widget build(BuildContext context) {
    // Buildが複数回呼ばれるのでここで防ぐ（きれいな実装になってない）
    if (_isFirst) {
      // 初回フラグを下ろす
      _isFirst = false;
      // 引数のRSSを取り出す
      rss = widget.rss;
      // 指定URLを取得
      url = widget.rss.link!;
      sourceUrl = "$googleTransUrl?sl=en&tl=ja&u=$url";
      // 翻訳ページへの遷移のためのRSSinfomationを作成しておく
      translateRss = rss!.copyWith(link: sourceUrl);
      // ガイドコンテナを作成
      // 翻訳ページ表示のために呼ばれいている場合は翻訳ボタンを出さない
      if (url.startsWith(googleTransUrl)) {
        _translate = false;
      }
      _setDividedContainer(
          "海外のセキュリティサイトを表示します。Google\n翻訳が、うまく動作しない場合があります", _translate);

      // BookMarkProviderにWatch定義
      // Map<String, RssInformation> bookmarkMap = ref.watch(bookmarkProvider);
      ref.watch(bookmarkProvider);
      bookmarkNotifier = ref.read(bookmarkProvider.notifier);
    }

    return Scaffold(
      appBar:
          AppbarConstant().getBookmarkedAppbarConstant(url, rss!, ref, context),
      // body WebPage
      body: SafeArea(
        child: Column(
          children: [
            _progress < 1.0
                ? LinearProgressIndicator(
                    value: _progress,
                    color: Theme.of(context).colorScheme.errorContainer,
                    minHeight: 10.0,
                  )
                : const SizedBox.shrink(),
            // 区切り線（説明）
            dividerContainer ??
                const SizedBox(
                  height: 20,
                ),
            // Webページ
            Expanded(
              child: InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(url)),
                  onProgressChanged: (_, int progress) {
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                  initialSettings: InAppWebViewSettings(
                    javaScriptEnabled: true,
                    mediaPlaybackRequiresUserGesture: false,
                    cacheEnabled: true,
                    allowsInlineMediaPlayback: false,
                    applicationNameForUserAgent: userAgent,
                    sharedCookiesEnabled: true,
                  ),
                  // コンソールメッセージ処理：意外と量が多いので見ない
                  onConsoleMessage: (controller, consoleMessage) {
                    // consoleMessage.messageLevel == ConsoleMessageLevel.ERROR
                    //     ? debugPrint(consoleMessage.message)
                    //     : {};
                  },
                  // 動かないけど、翻訳JavaScriptを突っ込む
                  onLoadStop: (controller, url) async {
                    controller.evaluateJavascript(source: translateScript);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  final userAgent =
      // "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Version/8.0.8 Safari/600.8.9";
      "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.99 Safari/537.36";

  final translateScript = """
        function googleTranslateElementInit() {
          new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
        }
        var script = document.createElement('script');
        script.src = 'https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit';
        document.head.appendChild(script);
      """;
//
// WebページヘッダのContainerを作成する
// 2025/4/15  他のDividedContainerと区別するために内部関数とした
  Widget? dividerContainer;

  _setDividedContainer(String msg, bool flag) {
    // テキスト指定の場合
    if (msg.isNotEmpty) {
      dividerContainer = Container(
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Text(
              msg,
              // Android版作成：フォントサイズを16->10へ
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 10),
            flag
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(4281099147),
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(fontSize: 14)),
                    onPressed: () {
                      launchUrlByRss(context, translateRss!);
                    },
                    child: const Text('翻訳'),
                  )
                : const SizedBox(width: 10),
            // const SizedBox(width: 10),
          ],
        ),
      );
    }
  }
}
