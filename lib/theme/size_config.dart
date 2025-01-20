import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//
// 画面サイズに応じた比率や行数などを定義する
//
class SizeConfig {
  // クラス内インスタンス
  static final SizeConfig _instance = SizeConfig._();
  // プライベートコンストラクタ
  SizeConfig._();

  factory SizeConfig() {
    return _instance;
  }

  static MediaQueryData? _mediaQueryData;
  double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;
  double? screenWidthTimes;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;

    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;

    // タブレット対応（サイズ変更）はここで吸収する
    if (screenWidth! > 1000) {
      screenWidthTimes = 1.7;
    } else if (screenWidth! > 800) {
      screenWidthTimes = 1.4;
    } else {
      screenWidthTimes = 1;
    }

    // デバッグ文
    // debugPrint(
    //     "SizeConfig: screenWidth: $screenWidth, screenHeight $screenHeight, blockSizeHorizontal $blockSizeHorizontal, blockSizeVertical $blockSizeVertical, safeBlockHorizontal $safeBlockHorizontal, safeBlockVertical $safeBlockVertical");
  }
}

// サイズ記録
// 202b5f360cee  Andoroid: Shaomi RedMi
// SizeConfig: screenWidth: 392, screenHeight 894, blockSizeHorizontal 3.9, blockSizeVertical 8.9, safeBlockHorizontal 3.9, safeBlockVertical 8.09
// 
// 00008020-00057111019A002E iOS: iPhone X
// SizeConfig: screenWidth: 414.0, screenHeight 896.0,
// 
// 3B9BF16E-1D08-4630-AA6F-68559F8F7502 iPhone16 simulator
// screenWidth: 393.0, screenHeight 852.0, blockSizeHorizontal 3.93, blockSizeVertical 8.52, safeBlockHorizontal 3.93, safeBlockVertical 7.59
// 
// 6BC57B49-8729-499A-8848-FC3E739AE6FE  iOS: iPad Pro 13inch
// SizeConfig: screenWidth: 1032.0, screenHeight 1376.0,
// 
// iPad Air 11-inch (M2)
// screenWidth: 820.0, screenHeight 1180.0, blockSizeHorizontal 8.2, blockSizeVertical 11.8, safeBlockHorizontal 8.2, safeBlockVertical 11.31
// 