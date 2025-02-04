// セキュリティのリコメンドの原点となるスケジュール計算
//
import 'package:cyber_interigence/constant/cycle_scenario.dart';
import 'package:cyber_interigence/model/cycle_schedule.dart';
import 'package:cyber_interigence/repository/cycle_store.dart';
import 'package:intl/intl.dart' show DateFormat;

class CycleManager extends CycleStore {
  // Singletonデザインパターン
  static final CycleManager _instance = CycleManager._();
  CycleManager._();

  factory CycleManager() {
    return _instance;
  }

  // スケジュール原点となるWindowsUpdateの日付
  bool _setUpdateSchedule = false; // WindowsUpdateの日付計算は済み？
  int _windowsUpdateDurationDays = 0;
  DateTime _windowsUpdateDate = DateTime.now();
  // 画面のプライオリティ（４種類）
  int _scenarioDisplay = 0;
  // 決定されたシナリオパターン（番号）
  int _scenarioNum = -1;

  // マネージャの初期化処理
  void init() async {
    // セーブ内容を取得する
    _cycleSchedule = await super.loadCycle();
    // WindowsUpdate日程の取得
    if (!_setUpdateSchedule) {
      getLatestUpdate();
    }
    // シナリオの決定
    _makeCycleScenario();
  }

  // スケジュール原点となる各種実施日データ
  CycleSchedule _cycleSchedule = const CycleSchedule();

  // 単体テストモジュール
  // void testCycleManager() {
  //   for (int i = 1; i <= 30; i++) {
  //     final DateTime setDate =
  //         DateFormat('yyyy/MM/dd').parseStrict('2025/01/$i');
  //     debugPrint("testCycleManager: ${setDate.toString()}");
  //     _setUpdateDate(setDate);
  //     // シナリオ作成
  //     makeCycleScenario();
  //   }
  // }

