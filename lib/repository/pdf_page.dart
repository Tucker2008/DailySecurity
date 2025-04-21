import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:cyber_interigence/util/widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
// アプリ内でWebページを表示する
//
class PdfPage extends ConsumerStatefulWidget {
  const PdfPage({super.key, required this.rss});
  final RssInformation rss;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PdfPageState();
}

class _PdfPageState extends ConsumerState<PdfPage> {
  bool _isFirst = true;
  Widget dividerContainer = WidgetProvider().getWidget();
  String url = "";
  RssInformation? rss;

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
      // 引数のRSSを取り出す
      rss = widget.rss;
      // 指定URLを取得
      url = widget.rss.link!;
      // 指定コンテナを受領
      setDividerContainer(WidgetProvider().getWidget());
    }

    return Scaffold(
      appBar: AppbarConstant().getAppbarConstant(context),
      // body WebPage
      body: SafeArea(
        child: Column(
          children: [
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
