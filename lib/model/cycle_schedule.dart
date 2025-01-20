import 'package:freezed_annotation/freezed_annotation.dart';

part 'cycle_schedule.freezed.dart';
part 'cycle_schedule.g.dart';

@freezed
class CycleSchedule with _$CycleSchedule {
  const CycleSchedule._();

  const factory CycleSchedule({
    @Default(null) DateTime? winUpdate, // Windows Updateの実施日
    @Default(null) DateTime? passwordUpdate, // パスワード Updateの実施日
    @Default(null) DateTime? virusUpdate, // ウィルスパターン Updateの実施日
    @Default(null) DateTime? otherDodate, // 以下その他パターンの実施日
    @Default(null) DateTime? backupDodate, // バックアップ実施パターンの実施日
    @Default(null) DateTime? fishingDodate, // フィッシング警戒の実施日
    @Default(null) DateTime? handleDodate, // 情報持ち出し警戒の実施日
    @Default(null) DateTime? displayLockDodate, // 画面ロックの実施日
  }) = _CycleSchedule;

  //※注意
  // 上記Listメンバに直接 add などを行ってはいけない。defaultがnullなので例外が発生する

  // Map形式からの変換
  factory CycleSchedule.fromJson(json) => _$CycleScheduleFromJson(json);
}