  // シナリオの決定
  //
  void _makeCycleScenario() {
    // Windows Updateの日付と日付差分を取得
    if (!_setUpdateSchedule) {
      getLatestUpdate();
    }

    // シナリオパターンの取得
    // デバッグ用のパターンシミュレーション
    //
    final scenario =
        scenarioTable[scenarioTableAdjust - _windowsUpdateDurationDays];

    // scenarioTable[15]; // 15: "w" Win update更新のテスト
    // scenarioTable[8]; // 8: "p" パスワード更新のテスト
    // scenarioTable[9]; // 9: "pv" パスワードorウィルス更新のテスト
    // scenarioTable[0]; // 0: "dp" パスワードorバックアップのテスト
    // scenarioTable[25]; // 25: "vm" ウィルスorフィッシングのテスト
    // scenarioTable[26]; // 26: "vi" ウィルスorデータ持ち出しのテスト
    // scenarioTable[27]; // 27: "vs" ウィルスorスクリーンロックのテスト

    // 今日既に何か更新していたら、今日はこれ以上の確認をしない
    if (_checkUpdateToday()) {
      _scenarioDisplay = -1;
      _scenarioNum = -1;
      return;
    }

    // デバッグ用のパターンシミュレーション
    // _cycleSchedule = _cycleSchedule.copyWith(
    // otherDodate: DateFormat('yyyy/MM/dd').parseStrict('2025/01/01'),
    // passwordUpdate: DateFormat('yyyy/MM/dd').parseStrict('2025/01/01'),
    //   virusUpdate: DateFormat('yyyy/MM/dd').parseStrict('2025/01/01'),
    // );

    // winupdateの要件
    // w指定 & 今月update実施済みでない & Durationが0以下(過ぎている)
    if (scenario.contains(scenarioPattern[SCategory.w.index]) &&
        (_windowsUpdateDurationDays < 0) &&
        _checkUpdated(_cycleSchedule.winUpdate, scenarioStandartPeriod)) {
      _scenarioDisplay = 0;
      _scenarioNum = SCategory.w.index;
    }
    // Password更新の要件
    // p指定 & update実施済みでないか90日以前の実施済み
    else if (scenario.contains(scenarioPattern[SCategory.p.index]) &&
        _checkUpdated(_cycleSchedule.passwordUpdate, scenarioPasswordPeriod)) {
      _scenarioDisplay = 1;
      _scenarioNum = SCategory.p.index;
    }
    // ウィルスパターンファイル更新の要件
    // v指定 & update実施済みでないか30日以前の実施済み
    else if (scenario.contains(scenarioPattern[SCategory.v.index]) &&
        _checkUpdated(_cycleSchedule.virusUpdate, scenarioStandartPeriod)) {
      _scenarioDisplay = 2;
      _scenarioNum = SCategory.v.index;
    }
    // その他の要件 データバックアップ
    // d指定 & update実施済みでないか90日以前の実施済み
    else if (scenario.contains(scenarioPattern[SCategory.d.index]) &&
        _checkUpdated(_cycleSchedule.backupDodate, scenarioStandartPeriod)) {
      _scenarioDisplay = 3;
      _scenarioNum = SCategory.d.index;
    }
    // その他の要件 Fishing注意
    // m指定 & update実施済みでないか90日以前の実施済み
    else if (scenario.contains(scenarioPattern[SCategory.m.index]) &&
        _checkUpdated(_cycleSchedule.fishingDodate, scenarioStandartPeriod)) {
      _scenarioDisplay = 3;
      _scenarioNum = SCategory.m.index;
    }
    // その他の要件 情報持ち出し
    // i指定 & update実施済みでないか90日以前の実施済み
    else if (scenario.contains(scenarioPattern[SCategory.i.index]) &&
        _checkUpdated(_cycleSchedule.handleDodate, scenarioStandartPeriod)) {
      _scenarioDisplay = 3;
      _scenarioNum = SCategory.i.index;
    }
    // その他の要件 スクリーンロック
    // s指定 & update実施済みでないか90日以前の実施済み
    else if (scenario.contains(scenarioPattern[SCategory.s.index]) &&
        _checkUpdated(
            _cycleSchedule.displayLockDodate, scenarioStandartPeriod)) {
      _scenarioDisplay = 3;
      _scenarioNum = SCategory.s.index;
    }
    // 何も選択肢がない
    else {
      _scenarioDisplay = -1;
      _scenarioNum = -1;
    }
  }

  // Update実施済みか？確認する内部関数
  bool _checkUpdated(DateTime? dt, int durationDays) {
    // アップデートされていない
    if (dt == null) {
      return true;
    }
    // アップデートされたのが規定以前
    // debugPrint(
    //     "_checkUpdated: check days ${DateTime.now().difference(dt).inDays}");
    if (DateTime.now().difference(dt).inDays > durationDays) {
      return true;
    }
    return false;
  }

  // シナリオによって画面デザインを変える
  // 0: Win, 1: PW, 2: Virus, 3, その他
  int getScenarioPriority() {
    return _scenarioDisplay;
  }

  // シナリオによってチェックシナリオを変える
  // SCategory のindex値がセットされる
  int getScenarioNumber() {
    return _scenarioNum;
  }

  // どれか１つでも本日updateがあるか？
  // 配列舐め回し系
  bool _checkUpdateToday() {
    final todayDT = DateTime.now();
    if ((_cycleSchedule.winUpdate != null) &&
        (_cycleSchedule.winUpdate!.difference(todayDT).inDays == 0)) {
      return true;
    } else if ((_cycleSchedule.passwordUpdate != null) &&
        (_cycleSchedule.passwordUpdate!.difference(todayDT).inDays == 0)) {
      return true;
    } else if ((_cycleSchedule.virusUpdate != null) &&
        (_cycleSchedule.virusUpdate!.difference(todayDT).inDays == 0)) {
      return true;
    } else if ((_cycleSchedule.otherDodate != null) &&
        (_cycleSchedule.otherDodate!.difference(todayDT).inDays == 0)) {
      return true;
    }
    return false;
  }

