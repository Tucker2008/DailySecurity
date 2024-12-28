import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference.freezed.dart';
part 'preference.g.dart';

@freezed
class Preference with _$Preference {
  const Preference._();

  const factory Preference({
    required int notificationState, //Notification OnとOffと未設定の区分情報
    required DateTime lastLoginDate, //LastLogin(次回に使う)
    @Default(false) bool browserState, //ブラウザの設定情報(未使用)
    @Default(false) bool introductionState, //初期イントロを表示したかの設定情報
    @Default("") String tokenId, // 通知のトークン（登録されている場合）
    @Default("") String appleToken, // iOSのトークン（登録されている場合）
  }) = _Preference;

  // Map形式からの変換
  factory Preference.fromJson(Map<String, dynamic> json) =>
      _$PreferenceFromJson(json);
}
