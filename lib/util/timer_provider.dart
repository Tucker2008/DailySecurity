// URL受け渡し用
import 'package:cyber_interigence/global.dart';

class TimerProvider {
  // クラス内インスタンス
  static final TimerProvider _instance = TimerProvider._();
  // プライベートコンストラクタ
  TimerProvider._();

  factory TimerProvider() {
    return _instance;
  }

  // 内部タイマー
  DateTime _activeCycle = DateTime.now();

  // どれくらい時間が経過したか？(外部から呼ばれる事はない？)
  int _getActiveDiference() {
    return DateTime.now().difference(_activeCycle).inHours;
  }

  // 内部タイマーのアップデート
  void updateTimer() {
    _activeCycle = DateTime.now();
  }

  // 規定時間以上の時間が経過したか？
  bool inactiveDiference() {
    final bool inactiveIsOverOrNot = (_getActiveDiference() > inactiveHours);
    updateTimer();
    return inactiveIsOverOrNot;
  }
}
