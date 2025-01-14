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

class _FirstScreenState extends ConsumerState<FirstScreen> {
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

    // 導入画面表示ステータスを返値として終了
    return PreferenceManager().getPreference().introductionState;
  }
}
