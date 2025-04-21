// import 'package:flutter/material.dart';
// import 'package:daily_security_dev/global.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:cyber_interigence/model/cycle_schedule.dart';

const String cycleProfKey = 'securityCycle';

class CycleStore {
  Future<void> saveCycle(CycleSchedule cycleSchedule) async {
    final cycles = await SharedPreferences.getInstance();
    //この1行で保存のための変換を行なっている。
    String cycleStrings = jsonEncode(cycleSchedule.toJson());

    // if (debugPreference) {
    //   debugPrint("saveCycle: $cycleStrings");
    // }
    await cycles.setString(cycleProfKey, cycleStrings);
  }

  Future<CycleSchedule> loadCycle() async {
    final cycles = await SharedPreferences.getInstance();
    final String? encoded = cycles.getString(cycleProfKey);

    //何も保存されていない場合はデフォルトを生成
    if (encoded == null) {
      // if (debugPreference) {
      //   debugPrint("loadCycle: nothing Cycle");
      // }
      return Future<CycleSchedule>.value(const CycleSchedule());
    }

    // if (debugPreference) {
    //   debugPrint("loadCycle: $encoded");
    // }
    //JSON変換を行なって取得データを返す
    return Future<CycleSchedule>.value(
        CycleSchedule.fromJson(jsonDecode(encoded)));
  }

  Future<void> removeCycle() async {
    final cycles = await SharedPreferences.getInstance();
    await cycles.remove(cycleProfKey);
  }
}
