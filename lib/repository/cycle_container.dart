//
// セキュリティリマインダー コンテナ
// トップページにセキュリティリマインダーを表示するコンテナ部品
//
import 'package:cyber_interigence/constant/feed_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/pages/main_screen.dart';
import 'package:cyber_interigence/repository/cycle_manager.dart';
import 'package:cyber_interigence/util/dotted_underline_container.dart';
import 'package:cyber_interigence/util/eardog_container.dart';
import 'package:cyber_interigence/util/screen_provider.dart';
import 'package:cyber_interigence/util/tile_container.dart';
import 'package:flutter/material.dart';

//
// セキュリティリマインダーの１項目表示コンテンツを作る
//
Widget _checkedReminderContainer(
    bool status, String checkTitle, String updateDateString) {
  // 点線下線のContainerにネタを配置する
  return DottedUnderlineContainer(
    padding: const EdgeInsets.only(
      top: 8,
      bottom: 8,
    ),
    borderColor: const Color(4282533710),
    child: Row(
        // チェックボックス
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: status ? 1.0 : 0.2,
            child: const Icon(
              Icons.check_box,
              size: 36.0,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          // 項目名とチェック日
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // チェック項目
              Text(
                checkTitle,
                style: TextStyle(
                    fontSize: fontSize.subTitle1, fontWeight: FontWeight.w600),
              ),
              // フラッグと日付（設定なければ薄く表示）
              Opacity(
                opacity: status ? 1.0 : 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      status ? Icons.flag : Icons.flag_outlined,
                      size: fontSize.subTitle1,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      updateDateString,
                      style: TextStyle(
                          fontSize: fontSize.subTitle1,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
  );
}

//
// 右下の折れたContainer上にセキュリティリマインダーを展開する
//
Widget cycleContainerEardog(BuildContext context) {
  final cycleManger = CycleManager();
  final reminderHeight = sizeConfig.remainderCycleHeight;

  // 内部の表示内容コンテナ
  return eardogContainer(
    context,
    sizeConfig.remainderCycleHeightAdd,
    // 内部の表示内容
    GestureDetector(
      // このColumnをクリックしたら設定画面に行く
      onTap: () {
        // スクリーン番号をセットして
        ScreenProvider().setScreen(cycleScreenNum);
        // ページを呼ぶ
        // このページの呼び方ではスタックしないので行ったきりに出来る
        // Thanks to StackOverflow
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // タイルタイトル
          Text(
            entranceTitleReminder,
            style: TextStyle(
              fontSize: fontSize.headlineH6,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(
            height: 8,
          ),
          // リマインダーが並ぶコンテナ
          // Container(
          SizedBox(
            height: reminderHeight,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _checkedReminderContainer(
                    cycleManger.getWindowsUpdateSate(),
                    reminderWinupdateTitle,
                    cycleManger.getWindowsUpdateDateText()),
                SizedBox(
                  height: 8 * sizeConfig.screenWidthTimes!,
                ),
                _checkedReminderContainer(
                    cycleManger.getPasswordUpdateState(),
                    reminderPassupdateTitle,
                    cycleManger.getPasswordUpdateDateText()),
                SizedBox(
                  height: 8 * sizeConfig.screenWidthTimes!,
                ),
                _checkedReminderContainer(
                    cycleManger.getVirusUpdateSate(),
                    reminderVirusupdateTitle,
                    cycleManger.getVirusUpdateDateText()),
                SizedBox(
                  height: 8 * sizeConfig.screenWidthTimes!,
                ),
                _checkedReminderContainer(cycleManger.getOtherState(),
                    reminderOtherupdateTitle, cycleManger.getOtherDateText()),
                SizedBox(
                  height: 24 * sizeConfig.screenWidthTimes!,
                ),
                // タイル方式でチェックポイントを表示する
                largeTileContainer(
                  //60: 計算してオーバーにならない高さを計算必要
                  // sizeConfig.largeTileContainerHeight,
                  60,
                  double.infinity,
                  Icons.notifications_active,
                  context,
                  null,
                  cycleManger.getScenarioNumberText(),
                  cycleScreenNum,
                  null,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
