//
// ３段以上のステップでWidgetを渡したい場合
// これを使う（引数を繋いでいくのが面倒になった）
//

// 注意書きのコンテナ受け渡し用
import 'package:flutter/material.dart';

class WidgetProvider {
  // クラス内インスタンス
  static final WidgetProvider _instance = WidgetProvider._internal();
  // プライベートコンストラクタ
  WidgetProvider._internal();

  factory WidgetProvider() {
    return _instance;
  }

  static Widget _widget = dividerContainer;

  // displayFeedにわたすContainerを指定する
  void setWidget(Widget widget) {
    _widget = widget;
  }

  // 指定されているContainerを渡す
  Widget getWidget() {
    return _widget;
  }

  // displayFeedにわたすContainerを初期化
  void removeWidget() {
    _widget = dividerContainer;
  }

  //
//  区切りのコンテナ（デフォルト）
  static Widget dividerContainer = const Divider(
    height: 5,
    thickness: 5,
    indent: 0,
    endIndent: 0,
    color: Colors.black,
  );
}
