import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/entry/display_feed.dart';
import 'package:cyber_interigence/model/rss_information.dart';
import 'package:cyber_interigence/pages/cocolog_page.dart';
import 'package:cyber_interigence/pages/news_main_page.dart';
import 'package:cyber_interigence/repository/cache_manager.dart';
import 'package:cyber_interigence/util/message_provider.dart';
import 'package:cyber_interigence/util/timer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/global.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
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
          // debugPrint(
          //     "didChangeAppLifecycleState resume: ${MessageProvider().getMsg()}");
          notifierMsgState = DisplayFeed(
                  informationListArg: <RssInformation>[],
                  firstContainer: Container())
              .findLaunchPage(context, MessageProvider().getMsg());
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

  // メニューによるスクリーンの定義
  static final _screens = [
    CocologPage(),
    const NewsMainPage(),
  ];

  // 選択されたスクリーン番号
  int _selectedIndex = 0;

  // タップされたアイテム番号を選択スクリーン番号へセット
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 画面ビルド
  // ここではBottomメニューを表示
  // 画面はデフォルトでココログ記事画面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ボディ本体はメニュー選択機能
      body: _screens[_selectedIndex],
      // ボトムのナビゲーションバー
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Theme.of(context).colorScheme.tertiary,
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(
              fontSize: fontSize.menu,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceDim,
          shadowColor: Theme.of(context).colorScheme.primary,
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 52, //NewsPicsベンチマーク値
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(
                Icons.home,
                // color: Theme.of(context).colorScheme.onPrimary,
                size: 24,
              ),
              label: mainMenuHome,
              tooltip: '$cocologTitle1 $cocologTitle2',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.newspaper,
                // color: Theme.of(context).colorScheme.onPrimary,
                size: 24,
              ),
              label: mainMenuNews,
              tooltip: newsFeedTitle,
            ),
          ],
        ),
      ),
    );
  }
}