  //
  // 以下はWindows updateの日付計算関連
  // 直近のUpdate日までの日数を取得する
  String getLatestUpdateDurationText() {
    if (_windowsUpdateDurationDays > 0) {
      return "あと $_windowsUpdateDurationDays 日";
    } else if (_windowsUpdateDurationDays == 0) {
      return "本日です";
    } else {
      final displayDays = _windowsUpdateDurationDays * (-1);
      return "すでに$displayDays日過ぎてます";
    }
  }

  // 直近のUpdate日を取得する
  String getLatestUpdate() {
    final today = DateTime.now();
    _setUpdateDate(today);
    return _dateToString(_windowsUpdateDate);
  }

  // 指定された日付のUpdate日を取得して変数保存（デバッグ活用）
  void _setUpdateDate(DateTime dt) {
    _windowsUpdateDate = _getUpdateDay(dt.year, dt.month);
    _windowsUpdateDurationDays = _windowsUpdateDate.difference(dt).inDays;
    // if (debugCycle) {
    //   debugPrint(
    //       "直近のWindows Updateは、${_windowsUpdateDate.month}月${_windowsUpdateDate.day}日の予定で、あと$_windowsUpdateDurationDays日あります。");
    // }
    _setUpdateSchedule = true;
  }

  // 指定年月の第二火曜日はいつか？
  // 月曜日が１始まりで、日曜日が７という仕様なので、0番目は空き
  final List<int> _offsetTable = [
    0,
    8, //月曜日 1
    7, //火曜日 2
    13, //水曜日 3
    12, //木曜日 4
    11, //金曜日 5
    10, //土曜日 6
    9, //日曜日 7
  ];

  DateTime _getUpdateDay(int year, int month) {
    // その月の１日が何曜日か？
    final firstDayOfMonth =
        DateFormat('yyyy/MM/dd').parseStrict('$year/$month/01');
    // デバッグ
    // debugPrint("getUpdateDay: firstDayOfMonth ${firstDayOfMonth.toString()}");
    // debugPrint("getUpdateDay: weekday ${firstDayOfMonth.weekday}");

    // 第二火曜日までのオフセット日数を取得する
    int offset = _offsetTable[firstDayOfMonth.weekday];
    // 米国のアップデート日を取得
    DateTime updateDayUs = firstDayOfMonth.add(Duration(days: offset));
    // 日本は米国の翌日
    return updateDayUs.add(const Duration(days: 1));
  }

  // 汎用的な日付を文字列にして返す
  String _dateToString(DateTime? dt) {
    if (dt == null) {
      return "----/--/--";
    }
    return "${dt.year}/${dt.month}/${dt.day}";
  }

  //
  // 各フラグの更新日と日付更新処理
  //
  // Windows Update 関連 ----------
  // Windows updateステータスを返す
  bool getWindowsUpdateSate() {
    return _cycleSchedule.winUpdate != null;
  }

  // Windows update日付をテキストで返す
  String getWindowsUpdateDateText() {
    return _dateToString(_cycleSchedule.winUpdate);
  }

  // update日付を設定する
  void setWindowsUpdateDate() async {
    _cycleSchedule = _cycleSchedule.copyWith(winUpdate: DateTime.now());
    await super.saveCycle(_cycleSchedule);
  }

  // パスワード更新 関連 ----------
  // パスワード更新ステータス返す
  bool getPasswordUpdateState() {
    return _cycleSchedule.passwordUpdate != null;
  }

  // パスワード更新日付をテキストで返す
  String getPasswordUpdateDateText() {
    return _dateToString(_cycleSchedule.passwordUpdate);
  }

  // パスワード更新日付を設定する
  void setPasswordUpdateDate() async {
    _cycleSchedule = _cycleSchedule.copyWith(passwordUpdate: DateTime.now());
    await super.saveCycle(_cycleSchedule);
  }

