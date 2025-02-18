import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

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

  // initの多重化防止
  static bool _initOnce = false;

  // 画面サイズ
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
  double? tileContainerWidth;
  double? tileCircleWidth;
  double? updateInfoHeight;
  double? drawerWidth;
  // メインメニューアイコンサイズ
  double mainMenuIconSize = 24;
  double mainMenuCircleIconRadius = 22;
    double mainMenuCircleInnerIconRadius = 20;
  double mainMenuIconRadius = 12;
  double mainMenuSelectedIconRadius = 14;
  double mainMenuHeight = 52; //NewsPicsベンチマーク値
  // タイルのブックマークなどのアイコンサイズ
  double tileIconSize = 32;

  // cycle_screen  リマインダーのContainer部品のサイズ
  double remainderCycleHeight = 396; //個別コンテナ72 タイル72*1.5
  double remainderCycleHeightAdd = 474; //個別計測結果 remainderCycleHeight + 64;
  double remainderHeaderHeight = 160;
  double remainderWinupdateHeight = 380;
  double remainderPassupdateHeight = 300;
  double remainderVirusupdateHeight = 332;
  double remainderOtherupdateHeight = 364;
  double largeTileContainerHeight = 60; // 10%の高さだが60ジャストじゃないと？
  double remainderNewsContainerHeight = 478; //実測値
  double tileContainerHeight = 104;
  double columnContainerHeight = 432;

  void init(BuildContext context) {
    // リロードで再計算するのを防ぐ
    if (_initOnce) {
      return;
    } else {
      _initOnce = !_initOnce;
    }
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    // 上下の領域を抜いた実質的な高さを計算
    blockSizeVertical = screenHeight! - (72 * 2);

    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
    // タイルコンテナの大きさ
    tileContainerWidth = screenWidth! * 0.8;
    tileCircleWidth = tileContainerWidth! * 0.15;
    // 第一コンテンツの高さ（表示領域の1/5ぐらい？）
    updateInfoHeight = blockSizeVertical! * 0.2;
    // Drawerの幅
    drawerWidth = screenWidth! * 0.5;

    // タブレット対応（サイズ変更）はここで吸収する
    if (screenWidth! > 1000) {
      screenWidthTimes = 1.6; //1.7
      tileCircleWidth = 72;
      mainMenuIconSize = 48;
      mainMenuIconRadius = 24;
      mainMenuSelectedIconRadius = 26;
      mainMenuCircleIconRadius = 26;
      mainMenuCircleInnerIconRadius = 24;
    } else if (screenWidth! >= 800) {
      screenWidthTimes = 1.4;
      tileCircleWidth = 48;
      mainMenuIconSize = 32;
      mainMenuIconRadius = 16;
      mainMenuSelectedIconRadius = 18;
      mainMenuCircleIconRadius = 24;
      mainMenuCircleInnerIconRadius = 22;
    } else {
      screenWidthTimes = 1;
    }

    // cycle_screen  リマインダーのContainer部品のサイズ再計算
    if (screenWidthTimes! > 1) {
      remainderCycleHeight *= screenWidthTimes!;
      remainderCycleHeightAdd = remainderCycleHeight + 88;
      remainderHeaderHeight *= screenWidthTimes!;
      remainderWinupdateHeight *= screenWidthTimes!;
      remainderPassupdateHeight *= screenWidthTimes!;
      remainderVirusupdateHeight *= screenWidthTimes!;
      remainderOtherupdateHeight *= screenWidthTimes!;
      largeTileContainerHeight *= screenWidthTimes!;
      remainderNewsContainerHeight *= screenWidthTimes!;
      tileContainerHeight *= screenWidthTimes!;
      columnContainerHeight *= screenWidthTimes!;
      mainMenuHeight *= screenWidthTimes!;
    }
    // デバッグ文
    // debugPrint(
    //     "SizeConfig: screenWidth: $screenWidth, screenHeight $screenHeight, blockSizeHorizontal $blockSizeHorizontal, blockSizeVertical $blockSizeVertical, safeBlockHorizontal $safeBlockHorizontal, safeBlockVertical $safeBlockVertical,largeTileContainerHeight $largeTileContainerHeight");
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
// Android Tablet 11inch
// screenWidth: 800.0, screenHeight 1280.0, blockSizeHorizontal 8.0, blockSizeVertical 1136.0, safeBlockHorizontal 8.0, safeBlockVertical 12.24,largeTileContainerHeight 60.0
