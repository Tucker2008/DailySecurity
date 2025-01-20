import 'package:cyber_interigence/theme/font_size.dart';
import 'package:cyber_interigence/theme/size_config.dart';

// グローバル定数定義
//
// 過去記事の何日前まで取り込むか？日数を定義する
const int maxFeedDuration = 30;
const int minFeedCount = 14;

// 記事tileのタイトル行数
const int titleLineMax = 3;

// メインメニューの高さ
const double appMenuHeight = 96.0;

// キャッシュマネージャ
const int cacheTerm = 12; // キャッシュ有効期限は12時間

// Fontサイズの定義
// 参照箇所が多いのでグローバルに定義
final fontSize = FontSize();

// 非アクティブの経過時間（これを過ぎるとアプリ再ロードする）
const int inactiveHours = 3;

// エントランスのニュース数
const int entranceNewsMax = 4;

// サイズの定義
// 参照箇所が多いのでグローバルに定義
final sizeConfig = SizeConfig();

// デバッグモードの選択（日々の開発ステップごとに設定）
// bool debugStructure = false; // 構造変更などのデバッグモード
// bool debugRssFeed = false; // RSSリーダ機能のデバッグ
// bool debugPreference = true; // ユーザ設定のデバッグ
// bool debugEntryDetails = false; // cocologエントリの中身のデバッグ
// bool debugEntry = false; // cocologエントリのデバッグ
// bool debugOnboard = false; // 起動１回目の画面デバッグ用
// bool debugAsync = false; // 投稿取得同期のデバッグ
// bool debugCache = false; // RSSリーダ機能のデバッグ
