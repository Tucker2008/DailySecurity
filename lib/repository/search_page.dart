import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:cyber_interigence/util/bookmark_provider.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:cyber_interigence/util/widget_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
// アプリ内で検索結果を表示する
// ※2025/4/20
// ※この方式ではうまく行かないので、検索エンジン含め作り直し
//
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key, this.searchWord});

  final String? searchWord;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  String? searchWord;
  String url = "";
  double _progress = 0.0;
  bool _isFirst = true;
  bool _isLoading = false;
  Widget dividerContainer = WidgetProvider().getWidget();
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  // 区切りのコンテナ指定
  void setDividerContainer(Widget argContainer) {
    dividerContainer = argContainer;
  }

  @override
  void initState() {
    super.initState();
    setDividerContainer(dividerContainer);
    controller.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) {
        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }
      },
      onPageFinished: (url) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      onProgress: (progress) {
        if (mounted) {
          setState(() {
            _progress = progress / 100;
          });
        }
      },
      // HTTPのエラーは区切り線にエラーを表示（したい）
      onHttpError: (HttpResponseError error) {
        setDividedContainer(
            "On HTTP Error: ${error.response?.statusCode} ", null);
      },
      onWebResourceError: (WebResourceError error) {
        // Androidバージョン作成：ブラウザで頻繁に出るので無視
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          setDividedContainer(
              "On Web Resource Error: ${error.toString()} ", null);
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Buildが複数回呼ばれるのでここで防ぐ（きれいな実装になってない）
    if (_isFirst) {
      // 初回フラグを下ろす
      _isFirst = false;
      // 引数の検索語を取得
      searchWord = widget.searchWord ?? NoteProvider().getNote();
      // 指定URLを取得
      url =
          "https://www.google.co.jp/search?hl=ja&sitesearch=https%3A%2F%2Faokabi.way-nifty.com%2F&q=インシデント&btng=$searchWord";
      // URLをコントローラに設定
      controller.loadRequest(Uri.parse(url));

      // BookMarkProviderにWatch定義
      // Map<String, RssInformation> bookmarkMap = ref.watch(bookmarkProvider);
      ref.watch(bookmarkProvider);
      bookmarkNotifier = ref.read(bookmarkProvider.notifier);
    }

    return Scaffold(
      appBar: AppbarConstant().getAppbarConstant(context),
      // body WebPage
      body: SafeArea(
        child: Column(
          children: [
            _isLoading
                ? LinearProgressIndicator(
                    value: _progress,
                    color: Theme.of(context).colorScheme.errorContainer,
                    minHeight: 10.0,
                  )
                : const SizedBox.shrink(),
            // 区切り線（説明）
            dividerContainer,
            // Webページ
            Expanded(child: WebViewWidget(controller: controller)),
          ],
        ),
      ),
    );
  }

  //
  // WebページヘッダのCOntainerを作成する
  //
  setDividedContainer(String msg, Widget? argDisplayContainer) {
    // テキスト指定の場合
    if (msg.isNotEmpty) {
      dividerContainer = Container(
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        child: Text(
          msg,
          // Android版作成：フォントサイズを16->10へ
          style: const TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
        ),
      );
    } else if (argDisplayContainer != null) {
      dividerContainer = argDisplayContainer;
    }
    // debugPrint("setDividedContainer set");
  }
}
