//
// カラー値を設定する
// Feed先頭のContainerの色を設定する
//

// サービスロゴの大きさ指定
import 'package:cyber_interigence/global.dart';
import 'package:flutter/material.dart';

const double logoHeight = 36.0;
const double logoWidth = 192.0;
const String logoBlackFile = 'images/servicel2b.png';
const String logoWhiteFile = 'images/servicel2w.png';

// エラー受け渡し用
class LogoProvider {
  // クラス内インスタンス
  static final LogoProvider _instance = LogoProvider._();
  // プライベートコンストラクタ
  LogoProvider._();

  factory LogoProvider() {
    return _instance;
  }

  bool _blackAndWhite = true;
  void setBlackOrWhite(bool flag) {
    _blackAndWhite = flag;
  }

  // Logoを返す（だけ）
  Widget getServiceLogo() {
    return Image.asset(
      _blackAndWhite ? logoBlackFile : logoWhiteFile,
      height: logoHeight * (sizeConfig.screenWidthTimes!),
      width: logoWidth * (sizeConfig.screenWidthTimes!),
    );
  }
}
