import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/pages/notification_profile.dart';
import 'package:cyber_interigence/repository/launch_url.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/repository/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

//
// アプリ情報及び（通知）設定
// 元々は画面で作成→Drawerに変換
//
// class SettingScreen extends ConsumerWidget {
//   const SettingScreen({super.key});

/// 表示用のアプリバージョンテキストを返却します。
Future<String> getVersionInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  var text =
      '$settingsVerTitle:${packageInfo.version}(${packageInfo.buildNumber})';
  return text;
}

// 元々は画面で作成→Drawerに変換
//
// @override
// Widget build(BuildContext context, WidgetRef ref) {
//   return Scaffold(
// body: Column(
Drawer settingsDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ヘッダ
        const SizedBox(
          height: 80,
        ),
        // メニュータイトル
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Text(
              settingsTitle,
              style: TextStyle(
                  fontSize: fontSize.body1, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        //
        // 一覧の表示
        //
        ListView.builder(
          itemCount: settingInfoList.length,

          scrollDirection: Axis.vertical, // スクロール方向を垂直に設定
          reverse: false, // 順序を逆にしない
          // リスト全体に8ピクセルの余白を追加
          // padding: const EdgeInsets.all(8.0),
          primary: true, // このリストがプライマリスクロールビューかどうかを指定

          // 以下の2つの設定はSingleScrollView内でListViewを使う場合に必要
          // shrinkWrap: false, // リストの高さをその内容に基づいて調整しない
          // physics: const BouncingScrollPhysics(), // スクロール挙動を指定
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          addAutomaticKeepAlives: true, // 各アイテムが自動的に保持されるかどうかを指定
          addRepaintBoundaries: true, // 各アイテムが再描画境界を持つかどうかを指定
          addSemanticIndexes: true, // 各アイテムがセマンティックインデックスを持つかどうかを指定

          itemBuilder: (context, index) {
            return Container(
              // margin: const EdgeInsets.symmetric(vertical: 1), // 4
              // 背景色と区切り線を定義
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                // 上下のみに薄い線を入れる
                border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  top: BorderSide(
                      color: Theme.of(context).colorScheme.secondaryContainer),
                ),
              ),
              child: ListTile(
                title: Text(
                  settingInfoList[index].title,
                  // 長いタイトルを省略表示
                  // overflow: TextOverflow.ellipsis,を行数を指定して使うとちょうどいい
                  overflow: TextOverflow.ellipsis,
                  maxLines: titleLineMax,
                ),
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize.body1,
                  color: Theme.of(context).colorScheme.onSurface,
                  // 行間を少し狭く
                  height: 1.2,
                ),
                onTap: () => {_launchURL(context, settingInfoList[index])},
                // textColor: Theme.of(context).colorScheme.onSurface,

                // 右のリンクアイコン
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: fontSize.body1,
                ),
              ),
            );
          },
        ),
        //
        const SizedBox(
          height: 48,
        ),
        // アプリ情報
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Text(
              settingsAplTitle,
              style: TextStyle(
                  fontSize: fontSize.body1, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        // 区切り線
        Divider(
          height: 1,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Theme.of(context).colorScheme.primary,
        ),
        // アプリバージョン
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Text(
              settingsVerTitle,
              style: TextStyle(
                fontSize: fontSize.body2,
              ),
            ),
            const Spacer(),
            // アプリのバージョンを取得して表示
            FutureBuilder<String>(
              future: getVersionInfo(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text(
                  snapshot.hasData ? snapshot.data : '',
                  style: TextStyle(
                    fontSize: fontSize.body1,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        // 区切り線
        Divider(
          height: 1,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Theme.of(context).colorScheme.primary,
        ),
        // 隠しボタン
        const SizedBox(
          height: 32,
        ),
        GestureDetector(
          onTap: () {
            PreferenceManager().debugPrintState();
          },
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Text(
                "DebugSwitch",
                style: TextStyle(
                  fontSize: fontSize.body1,
                  color: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? Colors.grey[200]
                      : Colors.black, // 200だとわからない
                ),
              ),
            ],
          ),
        ),
        // 隠しボタン2 ダミーメッセージ
        const SizedBox(
          height: 32,
        ),
        GestureDetector(
          onTap: () {
            PushNotificationService().debugMessageProc();
          },
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Text(
                "DebugMessage",
                style: TextStyle(
                  fontSize: fontSize.body1,
                  color: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? Colors.grey[200]
                      : Colors.black, // 200だとわからない
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

// 次のページへ
void _launchURL(BuildContext context, SettingInfo info) {
  // URLが指定されている場合
  if (info.widgetPage == null) {
    launchURL(context, info.link!);
  }
  // ページが呼ばれている
  else {
    // debugPrint("launchURL  widget");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => info.widgetPage!,
      ),
    );
  }
}
// }

// 設定情報の一覧用
class SettingInfo {
  String title;
  String? link;
  Widget? widgetPage;
  SettingInfo({
    required this.title,
    required this.link,
    required this.widgetPage,
  });
}

// 設定情報一覧の実態 constantにいれる
List<SettingInfo> settingInfoList = [
  SettingInfo(
    title: settingsNotificationTitle,
    link: "",
    widgetPage: NotificationProfile(),
  ),
  SettingInfo(
    title: settingsPrivercyTitle,
    link: privercyPage,
    widgetPage: null,
  ),
  SettingInfo(
    title: settingsTermosuseTitle,
    link: termofusePage,
    widgetPage: null,
  ),
];
