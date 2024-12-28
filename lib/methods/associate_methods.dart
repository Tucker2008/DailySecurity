import 'package:flutter/material.dart';

class AssociateMethods {
  // Singletonデザインパターン
  static final AssociateMethods _instance = AssociateMethods._();
  AssociateMethods._();

  factory AssociateMethods() {
    return _instance;
  }

  void showSnackBarMsg(String msg, BuildContext cxt) {
    var snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(cxt).showSnackBar(snackBar);
  }
}
