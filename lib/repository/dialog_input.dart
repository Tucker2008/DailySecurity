//
// ダイアログで入力欄を表示する
//

import 'package:cyber_interigence/util/note_provider.dart';
import 'package:cyber_interigence/repository/search_page.dart';
import 'package:flutter/material.dart';

// ダイアログで入力する
// 2025.4.20 検索は根本的に作り直しなので、このダイアログも封印（呼ばれてない）
Future<void> inputDialog(BuildContext context, String title, String hint,
    String cancelTitle, String goTitle) async {
  final TextEditingController controller = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hint),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                // backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              child: Text(cancelTitle),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              child: Text(goTitle),
              onPressed: () {
                debugPrint(controller.text);
                if (controller.text.isEmpty) {
                  Navigator.pop(context);
                }
                // 引数でSearchPage()を渡そうとしたがうまくいかないので
                // ここは諦めて直接呼ぶ
                NoteProvider().setNote(controller.text);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SearchPage(searchWord: controller.text)));
              },
            ),
          ],
        );
      });
}
