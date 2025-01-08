import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:cyber_interigence/util/url_provider.dart';
import 'package:cyber_interigence/util/widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
// アプリ内でWebページを表示する
//
class PdfPage extends ConsumerStatefulWidget {
  const PdfPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PdfPageState();
}

class _PdfPageState extends ConsumerState<PdfPage> {
  // double _progress = 0.0;
  bool _isFirst = true;
  // bool _isLoading = false;
  Widget dividerContainer = WidgetProvider().getWidget();
  String url = "";

  // 区切りのコンテナ指定
  void setDividerContainer(Widget argContainer) {
    dividerContainer = argContainer;
  }

  @override
  void initState() {
    super.initState();
    setDividerContainer(dividerContainer);
  }

  @override
  Widget build(BuildContext context) {
    // Buildが複数回呼ばれるのでここで防ぐ（きれいな実装になってない）
    if (_isFirst) {
      _isFirst = false;
      // 指定URLを取得して
      url = UrlProvider().getUrl();
      debugPrint("_PdfPageState build $url");
      // 指定コンテナを受領
      setDividerContainer(WidgetProvider().getWidget());
    }

    return Scaffold(
      appBar: AppbarConstant().getAppbarConstant(),
      // body WebPage
      body: SafeArea(
        child: Column(
          children: [
            // _isLoading
            //     ? LinearProgressIndicator(
            //         value: _progress,
            //         color: Theme.of(context).colorScheme.errorContainer,
            //         minHeight: 10.0,
            //       )
            //     : const SizedBox.shrink(),
            // 区切り線（説明）
            dividerContainer,
            // Webページ
            Expanded(
                child: const PDF().cachedFromUrl(
              url,
              errorWidget: (error) =>
                  setDividedContainer(error.toString(), null),
            )),
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
