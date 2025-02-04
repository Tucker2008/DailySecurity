//
// 右下が折れたコンテナ
// 背景に紙のテクスチャを貼ることで紙感が増す
//
// Thanks  https://qiita.com/mayaaaaaaaaaaa/items/89fc52b1fc9742a8cd14

import 'package:flutter/material.dart';

// 折れたところのサイズを設定する
const _clipSize = Size(40, 40);

//
// 右下の折れたコンテナ
//
Widget eardogContainer(BuildContext context, double height, Widget widget) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: ClipPath(
      clipBehavior: Clip.antiAlias,
      clipper: PaperClipper(),
      child: Stack(
        children: [
          // コンテナを表示する領域
          Container(
            width: double.infinity,
            height: height,
            padding: const EdgeInsets.only(left: 12, top: 8, right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceDim,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(15.0)),
              image: const DecorationImage(
                image: AssetImage('images/paper-texture.jpg'),
                fit: BoxFit.fill,
                opacity: 0.7, //透明度は常に検討
              ),
            ),
            child: widget,
          ),
          // Positionedで右下にめくれたようなUIを配置する
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: _clipSize.width,
              height: _clipSize.height,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ),
  );
}

/// 角折れを表現するためのClipper
class PaperClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // 折れてるところだけを切り抜く
    final path = Path();
    path.lineTo(0, 0); // Start
    path.lineTo(size.width, 0); // 右上
    path.lineTo(size.width, size.height - _clipSize.height); // 折れてるところ
    path.lineTo(size.width - _clipSize.width, size.height); // 折れてるところ
    path.lineTo(0, size.height); // End
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
