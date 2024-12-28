// import 'package:cyber_interigence/model/preference.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/repository/push_notification_service.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:cyber_interigence/global.dart';

// ここはPreferenceの初期化及び通知設定を行うクラス

class InitialPreference {
  // 設定情報の取得
  final preferenceManager = PreferenceManager();
  final notificationService = PushNotificationService();
  // final Preference myPreference = PreferenceManager().getPreference();
  String notificationTokenString = "";

  // Notification関連の権限チェックとToken取得
  // Notification受診時の処理登録
  Future<bool> initialNotification() async {
    // Notificationのパーミッションを確認する
    // 後から通知許可を消すかも知れないので毎回確認する
    final NotificationSettings status =
        await PushNotificationService().requestPermissons();
    if ((status.authorizationStatus == AuthorizationStatus.denied) ||
        (status.authorizationStatus == AuthorizationStatus.notDetermined)) {
      // パーミッションがない場合は次のオプション設定を行わない
      preferenceManager.setNotificationState(notificationStatDenied);
      final msg =
          "Permission: Notification error: ${notificationStatDenied.toString()}";
      NoteProvider().setNote(msg);
      return false;
    } else {
      preferenceManager.setNotificationState(notificationStatAuthorized);
      // final msg =
      //     "Permission: Notification: ${notificationStatAuthorized.toString()}";
      // NoteProvider().setNote(msg);
    }

    // トークンを取得する
    if (preferenceManager.getToken().isEmpty) {
      _initTokenPrefernce();
    }
    // else {
    //   NoteProvider().setNote("Notification: get Token NOT Done");
    // }

    // 最後にNotificationリスニングメソッドの設定
    notificationService.startListeningForNewNotification();
    return true;
  }

  // NotificationのTokenを取得してPreferenceに保存する
  void _initTokenPrefernce() async {
    // 通知Tokenの取得
    notificationTokenString =
        await notificationService.generateDeviceRecognitionToken();

    // myPreferenceの更新（tokenを入れておく）
    // if (debugPreference) {
    //   debugPrint("_savePrefernce[futureRef]: $notificationTokenString");
    // debugPrint("_initTokenPrefernce: $notificationTokenString");
    // }
    preferenceManager.setToken(notificationTokenString);
    preferenceManager.setAppleToken(
        notificationService.getAppleTokenId().isNotEmpty
            ? notificationService.getAppleTokenId()
            : "");

    // if (debugPreference) {
    // debugPrint(
    //     "_savePrefernce[save]: ${PreferenceManager().getPreference().toString()}");
    // }

    preferenceManager.savePreference();
  }
}
