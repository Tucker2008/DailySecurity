import 'dart:async';
// import 'package:daily_security_dev/global.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/util/message_provider.dart';
import 'package:cyber_interigence/util/note_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const notificationPayloadKey = 'move';
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
        //   debugPrint("generateDeviceRecognitionToken[ios]: $apnsToken");
        // }
      } else {
        NoteProvider().setNote("APNSToken cannot get");
        // if (debugPreference) {
        //   debugPrint("generateDeviceRecognitionToken[ios]: Error");
        // }
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

  // Notificationをバックグラウンドで受信した場合の処理登録
  // Build6 (2025.2.16)
  // initialNotification()で初期処理で登録される

  // @pragma('vm:entry-point')
  // Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   // Firebase(Notification)のための初期化
  //   await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform);

  //   _remoteMessageProcedure("firebaseMessagingBackgroundHandler", message);
  // }

  // 受け取ったメッセージの共通処理部分
  // 元のコードでは例外が出るので、書き直しついでに中身を見る
  _remoteMessageProcedure(String dbgMessage, RemoteMessage msg) {
    // 通知で新しい記事が来た際のURLの受け渡し
    // 将来的には「コマンド」にしてリモートからコントロール出来ると良いかも
    String payload = "";
    // デバッグ
    // if (debugPreference) {
    //   debugPrint("$dbgMessage でメッセージを受け取りました: ${msg.notification?.title}");
    // }

    RemoteNotification? notification = msg.notification;
    // AndroidNotification? android = notification?.android;
    // AppleNotification? ios = notification?.apple;

    //
    // Notificationに"move"パラメータでURLがあれば通知に入れておく
    // Build6 (2025.2.16)
    Map<String, dynamic> msgData = msg.data;
    if (msgData[notificationPayloadKey] != null) {
      payload = msgData[notificationPayloadKey];
      // if (debugPreference) {
      //   debugPrint("msg.data : ${msgData.toString()}");
      // }
    }

    // notificationを取得出来たら処理する
    if (notification != null) {
      // if (debugPreference) {
      //   debugPrint(
      //       "flutterLocalNotificationsPlugin: ${notification.toMap().toString()}");
      //   debugPrint(
      //       "flutterLocalNotificationsPlugin[body]: ${notification.body}");
      // }

      // アプリ起動中のメッセージ表示
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          payload: payload,
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

  // 
  // デバッグ用に通知を内部発行させる
  // 
  void debugMessageProc() {
    const AndroidNotification an = AndroidNotification(
        tag: 'campaign_collapse_key_4790335902582931187',
        visibility: AndroidNotificationVisibility.public);
    const RemoteNotification rnot = RemoteNotification(
        title: "iOSのアップデートがあります(debugMessageProc)",
        titleLocArgs: [],
        titleLocKey: null,
        body: "iOSのアップデート情報があります",
        bodyLocArgs: [],
        bodyLocKey: null,
        android: an,
        apple: null,
        web: null);
    const Map<String, dynamic> data = {
      "move": "https://aokabi.way-nifty.com/blog/2025/02/post-90b7be.html",
    };
    const RemoteMessage msg = RemoteMessage(
      notification: rnot,
      data: data,
    );
    // ダミーで送ってみる
    _remoteMessageProcedure("debugMessageProc", msg);
  }

  //
  // Notificationをタップしたら起動する様に設定する
  // ここでは指定されたURLを受け取るだけ
  // （非常に実装コストが高い）
  // Build6 (2025.2.16)
  //
  Future<void> setLocalNotificationTap(BuildContext context) async {
    /// Defines a iOS/MacOS notification category for text input actions.
    const String darwinNotificationCategoryText = 'textCategory';

    /// Defines a iOS/MacOS notification category for plain actions.
    const String darwinNotificationCategoryPlain = 'plainCategory';

    /// A notification action which triggers a url launch event
// const String urlLaunchActionId = 'id_1';

    /// A notification action which triggers a App navigation event
    const String navigationActionId = 'id_3';
    final List<DarwinNotificationCategory> darwinNotificationCategories =
        <DarwinNotificationCategory>[
      DarwinNotificationCategory(
        darwinNotificationCategoryText,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.text(
            'text_1',
            'Action 1',
            buttonTitle: 'Send',
            placeholder: 'Placeholder',
          ),
        ],
      ),
      DarwinNotificationCategory(
        darwinNotificationCategoryPlain,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain('id_1', 'Action 1'),
          DarwinNotificationAction.plain(
            'id_2',
            'Action 2 (destructive)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
          DarwinNotificationAction.plain(
            navigationActionId,
            'Action 3 (foreground)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.foreground,
            },
          ),
          DarwinNotificationAction.plain(
            'id_4',
            'Action 4 (auth required)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.authenticationRequired,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      )
    ];

    const AndroidInitializationSettings initializationSettingsAndroid =
        // Thanks to https://stackoverflow.com/questions/56807107/theres-some-error-on-my-flutter-local-notification
        // AndroidInitializationSettings('app_icon');
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      notificationCategories: darwinNotificationCategories,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      // macOS: initializationSettingsDarwin,
      // linux: initializationSettingsLinux,
      // windows: windows.initSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      if (notificationResponse.notificationResponseType ==
          NotificationResponseType.selectedNotification) {
        // 将来的には汎用のpayload処理機構を作った方がいいだろうが
        // この時点では現実解である、payloadのパスを表示させる
        if (notificationResponse.payload != null) {
          // debugPrint(
          //     "setLocalNotificationTap: payload:${notificationResponse.payload}");

          // ペイロードを設定
          MessageProvider().setMsg(notificationResponse.payload!);
          // ペイロードに基づいて画面遷移
          // 画面遷移は、再起動にまかせてpayloadだけ受け取る
        }
      }
    });
  }
}
