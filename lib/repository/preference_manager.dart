import 'package:cyber_interigence/model/preference.dart';
import 'package:cyber_interigence/repository/pref_store.dart';
// import 'package:flutter/foundation.dart';

class PreferenceManager extends PrefStore {
  // Singletonデザインパターン
  static final PreferenceManager _instance = PreferenceManager._();
  PreferenceManager._();

  factory PreferenceManager() {
    return _instance;
  }

  //Preference
  Preference _preference = Preference(
    notificationState: 0, // Notificationは未設定
    lastLoginDate: DateTime.now(),
  );

  Preference getPreference() {
    return _preference;
  }

  void flipIntroductionState() {
    _preference =
        _preference.copyWith(introductionState: !_preference.introductionState);
  }

  // Notificationの状況 0:未設定、1:権限なし  2:権限設定済 enum->NotificationStat
  void setNotificationState(int status) {
    _preference = _preference.copyWith(notificationState: status);
  }

  int getNotificationState() {
    return _preference.notificationState;
  }

  // デバッグオプション
  // void debugPrintState() {
  //   debugPrint("preference = ${_preference.toJson().toString()}");
  // }

  // 前回のログイン時間を保持する
  DateTime _referenceDate = DateTime.now();
  // ラストログインを取得する
  DateTime getLastLogin() {
    return _referenceDate;
  }

  void setToken(String token) {
    _preference = _preference.copyWith(tokenId: token);
  }

  String getToken() {
    return _preference.tokenId;
  }

  void setAppleToken(String token) {
    _preference = _preference.copyWith(appleToken: token);
  }

  void updateLastLogin() {
    _preference = _preference.copyWith(lastLoginDate: DateTime.now());
    savePreference();
  }

  void savePreference() {
    super.savePref(_preference);
  }

  void loadPreference() {
    final pref = super.loadPref();
    pref.then(
      (value) {
        _preference = value;
      },
    ).whenComplete(() => ());
    // LastLoginを取得
    _referenceDate = _preference.lastLoginDate;
  }
}
