import 'package:cyber_interigence/util/logo_provider.dart';
import 'package:flutter/material.dart';

//
// AppBarを共通化する
// ほとんどのページでAppBar指定が必要なために作成
//

class AppbarConstant {
  // クラス内インスタンス
  static final AppbarConstant _instance = AppbarConstant._();
  // プライベートコンストラクタ
  AppbarConstant._();

  factory AppbarConstant() {
    return _instance;
  }

  // 共通AppBarを返す
  PreferredSizeWidget getAppbarConstant() {
    return PreferredSize(
      // AppBarの大きさ指定
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        title: LogoProvider().getServiceLogo(),
        centerTitle: true,
      ),
    );
  }
}
