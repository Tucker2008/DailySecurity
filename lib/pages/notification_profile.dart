import 'package:cyber_interigence/constant/notifification_constant.dart';
import 'package:cyber_interigence/repository/initial_preference.dart';
import 'package:cyber_interigence/repository/preference_manager.dart';
import 'package:cyber_interigence/repository/push_notification_service.dart';
import 'package:cyber_interigence/theme/appbar_constant.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber_interigence/global.dart';
import 'package:cyber_interigence/model/preference.dart';

// この画面はアカウント登録していると、Microsoft他のアップデート情報が
// 忘れないようにNotification発信されるといった案内ページを置いて、登録・削除の設定
// をする

class NotificationProfile extends ConsumerWidget {
  NotificationProfile({super.key});

  final profSwitchProvider =
      StateNotifierProvider<ProfSwitchNotifier, Preference>((ref) {
    return ProfSwitchNotifier();
  });

  final initialPrefernce = InitialPreference();
  final notificationService = PushNotificationService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 設定データの初期化
    final statusFlg = ref.watch(profSwitchProvider);
    final switchNotifier = ref.read(profSwitchProvider.notifier);

    return Scaffold(
      appBar: AppbarConstant().getAppbarConstant(context),

      // 本体設定画面
      body: Container(
        alignment: Alignment.topLeft,
        // 画面全体の縦幅設定
        height: double.infinity,

        // 内部２枚のコンテナをまとめるコンテナ
        child: Container(
          // padding と 横幅の設定
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,

          // 内部２枚のコンテナを並べるColumn
          child: Column(
            children: [
              // ２枚めの通知設定
              Container(
                decoration: BoxDecoration(
                  // ↓ダミーの設定
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 横線を引く
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // ノーティフィケーション設定タイトル
                    Text(
                      notificationTitle,
                      style: TextStyle(
                          fontSize: fontSize.headlineH6,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // イメージを入れる
                    Center(
                      child: Image.asset(
                        notificationImagePath,
                        width: 300,
                      ),
                    ),
                    // 通知設定の案内テキスト
                    Text(
                      notificationMessage,
                      style: TextStyle(
                        fontSize: fontSize.body1,
                      ),
                    ),
                    SizedBox(
                      height: fontSize.headlineH7,
                    ),
                    // 切り替えスイッチ
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center, // 縦の配置
                      children: [
                        Text(
                          notificationSwitchMsg,
                          style: TextStyle(
                              fontSize: fontSize.button,
                              fontWeight: FontWeight.w700),
                        ),

                        // テキストとスイッチを左右の端に置くためのSpacer
                        const Spacer(),

                        // 切り替えスイッチ
                        Transform.scale(
                          scale: sizeConfig.screenWidthTimes,
                          child: Switch(
                            // 初期値はON/OFF
                            value: statusFlg.notificationState ==
                                notificationStatAuthorized,
                            // activeColor: デフォルトのまま
                            onChanged: (value) {
                              // 裏返す
                              switchNotifier.notificationFlip(value);
                              // if (debugPreference) {
                              //   debugPrint(
                              //       "onChanged: notification: $value : ${statusFlg.notificationState} and myPreference = ${PreferenceManager().getPreference().toJson().toString()}");
                              // }
                            },
                          ),
                        ),
                        SizedBox(
                          width: fontSize.headlineH7,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ここから先はriverpodを使った、設定切り替えに対応する
// ためのクラス群（無駄に仕掛けを複雑にしている感がある）
Preference myPreference = PreferenceManager().getPreference();

class ProfSwitchNotifier extends StateNotifier<Preference> {
  ProfSwitchNotifier() : super(myPreference);

  void notificationFlip(bool value) {
    int beforeState = state.notificationState;
    // オンを指定
    if ((value) && (beforeState != notificationStatAuthorized)) {
      state =
          myPreference.copyWith(notificationState: notificationStatAuthorized);
      PreferenceManager().setNotificationState(notificationStatAuthorized);
    }
    // オフを指定
    else if ((!value) && (beforeState == notificationStatAuthorized)) {
      state = myPreference.copyWith(notificationState: notificationStatDenied);
      PreferenceManager().setNotificationState(notificationStatDenied);
    }
  }
}
