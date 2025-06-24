import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/pages/cocolog_page.dart';
import 'package:cyber_interigence/pages/cycle_screen.dart';
import 'package:cyber_interigence/pages/foreign_news_page.dart';
import 'package:cyber_interigence/pages/setting_screen.dart';
import 'package:cyber_interigence/pages/entrance_screen.dart';
import 'package:cyber_interigence/pages/news_main_page.dart';
import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:cyber_interigence/util/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  // メニューによるスクリーンの定義
  // 注意：この配列順は screen_provider.dart と番号が連携している
  static final _screens = [
    const EntranceScreen(),
    CocologPage(
      argCategory: "column",
    ),
    CycleScreen(),
    NewsMainPage(
      arg: false,
    ),
    ForeignNewsPage(),
  ];

  // 選択されたスクリーン番号
  int _selectedIndex = ScreenProvider().getScreen();

  // タップされたアイテム番号を選択スクリーン番号へセット
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      ScreenProvider().resetScreen();
    });
  }

  // 画面ビルド
  // ここではBottomメニューを表示
  // 画面はデフォルトでココログ記事画面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar ロゴを表示するだけ ----------------
      appBar: AppbarConstant().getAppbarConstant(context),
      // 設定ページはDrawerへ格納
      drawer: settingsDrawer(context),
      // ボディ本体はメニュー選択機能
      body: _screens[_selectedIndex],

      // ボトムのナビゲーションバー
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Theme.of(context).colorScheme.tertiary,
          backgroundColor: Theme.of(context).colorScheme.surfaceDim,
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(
              fontSize: fontSize.menu,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
// これが中央アイコンとのバランスが良い反転方法
          indicatorShape: const CircleBorder(),
// ------
        ),
        child: NavigationBar(
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 52, //NewsPicsベンチマーク値
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: <NavigationDestination>[
            // ホーム（EntranceScreen）
            NavigationDestination(
              icon: Icon(
                Icons.home,
                size: sizeConfig.mainMenuIconSize,
              ),
              label: mainMenuHome,
              tooltip: '$cocologTitle1 $cocologTitle2',
            ),
            // ココログ Column (cocologPage)
            NavigationDestination(
              icon: Icon(
                Icons.article_outlined,
                size: sizeConfig.mainMenuIconSize,
              ),
              label: mainMenuArticle,
              tooltip: newsArticleTitle,
            ),
            // セキュリティリマインダー(CycleScreen)
            NavigationDestination(
              icon: CircleAvatar(
                radius: sizeConfig.mainMenuCircleIconRadius,
                child: CircleAvatar(
                  radius: sizeConfig.mainMenuCircleInnerIconRadius,
                  backgroundColor: Theme.of(context).colorScheme.surfaceDim,
                  child: Icon(
                    Icons.calendar_month,
                    size: sizeConfig.mainMenuIconSize,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              selectedIcon: CircleAvatar(
                radius: sizeConfig.mainMenuCircleIconRadius,
                child: CircleAvatar(
                  radius: sizeConfig.mainMenuCircleInnerIconRadius,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  child: Icon(
                    Icons.calendar_month,
                    size: sizeConfig.mainMenuIconSize,
                    color: Theme.of(context).colorScheme.surfaceDim,
                  ),
                ),
              ),
              label: mainMenuReminder,
              tooltip: reminderTitle,
            ),
            // ニュース (newsMain)
            NavigationDestination(
              icon: Icon(
                Icons.newspaper,
                size: sizeConfig.mainMenuIconSize,
              ),
              label: mainMenuNews,
              tooltip: newsFeedTitle,
            ),
            // 海外ニュースページ (2025.4.17)
            // アイコンをtravel_exploreに変更
            NavigationDestination(
              icon: Icon(
                Icons.travel_explore_outlined,
                size: sizeConfig.mainMenuIconSize,
              ),
              selectedIcon: Icon(
                Icons.travel_explore,
                size: sizeConfig.mainMenuIconSize,
              ),
              label: mainMenuForignNews,
              tooltip: forignNewsTitle,
            ),
          ],
        ),
      ),
    );
  }
}
