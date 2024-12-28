import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:cyber_interigence/global.dart';

// 起動待ちの画面（いわゆるぐるぐる画面）
Widget splashScreen(BuildContext context) {
  return Center(
    child: LoadingAnimationWidget.hexagonDots(
      color: Theme.of(context).colorScheme.primary,
      size: 100,
    ),
  );
}

// 起動待ちの画面（いわゆるぐるぐる画面）
Widget splashScreenNoContext() {
  return Center(
    child: LoadingAnimationWidget.hexagonDots(
      color: const Color(4281099147),
      size: 100,
    ),
  );
}

// エラー発生画面（いわゆるぐるぐる画面）
Widget splashScreenException(String errCode) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "エラーが発生しました。恐れ入りますが再起動をお願いします",
        style: TextStyle(fontSize: fontSize.headlineH5),
      ),
      Text(errCode.isEmpty ? " " : errCode,
          style: TextStyle(fontSize: fontSize.headlineH6)),
      Center(
        child: LoadingAnimationWidget.hexagonDots(
          color: const Color(4281099147),
          size: 100,
        ),
      ),
    ],
  );
}