  // パターンファイル更新 関連 ----------
  // パターンファイル更新ステータスを返す
  bool getVirusUpdateSate() {
    return _cycleSchedule.virusUpdate != null;
  }

  // パターンファイル更新日付をテキストで返す
  String getVirusUpdateDateText() {
    return _dateToString(_cycleSchedule.virusUpdate);
  }

  // パターンファイル更新日付を設定する
  void setVirusUpdateDate() async {
    _cycleSchedule = _cycleSchedule.copyWith(virusUpdate: DateTime.now());
    await super.saveCycle(_cycleSchedule);
  }

  // その他の更新 関連 ----------
  // その他更新ステータスを返す
  bool getOtherState() {
    return _cycleSchedule.otherDodate != null;
  }

  // その他更新日付をテキストで返す
  String getOtherDateText() {
    return _dateToString(_cycleSchedule.otherDodate);
  }

  // その他更新日付を設定する
  // パックアップなどの他項目の実施に際しても更新すること
  void _setOtherDate() async {
    _cycleSchedule = _cycleSchedule.copyWith(otherDodate: DateTime.now());
    await super.saveCycle(_cycleSchedule);
  }

  // バックアップ実施 関連 ----------
  // バックアップ実施日付をテキストで返す
  String getBackupDodateText() {
    return _dateToString(_cycleSchedule.backupDodate);
  }

  // バックアップ実施日付を設定する
  void setBackupDodateDate() async {
    _cycleSchedule = _cycleSchedule.copyWith(backupDodate: DateTime.now());
    _setOtherDate();
    await super.saveCycle(_cycleSchedule);
  }

  // フィッシング警戒 関連 ----------
  // フィッシング警戒日付をテキストで返す
  String getFishingDodateText() {
    return _dateToString(_cycleSchedule.fishingDodate);
  }

  // フィッシング警戒日付を設定する
  void setFishingDodateDate() async {
    _cycleSchedule = _cycleSchedule.copyWith(fishingDodate: DateTime.now());
    _setOtherDate();
    await super.saveCycle(_cycleSchedule);
  }

  // フィッシング警戒 関連 ----------
  // フィッシング警戒日付をテキストで返す
  String getHandleDodateText() {
    return _dateToString(_cycleSchedule.handleDodate);
  }

  // フィッシング警戒日付を設定する
  void setHandleDodateDate() async {
    _cycleSchedule = _cycleSchedule.copyWith(handleDodate: DateTime.now());
    _setOtherDate();
    await super.saveCycle(_cycleSchedule);
  }

  // フィッシング警戒 関連 ----------
  // フィッシング警戒日付をテキストで返す
  String getDisplayLockDodateText() {
    return _dateToString(_cycleSchedule.displayLockDodate);
  }

  // フィッシング警戒日付を設定する
  void setDisplayLockDodateDate() async {
    _cycleSchedule = _cycleSchedule.copyWith(displayLockDodate: DateTime.now());
    _setOtherDate();
    await super.saveCycle(_cycleSchedule);
  }

  //
  // Entrance画面でチェックすべきテキストを返す
  // constantではないのでswitch文が使えない
  //
  String getScenarioNumberText() {
    if (_scenarioNum == SCategory.w.index) {
      return "Windows Updateを確認していますか？";
    } else if (_scenarioNum == SCategory.p.index) {
      return "パスワードを更新していますか？";
    } else if (_scenarioNum == SCategory.v.index) {
      return "ウィルスパターンファイルを更新していますか？";
    } else if (_scenarioNum == SCategory.d.index) {
      return "バックアップの確認をしていますか？";
    } else if (_scenarioNum == SCategory.m.index) {
      return "フィッシング詐欺に注意をしていますか？";
    } else if (_scenarioNum == SCategory.i.index) {
      return "ローカルに重量情報を保存してないですか？";
    } else if (_scenarioNum == SCategory.s.index) {
      return "スクリーンロックを設定していますか？";
    } else {
      return "順調にセキュリティ活動されています！";
    }
  }
}
