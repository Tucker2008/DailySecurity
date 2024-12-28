// import 'package:flutter/material.dart';
// import 'package:cyber_interigence/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:cyber_interigence/model/preference.dart';

class PrefStore {
  // これ単体で使うことはなくなったため、以下を削除
  // // クラス内インスタンス
  // static final PrefStore _instance = PrefStore._();
  // // プライベートコンストラクタ
  // PrefStore._();

  // factory PrefStore() {
  //   return _instance;
  // }

  Future<void> savePref(Preference prof) async {
    const String profKey = 'preference';
    final prefs = await SharedPreferences.getInstance();
    //この1行で保存のための変換を行なっている。
    String profStrings = jsonEncode(prof.toJson());
    // if (debugPreference) {
    //   debugPrint("savePref: $profStrings");
    // }
    await prefs.setString(profKey, profStrings);
  }

  Future<Preference> loadPref() async {
    const String profKey = 'preference';
    final prefs = await SharedPreferences.getInstance();
    final String? encoded = prefs.getString(profKey);

    //何も保存されていない場合はデフォルトを生成
    if (encoded == null) {
      // if (debugPreference) {
      //   debugPrint("loadPref: nothing Proference");
      // }
      return Future<Preference>.value(Preference(
        notificationState: 0, //Notification OnOff情報
        lastLoginDate: DateTime.now(), //LastLogin
        //ブラウザの設定情報,初期情報、ユーザIDはデフォルト
      ));
    }
    //JSON変換を行なって取得データを返す
    // if (debugPreference) {
    //   debugPrint("loadPref: $encoded");
    // }
    return Future<Preference>.value(Preference.fromJson(jsonDecode(encoded)));
  }

  Future<void> removePref() async {
    const String profKey = 'preference';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(profKey);
  }
}
