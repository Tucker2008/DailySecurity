//
// 指定月日のチェックすべきシナリオは何かを決めるシナリオテーブル
//
// 月曜日が１始まりで、日曜日が７という仕様なので、0番目は空き
//
// チェックする内容を１字にして、その文字が含まれていたら重点チェック
// scenarioTable[x].contains('w'); // true
// ↑こういう使い方を想定

// 文字によるチェック種別 優先順位順
// w: Windows Update
// p: Password Update
// v: Vielus Guard Patter file update
// d: Data Backuped
// m: Fishing注意
// i: Bring out information
// s: Screen Lock

enum SCategory {
  w, // w: Windows Update  :0
  p, // p: Password Update  :1
  v, // v: Vielus Guard Patter file update  :2
  d, // d: Data Backuped  :3
  m, // m: Fishing注意  :4
  i, // i: Bring out information  :5
  s, // s: Screen Lock  :6
}

List<String> scenarioPattern = [
  'w', // w: Windows Update
  'p', // p: Password Update
  'v', // v: Vielus Guard Patter file update
  'd', // d: Data Backuped
  'm', // m: Fishing注意
  'i', // i: Bring out information
  's', // s: Screen Lock
];

//
final List<String> scenarioTable = [
  "dp", // 0
  "mw", // 1
  "iv", // 2
  "sp", // 3
  "dw", // 4
  "mv", // 5
  "i", // 6
  "v", // 7
  "p", // 8
  "pv", // 9
  "p", // 10
  "pv", // 11
  "p", // 12
  "pv", // 13
  "p", // 14
  "w", // 15 -- Windows Updateのアジャストする日
  "w", // 16
  "w", // 17
  "w", // 18
  "w", // 19
  "w", // 20
  "w", // 21
  "v", // 22
  "v", // 23
  "vd", // 24
  "vm", // 25
  "vi", // 26
  "vs", // 27
  "v", // 28
  "sv", // 29
  "dw", // 30
  "m", // 31
  "iw", // 32
  "s", // 33
  "dw", // 34
  "m", // 35
  "iw", // 37
  "s", // 38
  "dw", // 39
  "m", // 40
  "iw", // 41
  "s", // 42
];

//  Windows Updateのアジャストする日
// ↓この様に取り出す時に使うイメージ
// scenarioTable[scenarioTableAdjust - _windowsUpdateDurationDays]
const int scenarioTableAdjust = 15;

// チェックするターム（チェックしたら次にチェックするまでの期間）
const int scenarioStandartPeriod = 30; //普通は30日毎
const int scenarioPasswordPeriod = 90; //パスワードは90日
