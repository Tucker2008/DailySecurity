import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/pages/bookmark_page.dart';
import 'package:cyber_interigence/pages/cocolog_page.dart';
import 'package:cyber_interigence/pages/cycle_screen.dart';
import 'package:cyber_interigence/pages/news_main_page.dart';
import 'package:cyber_interigence/pages/setting_screen.dart';
import 'package:cyber_interigence/pages/entrance_screen.dart';
import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:cyber_interigence/util/post_category.dart';
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
    EntranceScreen(),
    CocologPage(argCategory: columnCategory),
    CycleScreen(),
    NewsMainPage(
      arg: false,
    ),
    BookmarkPage(),
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
      appBar: AppbarConstant().getAppbarConstant(),
      // 設定ページはDrawerへ格納
      drawer: settingsDrawer(context),
      // ボディ本体はメニュー選択機能
      body: _screens[_selectedIndex],

      // ボトムのナビゲーションバー(関数分離は無理)
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Theme.of(context).colorScheme.tertiary,
          backgroundColor:
              Theme.of(context).colorScheme.surfaceBright, //surfaceDim,
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(
              fontSize: fontSize.menu,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          // これが中央アイコンとのバランスが良い反転方法
          indicatorShape: const CircleBorder(),
        ),
        child: NavigationBar(
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: sizeConfig.mainMenuHeight,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: <NavigationDestination>[
            NavigationDestination(
              icon: CircleAvatar(
                radius: sizeConfig.mainMenuIconRadius,
                backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                child: Icon(
                  Icons.home_outlined,
                  size: sizeConfig.mainMenuIconSize,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              label: mainMenuHome,
              tooltip: '$cocologTitle1 $cocologTitle2',
              selectedIcon: CircleAvatar(
                radius: sizeConfig.mainMenuSelectedIconRadius,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: Icon(
                  Icons.home_outlined,
                  size: sizeConfig.mainMenuIconSize,
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
              ),
            ),
            NavigationDestination(
              icon: CircleAvatar(
                radius: sizeConfig.mainMenuIconRadius,
                backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                child: Icon(
                  Icons.article_outlined,
                  size: sizeConfig.mainMenuIconSize,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              label: mainMenuArticle,
              tooltip: newsArticleTitle,
              selectedIcon: CircleAvatar(
                radius: sizeConfig.mainMenuSelectedIconRadius,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: Icon(
                  Icons.article_outlined,
                  size: sizeConfig.mainMenuIconSize,
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
              ),
            ),
            NavigationDestination(
              icon: CircleAvatar(
                radius: sizeConfig.mainMenuIconRadius + 2,
                child: CircleAvatar(
                  radius: sizeConfig.mainMenuIconRadius,
                  backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                  child: Icon(
                    Icons.calendar_month,
                    size: sizeConfig.mainMenuIconSize,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              selectedIcon: CircleAvatar(
                radius: sizeConfig.mainMenuSelectedIconRadius,
                child: CircleAvatar(
                  radius: sizeConfig.mainMenuSelectedIconRadius - 2,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  child: Icon(
                    Icons.calendar_month,
                    size: sizeConfig.mainMenuIconSize,
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceBright, //surfaceDim,
                  ),
                ),
              ),
              label: mainMenuReminder,
              tooltip: reminderTitle,
            ),
            NavigationDestination(
              icon: CircleAvatar(
                radius: sizeConfig.mainMenuIconRadius,
                backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                child: Icon(
                  Icons.newspaper,
                  size: sizeConfig.mainMenuIconSize,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              label: mainMenuNews,
              tooltip: newsFeedTitle,
              selectedIcon: CircleAvatar(
                radius: sizeConfig.mainMenuSelectedIconRadius,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: Icon(
                  Icons.newspaper,
                  size: sizeConfig.mainMenuIconSize,
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
              ),
            ),
            NavigationDestination(
              icon: CircleAvatar(
                radius: sizeConfig.mainMenuIconRadius,
                backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                child: Icon(
                  Icons.bookmark_outline,
                  size: sizeConfig.mainMenuIconSize,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              label: mainMenuBookmark,
              tooltip: bookmarkTitle,
              selectedIcon: CircleAvatar(
                radius: sizeConfig.mainMenuSelectedIconRadius,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: Icon(
                  Icons.bookmark_outline,
                  size: sizeConfig.mainMenuIconSize,
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
