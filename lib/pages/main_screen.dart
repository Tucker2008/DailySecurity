import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/pages/bookmark_page.dart';
import 'package:cyber_interigence/pages/entrance_screen.dart';
import 'package:cyber_interigence/pages/news_main_page.dart';
import 'package:cyber_interigence/pages/setting_screen.dart';
import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/pages/cycle_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  // メニューによるスクリーンの定義
  static final _screens = [
    EntranceScreen(),
    NewsMainPage(
      arg: false,
    ),
    const CycleScreen(appbar: false),
    BookmarkPage(),
    const SettingScreen(),
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
      // AppBar ロゴを表示するだけ ----------------
      appBar: AppbarConstant().getAppbarConstant(),

      // ボディ本体はメニュー選択機能
      body: _screens[_selectedIndex],
      // ボトムのナビゲーションバー
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Theme.of(context).colorScheme.tertiary,
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(
              fontSize: fontSize.menu * (sizeConfig.screenWidthTimes!),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          // これが中央アイコンとのバランスが良い反転方法
          indicatorShape: const CircleBorder(),
          // ------
        ),
        child: NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceDim,
          shadowColor: Theme.of(context).colorScheme.primary,
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 52 * (sizeConfig.screenWidthTimes!), //NewsPicsベンチマーク値
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: <NavigationDestination>[
            NavigationDestination(
              icon: Icon(
                Icons.home,
                size: 24 * (sizeConfig.screenWidthTimes!),
              ),
              label: mainMenuHome,
              tooltip: '$cocologTitle1 $cocologTitle2',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.newspaper,
                size: 24 * (sizeConfig.screenWidthTimes!),
              ),
              label: mainMenuNews,
              tooltip: newsFeedTitle,
            ),
            NavigationDestination(
              icon: CircleAvatar(
                radius: 22 * (sizeConfig.screenWidthTimes!),
                child: CircleAvatar(
                  radius: 20 * (sizeConfig.screenWidthTimes!),
                  backgroundColor: Theme.of(context).colorScheme.surfaceDim,
                  child: Icon(
                    Icons.calendar_month,
                    size: 24 * (sizeConfig.screenWidthTimes!),
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              selectedIcon: CircleAvatar(
                radius: 22 * (sizeConfig.screenWidthTimes!),
                child: CircleAvatar(
                  radius: 20 * (sizeConfig.screenWidthTimes!),
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  child: Icon(
                    Icons.calendar_month,
                    size: 24 * (sizeConfig.screenWidthTimes!),
                    color: Theme.of(context).colorScheme.surfaceDim,
                  ),
                ),
              ),
              label: mainMenuRiminder,
              tooltip: entranceTitleReminder,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.bookmark,
                size: 24 * (sizeConfig.screenWidthTimes!),
                color: Theme.of(context).colorScheme.tertiary,
              ),
              label: mainMenuBookmark,
              tooltip: bookmarkTitle,
              // 何故かここは指定しないと反転しない
              selectedIcon: Icon(
                Icons.bookmark,
                size: 24 * (sizeConfig.screenWidthTimes!),
                color: Theme.of(context).colorScheme.surfaceDim,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings,
                size: 24 * (sizeConfig.screenWidthTimes!),
                color: Theme.of(context).colorScheme.tertiary,
              ),
              label: mainMenuSetting,
              tooltip: newsSettingTitle,
              // 何故かここは指定しないと反転しない
              selectedIcon: Icon(
                Icons.settings,
                size: 24 * (sizeConfig.screenWidthTimes!),
                color: Theme.of(context).colorScheme.surfaceDim,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
