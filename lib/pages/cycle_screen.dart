import 'package:cyber_interigence/constant/cycle_scenario.dart';
import 'package:cyber_interigence/constant/cycle_screen_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/repository/cycle_manager.dart';
import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:cyber_interigence/util/scenario_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CycleScreen extends ConsumerWidget {
  final bool appbar;
  const CycleScreen({super.key, required this.appbar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 各ボックス共通の定義
    final boxDecortion = BoxDecoration(
      borderRadius: BorderRadius.circular(15), //角を丸める
      boxShadow: const [
        BoxShadow(
          color: Colors.grey, //色
          spreadRadius: 3, //影の幅
          blurRadius: 10, //影のぼやけ（小さいと濃い）
          offset: Offset(5, 5), //光の当たる角度5:5は左上
        ),
      ],
    );
    // フォーカスによって大きさを変えるための変数群
    const largeMargin = EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 4);
    const smallMargin = EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 4);
    final largeColor = Theme.of(context).colorScheme.tertiaryFixedDim;
    final smallColor = Theme.of(context).colorScheme.secondary;
    final largeOnColor = Theme.of(context).colorScheme.onTertiaryFixed;
    final smallOnColor = Theme.of(context).colorScheme.onSecondary;

    // CycleManagerインスタンスを生成
    final cycleManager = CycleManager();

    // BookMarkProviderを定義
    final scenarioProvider =
        StateNotifierProvider<ScenarioNotifier, int>((ref) {
      return ScenarioNotifier();
    });

    ScenarioNotifier scenarioNotifier = ref.read(scenarioProvider.notifier);
    //どの画面をアピールするか？
    // CycleManager().getScenarioPriority() は、ScenarioNotifier初期化時に設定
    ref.watch(scenarioProvider);

    // 画面表示
    return Scaffold(
      appBar: appbar ? AppbarConstant().getAppbarConstant() : null,
      body: SafeArea(
        child: Column(
          children: [
            // WindowsUpdate
            Expanded(
              // 比率指定
              flex: (ref.watch(scenarioProvider) == 0) ? 15 : 6, //5:2 *3
              // child: GestureDetector(     将来的に解説入れるならこれ
              child: SizedBox(
                // タップ処理
                // onTap: () {
                //   debugPrint("WindowsUpdate onTap"); ここで解説ページ
                // },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: (ref.watch(scenarioProvider) == 0)
                      ? largeMargin
                      : smallMargin,
                  width: double.infinity, //ここはデカくしても最大が決まっている
                  decoration: boxDecortion.copyWith(
                    color: (ref.watch(scenarioProvider) == 0)
                        ? largeColor
                        : smallColor,
                    image: const DecorationImage(
                      image: AssetImage('images/scenario_winUpdate.png'),
                      fit: BoxFit.fill,
                      opacity: 0.3, //透明度は常に検討
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // タイルタイトル
                      Text(
                        tileTitleWinUpdate,
                        style: TextStyle(
                          fontSize: fontSize.body1,
                          fontWeight: FontWeight.w700,
                          color: (ref.watch(scenarioProvider) == 0)
                              ? largeOnColor
                              : smallOnColor,
                        ),
                      ),
                      SizedBox(
                        height: (ref.watch(scenarioProvider) == 0) ? 16 : 0,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "$winupdateSchedule${cycleManager.getLatestUpdate()} \n${cycleManager.getLatestUpdateDurationText()}",
                            style: TextStyle(
                              fontSize: fontSize.body2,
                              fontWeight: FontWeight.w700,
                              color: (ref.watch(scenarioProvider) == 0)
                                  ? largeOnColor
                                  : smallOnColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "$winupdateDoDate${cycleManager.getWindowsUpdateDateText()}",
                            style: TextStyle(
                              fontSize: fontSize.body2,
                              fontWeight: FontWeight.w700,
                              color: (ref.watch(scenarioProvider) == 0)
                                  ? largeOnColor
                                  : smallOnColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: (ref.watch(scenarioProvider) == 0) ? 16 : 4,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: _updateContainer(
                          ref.watch(scenarioProvider),
                          SCategory.w.index,
                          scenarioNotifier,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // パスワード更新
            Expanded(
              // 比率指定
              flex: (ref.watch(scenarioProvider) == 1) ? 12 : 5, //4:2 *3
              child: SizedBox(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: (ref.watch(scenarioProvider) == 1)
                      ? largeMargin
                      : smallMargin,
                  width: double.infinity, //ここはデカくしても最大が決まっている
                  decoration: boxDecortion.copyWith(
                    color: (ref.watch(scenarioProvider) == 1)
                        ? largeColor
                        : smallColor,
                    image: const DecorationImage(
                      image: AssetImage('images/scenario_passwordUpdate.png'),
                      fit: BoxFit.fill,
                      opacity: 0.3, //透明度は常に検討
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // タイルタイトル
                      Text(
                        tileTitlePasswordUpdate,
                        style: TextStyle(
                          fontSize: fontSize.body1,
                          fontWeight: FontWeight.w700,
                          color: (ref.watch(scenarioProvider) == 1)
                              ? largeOnColor
                              : smallOnColor,
                        ),
                      ),
                      SizedBox(
                        height: (ref.watch(scenarioProvider) == 1) ? 4 : 16,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 24,
                          ),
                          Text(
                            "$pwChangeDate${cycleManager.getPasswordUpdateDateText()}",
                            style: TextStyle(
                              fontSize: fontSize.body2,
                              fontWeight: FontWeight.w700,
                              color: (ref.watch(scenarioProvider) == 1)
                                  ? largeOnColor
                                  : smallOnColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: _updateContainer(
                          ref.watch(scenarioProvider),
                          SCategory.p.index,
                          scenarioNotifier,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ウィルスパターンファイル
            Expanded(
              // 比率指定
              flex: (ref.watch(scenarioProvider) == 2) ? 12 : 5, //4:2 *3
              child: SizedBox(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: (ref.watch(scenarioProvider) == 2)
                      ? largeMargin
                      : smallMargin,
                  width: double.infinity, //ここはデカくしても最大が決まっている
                  decoration: boxDecortion.copyWith(
                    color: (ref.watch(scenarioProvider) == 2)
                        ? largeColor
                        : smallColor,
                    image: const DecorationImage(
                      image: AssetImage('images/scenario_virusUpdate.png'),
                      fit: BoxFit.fill,
                      opacity: 0.3, //透明度は常に検討
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // タイルタイトル
                      Text(
                        tileTitleVirusUpdate,
                        style: TextStyle(
                          fontSize: fontSize.body1,
                          fontWeight: FontWeight.w700,
                          color: (ref.watch(scenarioProvider) == 2)
                              ? largeOnColor
                              : smallOnColor,
                        ),
                      ),
                      SizedBox(
                        height: (ref.watch(scenarioProvider) == 2) ? 4 : 16,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "$virusUpdateDate${cycleManager.getVirusUpdateDateText()}",
                            style: TextStyle(
                              fontSize: fontSize.body2,
                              fontWeight: FontWeight.w700,
                              color: (ref.watch(scenarioProvider) == 2)
                                  ? largeOnColor
                                  : smallOnColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: _updateContainer(
                          ref.watch(scenarioProvider),
                          SCategory.v.index,
                          scenarioNotifier,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // その他セキュリティ活動
            Expanded(
              // 比率指定
              flex: (ref.watch(scenarioProvider) == 3) ? 12 : 5, //4:2 *3
              child: SizedBox(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: (ref.watch(scenarioProvider) == 3)
                      ? largeMargin
                      : smallMargin,
                  width: double.infinity, //ここはデカくしても最大が決まっている
                  decoration: boxDecortion.copyWith(
                    color: (ref.watch(scenarioProvider) == 3)
                        ? largeColor
                        : smallColor,
                    image: const DecorationImage(
                      image: AssetImage('images/scenario_securityUpdate.png'),
                      fit: BoxFit.fill,
                      opacity: 0.3, //透明度は常に検討
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // タイルタイトル
                      Text(
                        tileTitleOtherUpdate,
                        style: TextStyle(
                          fontSize: fontSize.body1,
                          fontWeight: FontWeight.w700,
                          color: (ref.watch(scenarioProvider) == 3)
                              ? largeOnColor
                              : smallOnColor,
                        ),
                      ),
                      SizedBox(
                        height: (ref.watch(scenarioProvider) == 3) ? 4 : 16,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "$securityUpdateDate${cycleManager.getOtherDateText()}",
                            style: TextStyle(
                              fontSize: fontSize.body2,
                              fontWeight: FontWeight.w700,
                              color: (ref.watch(scenarioProvider) == 3)
                                  ? largeOnColor
                                  : smallOnColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                      // その他の場合は個別のシナリオ番号を渡す
                      // 個別シナリオ番号は3以上のその他カテゴリしか渡さない
                      // Display番号とシナリオ番号が合ってしまうと違うものが出る
                      SizedBox(
                        width: double.infinity,
                        child: _updateContainer(
                          ref.watch(scenarioProvider),
                          CycleManager().getScenarioNumber() > 2
                              ? CycleManager().getScenarioNumber()
                              : (-1),
                          scenarioNotifier,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  // シナリオに基づいて説明と更新を行う
  // サブコーナー的な表示
  //
  Widget _updateContainer(
      int priority, int scenario, ScenarioNotifier scenarioNotifier) {
    //
    // 表示領域指定がWinUpdateで、シナリオもwinup
    //
    if ((priority == 0) && (scenario == SCategory.w.index)) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        // height: double.infinity,
        width: double.infinity, //ここはデカくしても最大が決まっている
        decoration: BoxDecoration(
          color: const Color(0xffffd8e4),
          borderRadius: BorderRadius.circular(15), //角を丸める
        ),
        // fontColorは 0xff625B71  としておこう
        // buttonは 0xff7D5260 で、文字は White でいいや
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$winupdateMessage$pushButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7D5260),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  scenarioNotifier.flipScenarioDone(SCategory.w.index);
                },
                child: Text(
                  buttonUpdateDoing,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      );
    }
    //
    // 表示領域指定がPasswordUpdateで、シナリオもPasswordUpdate
    //
    else if ((priority == 1) && (scenario == SCategory.p.index)) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        // height: double.infinity,
        width: double.infinity, //ここはデカくしても最大が決まっている
        decoration: BoxDecoration(
          color: const Color(0xffffd8e4),
          borderRadius: BorderRadius.circular(15), //角を丸める
        ),
        // fontColorは 0xff625B71  としておこう
        // buttonは 0xff7D5260 で、文字は White でいいや
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$passwordUpdateMessage$pushButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7D5260),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  scenarioNotifier.flipScenarioDone(SCategory.p.index);
                },
                child: Text(
                  buttonUpdateDoing,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
          ],
        ),
      );
    }
    //
    // 表示領域指定がウィルス更新で、シナリオもウィルス更新
    //
    else if ((priority == 2) && (scenario == SCategory.v.index)) {
      // 小画面
      return Container(
        padding: const EdgeInsets.all(8.0),
        // height: double.infinity,
        width: double.infinity, //ここはデカくしても最大が決まっている
        decoration: BoxDecoration(
          color: const Color(0xffffd8e4),
          borderRadius: BorderRadius.circular(15), //角を丸める
        ),
        // fontColorは 0xff625B71  としておこう
        // buttonは 0xff7D5260 で、文字は White でいいや
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$virusUpdateMessage$pushButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7D5260),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  scenarioNotifier.flipScenarioDone(SCategory.v.index);
                },
                child: Text(
                  buttonUpdateDoing,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      );
    }
    //
    // 表示領域指定がその他ので、シナリオがバックアップ実施の場合
    //
    else if ((priority == 3) && (scenario == SCategory.d.index)) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        // height: double.infinity,
        width: double.infinity, //ここはデカくしても最大が決まっている
        decoration: BoxDecoration(
          color: const Color(0xffffd8e4),
          borderRadius: BorderRadius.circular(15), //角を丸める
        ),
        // fontColorは 0xff625B71  としておこう
        // buttonは 0xff7D5260 で、文字は White でいいや
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$dataBackupMessage$awakeButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7D5260),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  scenarioNotifier.flipScenarioDone(SCategory.d.index);
                },
                child: Text(
                  assertUpdateDoing,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      );
    }
    //
    // 表示領域指定がその他で、シナリオがフィッシングの場合
    //
    else if ((priority == 3) && (scenario == SCategory.m.index)) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        // height: double.infinity,
        width: double.infinity, //ここはデカくしても最大が決まっている
        decoration: BoxDecoration(
          color: const Color(0xffffd8e4),
          borderRadius: BorderRadius.circular(15), //角を丸める
        ),
        // fontColorは 0xff625B71  としておこう
        // buttonは 0xff7D5260 で、文字は White でいいや
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$fishingMessage$awakeButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7D5260),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  scenarioNotifier.flipScenarioDone(SCategory.d.index);
                },
                child: Text(
                  assertUpdateDoing,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
          ],
        ),
      );
    }
    //
    // 表示領域指定がその他で、シナリオがデータ持ち出しの場合
    //
    else if ((priority == 3) && (scenario == SCategory.i.index)) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        // height: double.infinity,
        width: double.infinity, //ここはデカくしても最大が決まっている
        decoration: BoxDecoration(
          color: const Color(0xffffd8e4),
          borderRadius: BorderRadius.circular(15), //角を丸める
        ),
        // fontColorは 0xff625B71  としておこう
        // buttonは 0xff7D5260 で、文字は White でいいや
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$infomationMessage$awakeButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7D5260),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  scenarioNotifier.flipScenarioDone(SCategory.i.index);
                },
                child: Text(
                  assertUpdateDoing,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      );
    }
    //
    // 表示領域指定がその他で、シナリオがスクリーンロックの場合
    //
    else if ((priority == 3) && (scenario == SCategory.s.index)) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        // height: double.infinity,
        width: double.infinity, //ここはデカくしても最大が決まっている
        decoration: BoxDecoration(
          color: const Color(0xffffd8e4),
          borderRadius: BorderRadius.circular(15), //角を丸める
        ),
        // fontColorは 0xff625B71  としておこう
        // buttonは 0xff7D5260 で、文字は White でいいや
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$screenLockMessage$awakeButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: 14.0 * (sizeConfig.screenWidthTimes!),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7D5260),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  scenarioNotifier.flipScenarioDone(SCategory.s.index);
                },
                child: Text(
                  assertUpdateDoing,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0 * (sizeConfig.screenWidthTimes!),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
      );
    }
    //
    // 該当なければスペースを返して終了
    //
    else {
      return const SizedBox(
        height: 4,
      );
    }
  }
}
