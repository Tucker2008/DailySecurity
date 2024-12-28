import 'dart:async';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/util/message_provider.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const newMessageAdditional = '新しいお知らせが入りました';

// Notificationのステータス（.indexをつけてintで扱う）
enum NotificationStat {
  notSet,
  denied,
  authorized,
}

int notificationStatNotSet = NotificationStat.notSet.index;
int notificationStatDenied = NotificationStat.denied.index;
int notificationStatAuthorized = NotificationStat.authorized.index;

//
// PushNotification関連処理のクラス
//
class PushNotificationService {
  // クラス内インスタンス
  static final PushNotificationService _instance = PushNotificationService._();
  // プライベートコンストラクタ
  PushNotificationService._();

  factory PushNotificationService() {
    return _instance;
  }
  // LocalNotificationの生成
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // FirebaseMessaging初期化
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // iOSの場合のApple Tokenを保持しておいて後でPreferenceに保存する
  String appleTokenId = "";
  String getAppleTokenId() {
    return appleTokenId;
  }

  // 通知のパーミッション（許可）設定
  // FlutterFireに掲載されているパーミッション取得ロジックをそのまま実行
  Future<NotificationSettings> requestPermissons() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      // provisional: false,
      provisional: true,
      sound: true,
    );
    // if (debugPreference) {
    //   debugPrint(
    //       "PushNotificationService:requestPermisson: ${settings.authorizationStatus.toString()}");
    // }
    // パーミッションがない場合
    if ((settings.authorizationStatus == AuthorizationStatus.denied) ||
        (settings.authorizationStatus == AuthorizationStatus.notDetermined)) {
      // ない場合は次のオプション設定を行わない
    } else {
      // for IOS?
      await firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }

    return Future<NotificationSettings>.value(settings);
  }

  // Firebase Messagingの手順書に従った手順でToken取得
  Future<String> generateDeviceRecognitionToken() async {
    // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        // APNS token is available, make FCM plugin API requests...
        appleTokenId = apnsToken;
        // if (debugPreference) {
        // debugPrint("generateDeviceRecognitionToken[ios]: $apnsToken");
        // }
      } else {
        NoteProvider().setNote("APNSToken cannot get");
      }
    }
    // トークンを取得（設定）
    final fcmToken = await FirebaseMessaging.instance.getToken();
    // FCM の自動初期化をランタイム時に再度有効にする
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    // if (debugPreference) {
    //   debugPrint("generateDeviceRecognitionToken: $fcmToken");
    // }

    // Notificationは２種類定義。アプリ用とユーザ向け
    // firebaseMessaging.subscribeToTopic("Application");
    // firebaseMessaging.subscribeToTopic("User");

    // Androidの場合のチャネル生成
    if (defaultTargetPlatform == TargetPlatform.android) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    return Future<String>.value(fcmToken);
  }

  // 通知受信設定（受診時の処理を登録する）
  // トークンが取得されていない場合には、トークン取得・プロフ記録する
  startListeningForNewNotification() async {
    // if (debugPreference) {
    // debugPrint("startListeningForNewNotification: start");
    // }
    // Notification処理がされていない場合には、なにもしない
    if ((PreferenceManager().getNotificationState() ==
            notificationStatNotSet) ||
        (PreferenceManager().getNotificationState() ==
            notificationStatDenied)) {
      // debugPrint(
      //     "startListeningForNewNotification: status error ${PreferenceManager().getNotificationState()}");
      return;
    }

    //   Terminated
    //   When the app is completely closed and it receives a push notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMsg) {
      if (remoteMsg != null) {
        _remoteMessageProcedure("getInitialMessage", remoteMsg);
        // String tripID = remoteMsg.data["tripID"];
        // retrieveTripRequestInfo(tripID, context);
      }
    });
    //   foreground
    //   When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMsg) {
      if (remoteMsg != null) {
        _remoteMessageProcedure("onMessage.listen", remoteMsg);
      }
    });
    //   Background
    //   When the app is in the background and it receives a push notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMsg) {
      if (remoteMsg != null) {
        _remoteMessageProcedure("onMessageOpenedApp", remoteMsg);
      }
    });
    // if (debugPreference) {
    //   debugPrint("startListeningForNewNotification: end");
    // }
  }

  // 受け取ったメッセージの共通処理部分
  // 元のコードでは例外が出るので、書き直しついでに中身を見る
  _remoteMessageProcedure(String dbgMessage, RemoteMessage msg) {
    // if (debugPreference) {
    // デバッグ
    // debugPrint("$dbgMessage でメッセージを受け取りました: ${msg.notification?.title}");
    // }

    RemoteNotification? notification = msg.notification;
    // AndroidNotification? android = notification?.android;
    // AppleNotification? ios = notification?.apple;

    // if (debugPreference) {
    //   if (android != null) {
    //     debugPrint("デバイス種別 android : ${android.toMap().toString()}");
    //   } else if (ios != null) {
    //     debugPrint("デバイス種別 apple: ${ios.toMap().toString()}");
    //   }
    // }
    if (notification != null) {
      MessageProvider().setMsg(notification.body!);
      // if (debugPreference) {
      // debugPrint(
      //     "flutterLocalNotificationsPlugin: ${notification.toMap().toString()}");
      // debugPrint("flutterLocalNotificationsPlugin[body]: ${notification.body}");
      // }

      // アプリ起動中のメッセージ表示
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              "high_importance_channel",
              'High Importance Notifications',
              channelDescription:
                  'This channel is used for important notifications.',
              icon: '@mipmap/ic_launcher',
              // 以下２行はバナーを出したい場合に設定必要とのこと
              importance: Importance.high,
              priority: Priority.high,
              subText: newMessageAdditional,
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBanner: true,
              presentSound: true,
              subtitle: newMessageAdditional,
            ),
          ));
    }
  }

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
}
