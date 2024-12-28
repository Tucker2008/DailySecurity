import 'package:flutter/material.dart';

//
// カラー値を設定する
// Feed先頭のContainerの色を設定する
//

Color boxdecorationColor = Colors.black;
Color borderColor = Colors.black;
Color frontColor = Colors.white;

// エラー受け渡し用
class ColorProvider {
  // クラス内インスタンス
  static final ColorProvider _instance = ColorProvider._();
  // プライベートコンストラクタ
  ColorProvider._();

  factory ColorProvider() {
    return _instance;
  }

  // displayFeedにわたすContainerの色指定をする
  void setContextColor(BuildContext context) {
    boxdecorationColor = Theme.of(context).colorScheme.surfaceDim;
    borderColor = Theme.of(context).colorScheme.secondaryContainer;
    frontColor = Theme.of(context).colorScheme.primary;
  }
}
