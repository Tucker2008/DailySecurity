import 'package:cyber_interigence/constant/settings_constant.dart';
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/pages/notification_profile.dart';
import 'package:cyber_interigence/repository/launch_url.dart';
import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  /// 表示用のアプリバージョンテキストを返却します。
  Future<String> getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var text = '$versionText${packageInfo.version}(${packageInfo.buildNumber})';
    return text;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // AppBar ロゴを表示するだけ ----------------
      appBar: AppbarConstant().getAppbarConstant(),

      // その他情報など表示
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ヘッダ
          Row(
            children: [
              SizedBox(
                width: fontSize.body1,
              ),
              Text(
                settingTitle,
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
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
                    top: BorderSide(
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
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
          SizedBox(
            height: fontSize.body1 * 3,
          ),
          // アプリ情報
          Row(
            children: [
              SizedBox(
                width: fontSize.body1,
              ),
              Text(
                aplTitle,
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
              SizedBox(
                width: fontSize.body1,
              ),
              Text(
                versionTitle,
                style: TextStyle(
                  fontSize: fontSize.body1,
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
              SizedBox(
                width: fontSize.body1,
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
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => info.widgetPage!,
        ),
      );
    }
  }
}

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

// 設定情報一覧の実態
List<SettingInfo> settingInfoList = [
  SettingInfo(
    title: pushNotificationTitle,
    link: "",
    widgetPage: NotificationProfile(),
  ),
  SettingInfo(
    title: privercyTitle,
    link: privercyPage,
    widgetPage: null,
  ),
  SettingInfo(
    title: termOfUseTitle,
    link: termofusePage,
    widgetPage: null,
  ),
];
