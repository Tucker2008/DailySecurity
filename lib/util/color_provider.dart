import 'package:flutter/material.dart';

//
// カラー値を設定する
// Feed先頭のContainerの色を設定する
//

Color boxdecorationColor = Colors.black;
Color borderColor = Colors.black;
Color frontColor = Colors.white;

// 固定コンテナ用のカラー設定クラス
class ColorProvider {
  // クラス内インスタンス
  static final ColorProvider _instance = ColorProvider._();
  // プライベートコンストラクタ
  ColorProvider._();

  factory ColorProvider() {
    return _instance;
  }

  // displayFeedにわたすContainerの色指定をする
  // 他コンテンツと色の差を付ける 2025.6.20
  void setContextColor(BuildContext context) {
    // boxdecorationColor = Theme.of(context).colorScheme.surfaceDim;
    // frontColor = Theme.of(context).colorScheme.primary;
    boxdecorationColor = Theme.of(context).colorScheme.primaryContainer;
    frontColor = Theme.of(context).colorScheme.onPrimaryContainer;
    borderColor = Theme.of(context).colorScheme.secondaryContainer;
  }
}
