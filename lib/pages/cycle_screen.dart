import 'package:cyber_interigence/constant/cycle_scenario.dart';
import 'package:cyber_interigence/constant/cycle_screen_constant.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/repository/cycle_manager.dart';
import 'package:cyber_interigence/theme/size_config.dart';
import 'package:cyber_interigence/util/scenario_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// コンテナ共通定義：クラス共有
// 共通Margin
const baseMargin = EdgeInsets.only(left: 18, right: 8, top: 0, bottom: 8);
// フォント定義
TextStyle baseTextStyle = TextStyle(
  fontSize: fontSize.headlineH6,
  fontWeight: FontWeight.w700,
);
// 各ボックス共通の定義
final boxDecortion = BoxDecoration(
  //  メタル風のデザイン
  //  Thanks to Microsoft Copilot
  gradient: LinearGradient(
    colors: [Colors.grey[400]!, Colors.grey[600]!],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  boxShadow: [
    BoxShadow(
      // Flutter3.7対応 withOpacity(0.5) -> withValues(alphe:0.5) -> withAlpha(255/2 = 128)
      color: Colors.black.withAlpha(128),
      offset: const Offset(4, 4),
      blurRadius: 10,
    ),
    BoxShadow(
      color: Colors.white.withAlpha(180), // withOpacity(0.7),
      offset: const Offset(-4, -4),
      blurRadius: 10,
    ),
  ],
  borderRadius: BorderRadius.circular(12),
);

// WindowsUpdateのコンテナ部分のサイズ定義
double circleFontSize = 24;

//
// セキュリティリマインダー画面
//
//
class CycleScreen extends ConsumerWidget {
  CycleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // フォント定義の原型定義
    baseTextStyle = baseTextStyle.copyWith(
      color: Theme.of(context).colorScheme.onPrimary,
    );
    // フォントサイズをアジャストする
    circleFontSize *= sizeConfig.screenWidthTimes!;

    // BookMarkProviderを定義
    final scenarioProvider =
        StateNotifierProvider<ScenarioNotifier, int>((ref) {
      return ScenarioNotifier();
    });

    ScenarioNotifier scenarioNotifier = ref.read(scenarioProvider.notifier);
    //どの画面をアピールするか？
    // CycleManager().getScenarioPriority() は、ScenarioNotifier初期化時に設定
    ref.watch(scenarioProvider);

    //
    // コンテナ配列の定義
    // ここで並びを決めておいて、BuildでCycleManager().getScenarioPriority()
    // の番号で一気に並びをダイナミックに決める
    //
    // WindowsUpdateが先頭のパターン
    final List<Widget> winStart = [
      // 頭の解説コンテナ実験
      _headerContainer(context),
      // Windows Update
      _winUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
      // Password Update
      _passwordUpdateContainer(
          context, ref, scenarioNotifier, scenarioProvider),
      // Password Update
      _virusUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
      // Password Update
      _otherUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
    ];

    // パスワード更新が先頭のパターン
    final List<Widget> passStart = [
      // 頭の解説コンテナ実験
      _headerContainer(context),
      // Password Update
      _passwordUpdateContainer(
          context, ref, scenarioNotifier, scenarioProvider),
      // Windows Update
      _winUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
      // Password Update
      _virusUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
      // Password Update
      _otherUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
    ];

    // パスワード更新が先頭のパターン
    final List<Widget> virusStart = [
      // 頭の解説コンテナ実験
      _headerContainer(context),
      // Password Update
      _virusUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
      // Windows Update
      _winUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
      // Password Update
      _passwordUpdateContainer(
          context, ref, scenarioNotifier, scenarioProvider),
      // Password Update
      _otherUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
    ];

    // WindowsUpdateが先頭のパターン
    final List<Widget> otherStart = [
      // 頭の解説コンテナ実験
      _headerContainer(context),
      // other Update
      _otherUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
      // Windows Update
      _winUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
      // Password Update
      _passwordUpdateContainer(
          context, ref, scenarioNotifier, scenarioProvider),
      // virus Update
      _virusUpdateContainer(context, ref, scenarioNotifier, scenarioProvider),
    ];

    // 全シナリオパターンの配列を構成して、一気にColumnに食わせる
    final reminderList = [
      winStart,
      passStart,
      virusStart,
      otherStart,
    ];

    // 実際のシナリオ番号（マイナス避け）
    final priorityNum = CycleManager().getScenarioPriority() < 0
        ? 0
        : CycleManager().getScenarioPriority();

    // 画面表示
    return Scaffold(
      // 表示本体
      body: SingleChildScrollView(
        child: Column(
          children: reminderList[priorityNum],
        ),
      ),
    );
  }

  //
  // セキュリティリマインダの説明（先頭部分）
  //
  Widget _headerContainer(BuildContext context) {
    // 頭の解説コンテナ
    return SizedBox(
      width: double.infinity,
      height: SizeConfig().remainderHeaderHeight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: baseMargin,
        width: double.infinity, //ここはデカくしても最大が決まっている
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('images/Entrance_screen_reminder2.png'),
            fit: BoxFit.fill,
            opacity: 0.3, //透明度は常に検討
          ),
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // タイルタイトル
            Text(
              titleSecurityReminder,
              style: baseTextStyle.copyWith(
                fontSize: fontSize.subTitle1,
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                Text(
                  aboutThisAplication,
                  style: baseTextStyle.copyWith(
                    fontSize: fontSize.body2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  //
  // WindowsUpdateのコンテナ部分
  //
  Widget _winUpdateContainer(
      BuildContext context,
      WidgetRef ref,
      ScenarioNotifier scenarioNotifier,
      StateNotifierProvider<ScenarioNotifier, int> scenarioProvider) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig().remainderWinupdateHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: baseMargin,
            width: double.infinity, //ここはデカくしても最大が決まっている
            decoration: boxDecortion,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // タイルタイトル
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      tileTitleWinUpdate,
                      style: baseTextStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "$winupdateSchedule${CycleManager().getLatestUpdate()} \n${CycleManager().getLatestUpdateDurationText()}",
                      style: baseTextStyle.copyWith(
                        fontSize: fontSize.body2,
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
                      "$winupdateDoDate${CycleManager().getWindowsUpdateDateText()}",
                      style: baseTextStyle.copyWith(
                        fontSize: fontSize.body1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: double.infinity,
                  child:
                      (CycleManager().getScenarioNumber() == SCategory.w.index)
                          ? _updateContainer(
                              ref.watch(scenarioProvider),
                              SCategory.w.index,
                              scenarioNotifier,
                            )
                          : SizedBox(
                              child: Text(
                                winupdateDetails,
                                style: baseTextStyle.copyWith(
                                  fontSize: fontSize.body2,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ),
          // 少しずらして円を描いて、フォントアイコンを入れる
          Positioned(
            top: -1 * sizeConfig.tileCircleWidth! * 0.2,
            left: -1 * sizeConfig.tileCircleWidth! * 0.2,
            child: Container(
              width: sizeConfig.tileCircleWidth,
              height: sizeConfig.tileCircleWidth,
              decoration: BoxDecoration(
                color: Colors.grey[300]!,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                radius: (sizeConfig.tileCircleWidth! / 2),
                child: Text(
                  "W",
                  style: TextStyle(
                    fontSize: circleFontSize,
                    color: Colors.grey[100]!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
  // パスワード更新
  //
  Widget _passwordUpdateContainer(
      BuildContext context,
      WidgetRef ref,
      ScenarioNotifier scenarioNotifier,
      StateNotifierProvider<ScenarioNotifier, int> scenarioProvider) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig().remainderPassupdateHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // テキスト表示領域
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: baseMargin,
            width: double.infinity, //ここはデカくしても最大が決まっている
            decoration: boxDecortion,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // タイルタイトル
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      tileTitlePasswordUpdate,
                      style: baseTextStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    Text(
                      "$pwChangeDate${CycleManager().getPasswordUpdateDateText()}",
                      style: baseTextStyle.copyWith(
                        fontSize: fontSize.body1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child:
                      (CycleManager().getScenarioNumber() == SCategory.p.index)
                          ? _updateContainer(
                              ref.watch(scenarioProvider),
                              SCategory.p.index,
                              scenarioNotifier,
                            )
                          : SizedBox(
                              child: Text(
                                passwordUpdateDetails,
                                style: baseTextStyle.copyWith(
                                  fontSize: fontSize.body2,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ),
          // 少しずらして円を描いて、フォントアイコンを入れる
          Positioned(
            top: -1 * sizeConfig.tileCircleWidth! * 0.2,
            left: -1 * sizeConfig.tileCircleWidth! * 0.2,
            child: Container(
              width: sizeConfig.tileCircleWidth,
              height: sizeConfig.tileCircleWidth,
              decoration: BoxDecoration(
                color: Colors.grey[300]!,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                radius: (sizeConfig.tileCircleWidth! / 2),
                child: Text(
                  "P",
                  style: TextStyle(
                    fontSize: circleFontSize,
                    color: Colors.grey[100]!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
  // ウィルスパターンファイル
  //
  Widget _virusUpdateContainer(
      BuildContext context,
      WidgetRef ref,
      ScenarioNotifier scenarioNotifier,
      StateNotifierProvider<ScenarioNotifier, int> scenarioProvider) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig().remainderVirusupdateHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // テキスト表示領域
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: baseMargin,
            width: double.infinity, //ここはデカくしても最大が決まっている
            decoration: boxDecortion,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // タイルタイトル
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      tileTitleVirusUpdate,
                      style: baseTextStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "$virusUpdateDate${CycleManager().getVirusUpdateDateText()}",
                      style: baseTextStyle.copyWith(
                        fontSize: fontSize.body1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child:
                      (CycleManager().getScenarioNumber() == SCategory.v.index)
                          ? _updateContainer(
                              ref.watch(scenarioProvider),
                              SCategory.v.index,
                              scenarioNotifier,
                            )
                          : SizedBox(
                              child: Text(
                                virusUpdateDetails,
                                style: baseTextStyle.copyWith(
                                  fontSize: fontSize.body2,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ),
          // 少しずらして円を描いて、フォントアイコンを入れる
          Positioned(
            top: -1 * sizeConfig.tileCircleWidth! * 0.2,
            left: -1 * sizeConfig.tileCircleWidth! * 0.2,
            child: Container(
              width: sizeConfig.tileCircleWidth,
              height: sizeConfig.tileCircleWidth,
              decoration: BoxDecoration(
                color: Colors.grey[300]!,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                radius: (sizeConfig.tileCircleWidth! / 2),
                child: Text(
                  "V",
                  style: TextStyle(
                    fontSize: circleFontSize,
                    color: Colors.grey[100]!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
  // 他の設定確認
  // その他セキュリティ活動
  //
  Widget _otherUpdateContainer(
      BuildContext context,
      WidgetRef ref,
      ScenarioNotifier scenarioNotifier,
      StateNotifierProvider<ScenarioNotifier, int> scenarioProvider) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig().remainderOtherupdateHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: baseMargin,
            width: double.infinity, //ここはデカくしても最大が決まっている
            decoration: boxDecortion,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // タイルタイトル
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      tileTitleOtherUpdate,
                      style: baseTextStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "$securityUpdateDate${CycleManager().getOtherDateText()}",
                      style: baseTextStyle.copyWith(
                        fontSize: fontSize.body1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 8,
                ),
                // その他の場合は個別のシナリオ番号を渡す
                // 個別シナリオ番号は3以上のその他カテゴリしか渡さない
                // Display番号とシナリオ番号が合ってしまうと違うものが出る
                SizedBox(
                  width: double.infinity,
                  child: (ref.watch(scenarioProvider) > 2)
                      ? _updateContainer(
                          ref.watch(scenarioProvider),
                          CycleManager().getScenarioNumber() > 2
                              ? CycleManager().getScenarioNumber()
                              : (-1),
                          scenarioNotifier,
                        )
                      : SizedBox(
                          child: Text(
                            otherUpdateDetails,
                            style: baseTextStyle.copyWith(
                              fontSize: fontSize.body2,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          // 少しずらして円を描いて、フォントアイコンを入れる
          Positioned(
            top: -1 * sizeConfig.tileCircleWidth! * 0.2,
            left: -1 * sizeConfig.tileCircleWidth! * 0.2,
            child: Container(
              width: sizeConfig.tileCircleWidth,
              height: sizeConfig.tileCircleWidth,
              decoration: BoxDecoration(
                color: Colors.grey[300]!,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                radius: (sizeConfig.tileCircleWidth! / 2),
                child: Text(
                  "他",
                  style: TextStyle(
                    fontSize: circleFontSize,
                    color: Colors.grey[100]!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
  // 共通定義
  final BoxDecoration _updateContainerDecoration = BoxDecoration(
    color: const Color(0xffffd8e4),
    borderRadius: BorderRadius.circular(15),
  );
  //
  // シナリオに基づいて説明と更新を行う
  // サブコーナー的な表示
  // fontColorは 0xff625B71  としておこう
  // buttonは 0xff7D5260 で、文字は White で
  //
  Widget _updateContainer(
      int priority, int scenario, ScenarioNotifier scenarioNotifier) {
    //
    // 表示領域指定がWinUpdate
    //
    if (scenario == SCategory.w.index) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: _updateContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$winupdateMessage$pushButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: fontSize.subTitle2,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            Center(
              // シナリオがwinupの場合にはボタンを表示
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
                      fontSize: fontSize.subTitle2,
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
    else if (scenario == SCategory.p.index) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: _updateContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$passwordUpdateMessage$pushButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: fontSize.subTitle2,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 8,
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
                      fontSize: fontSize.subTitle2,
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
    else if (scenario == SCategory.v.index) {
      // 小画面
      return Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: _updateContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$virusUpdateMessage$pushButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: fontSize.subTitle2,
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
                      fontSize: fontSize.subTitle2,
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
    else if (scenario == SCategory.d.index) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: _updateContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$dataBackupMessage$awakeButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: fontSize.subTitle2,
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
                      fontSize: fontSize.subTitle2,
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
    else if (scenario == SCategory.m.index) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: _updateContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$fishingMessage$awakeButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: fontSize.subTitle2,
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
                      fontSize: fontSize.subTitle2,
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
    else if (scenario == SCategory.i.index) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: _updateContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$infomationMessage$awakeButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: fontSize.subTitle2,
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
                      fontSize: fontSize.subTitle2,
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
    else if (scenario == SCategory.s.index) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: _updateContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$screenLockMessage$awakeButtonMessage",
              style: TextStyle(
                  color: const Color(0xff625B71),
                  fontSize: fontSize.subTitle2,
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
                      fontSize: fontSize.caption,
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
