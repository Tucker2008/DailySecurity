import 'package:cyber_interigence/util/logo_provider.dart';
import 'package:flutter/material.dart';
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/pages/ipa_page.dart';
import 'package:cyber_interigence/pages/jpcert_page.dart';
import 'package:cyber_interigence/pages/jvn_page.dart';

class NewsMainPage extends StatefulWidget {
  const NewsMainPage({super.key});
  @override
  NewsMainPageState createState() => NewsMainPageState();
}

class NewsMainPageState extends State<NewsMainPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    const Tab(
      text: ipaTabTitle,
    ),
    const Tab(
      text: jvnTabTitle,
    ),
    const Tab(
      text: jpcertTabTitle,
    )
  ];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          // AppBarの大きさ指定
          preferredSize: const Size.fromHeight(appMenuHeight),
          child: AppBar(
            // backgroundColor: Theme.of(context).colorScheme.secondary,
            // foregroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: LogoProvider().getServiceLogo(),
            // TabBar
            bottom: TabBar(
              //          isScrollable: true,
              tabs: tabs,
              controller: _tabController,
              unselectedLabelColor: Theme.of(context).colorScheme.primary,
              indicatorColor: Theme.of(context).colorScheme.tertiary,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2,
              indicatorPadding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
              // メニューの選択項目がボタンの様に浮かび上がる表示設定
              indicator: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    // .onSecondary
                    .tertiary
                    .withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),

              labelColor: Theme.of(context).colorScheme.onTertiary,
              labelStyle: TextStyle(
                  fontSize: fontSize.body2, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        //Todo
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            IpaPage(),
            JvnPage(),
            JpcertPage(),
          ],
        ));
  }
}
