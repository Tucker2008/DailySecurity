//
// 下線ドットのContainer
// ちょっと特殊だが、紙質風にする工夫
//
// 引数には 上に乗せるWidgetとPadding、下線の色を指定する
// 太さは2.0で固定
// Thanks to MicroSoft Copilot
//

import 'package:flutter/material.dart';

class DottedUnderlineContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color borderColor;
  const DottedUnderlineContainer(
      {super.key,
      required this.child,
      required this.padding,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedUnderlinePainter(
        borderColor: borderColor,
      ),
      child: Container(
        padding: padding,
        child: child,
      ),
    );
  }
}

class DottedUnderlinePainter extends CustomPainter {
  final Color borderColor;
  const DottedUnderlinePainter({required this.borderColor});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height),
        Offset(startX + dashWidth, size.height),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
