// import 'package:flutter/material.dart';
import 'package:cyber_interigence/constant/cycle_scenario.dart';
import 'package:cyber_interigence/repository/cycle_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
// 単純にCycleScreenで状態管理する

class ScenarioNotifier extends StateNotifier<int> {
  // この時点でシナリオ決定して優先されるContainer番号が決まっている
  ScenarioNotifier() : super(CycleManager().getScenarioPriority());

  // シナリオ番号をリセットする
  void _resetScenarioNum() {
    // シナリオ完了→シナリオクリア
    CycleManager().init();
  }

  // ブックマークのフラグを返す
  // BookmarkManager().bookmarkedList でRssinformationに移しているので
  // ここでは２重管理しない
  //
  void flipScenarioDone(int scenario) {
    final manager = CycleManager();

    if (scenario == SCategory.w.index) {
      manager.setWindowsUpdateDate();
    } else if (scenario == SCategory.p.index) {
      manager.setPasswordUpdateDate();
    } else if (scenario == SCategory.v.index) {
      manager.setVirusUpdateDate();
    } else if (scenario == SCategory.d.index) {
      manager.setBackupDodateDate();
    } else if (scenario == SCategory.m.index) {
      manager.setFishingDodateDate();
    } else if (scenario == SCategory.i.index) {
      manager.setHandleDodateDate();
    } else if (scenario == SCategory.s.index) {
      manager.setDisplayLockDodateDate();
    }

    // ここでstateを変更する
    _resetScenarioNum();
    state = CycleManager().getScenarioPriority();
  }
}
