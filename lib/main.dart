import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/introduction/onboarding_page.dart';
import 'package:cyber_interigence/pages/main_screen.dart';
import 'package:cyber_interigence/repository/bookmark_manager.dart';
import 'package:cyber_interigence/repository/initial_preference.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/util/color_provider.dart';
import 'package:cyber_interigence/util/timer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/firebase_options.dart';
import 'package:cyber_interigence/theme/theme.dart';
import 'package:cyber_interigence/theme/util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cyber_interigence/methods/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:cyber_interigence/util/logo_provider.dart';
import 'package:cyber_interigence/repository/cache_manager.dart';
import 'package:cyber_interigence/util/message_provider.dart';
import 'package:cyber_interigence/repository/cycle_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ナビゲーションバーをちゃんと表示する
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // Firebase(Notification)のための初期化
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // フォントとカラースキームを初期設定
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme =
        createTextTheme(context, "Noto Sans Gothic", "Sawarabi Gothic");
    MaterialTheme theme = MaterialTheme(textTheme);
    // 画面サイズ関連データを初期化
    sizeConfig.init(context);
    fontSize.init(sizeConfig.screenWidthTimes!);

    // アプリ起動
    return MaterialApp(
      debugShowCheckedModeBanner: false, //右上バナーを取る
      theme: brightness == Brightness.light
          ? theme.lightMediumContrast()
          : theme.darkMediumContrast(),
      // 初期画面表示
      home: const FirstScreen(),
    );
  }
}

// 初期処理（データロードと設定を行う）
// 初期画面が未表示であれば、OnBoardingPage()で表示
// ２回目以降はメインスクリーンを表示
class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen>
    with WidgetsBindingObserver {
  //
  // アプリのライフサイクルで再開した時に一定時間が経過したらリロードする
  //
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    bool notifierMsgState = false;
    switch (state) {
      // アプリは表示されているが、フォーカスがあたっていない状態（対応なし）
      case AppLifecycleState.inactive:
        break;
      //アプリがバックグラウンドに遷移し、入力不可な一時停止状態（対応なし）
      case AppLifecycleState.paused:
        break;
      // アプリが終了する時に通る終了処理用の状態（対応もなし）
      case AppLifecycleState.detached:
        break;
      // hiddenは意味不明(再インストールした時に出た)
      case AppLifecycleState.hidden:
        break;
      //
      // 再開された時には新たに記事取得する様にする
      // アプリがフォアグランドに遷移し（paused状態から復帰）、復帰処理用の状態
      case AppLifecycleState.resumed:
        // ブラウザ起動して戻るとresumedになるので一定時間経過で判別する
        if (TimerProvider().inactiveDiference()) {
          // キャッシュを削除
          CacheManager().initCache();
          // 再開時間をアップデート
          TimerProvider().updateTimer();
        }
        // Notificationから起動されたか？
        if (MessageProvider().getMsg().isNotEmpty) {
          MessageProvider().removeMsg();
        }
        if (!notifierMsgState) {
          // 画面を再描画
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => super.widget));
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // firstContainerの色指定
    ColorProvider().setContextColor(context);
    // ロゴの色を設定する
    LogoProvider().setBlackOrWhite(
        Theme.of(context).colorScheme.brightness == Brightness.light);
    //
    // 初期化を待ちながらメインスクリーンか初期画面を出す
    //
    return FutureBuilder(
      // 設定情報を読み込む
      future: _initApplication(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return splashScreen(context);
        }
        if (snapshot.error != null) {
          return splashScreen(context);
        }
        if (snapshot.data != null && snapshot.data == true) {
          // false?
          return const MainScreen();
        } else {
          return const OnBoardingPage();
        }
      },
    );
  }

  // ユーザの設定情報入出力クラス定義と読み込み
  Future<bool> _initApplication() async {
    // Preferenceをロードする(最初にやらないとその後の参照系が動かない)
    PreferenceManager().loadPreference();

    // 通知設定の初期化
    final initialPreference = InitialPreference();
    if (!await initialPreference.initialNotification()) {
      // 通知設定がNGの場合には、イントロを表示する
      return false;
    }
    // 起動時間を初期化
    TimerProvider().updateTimer();

    // ブックマークをロードする
    BookmarkManager().loadBookmarks();

    // セキュリティシナリオの初期化
    CycleManager().init();

    // 導入画面表示ステータスを返値として終了
    return PreferenceManager().getPreference().introductionState;
  }
}
