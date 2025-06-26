//
// 日付のフォーマットを規定する
// 分散する日付フォーマットを統一することで、_DateFormatField.throwFormatExceptionを避ける

// 日時取り出しは秒まで取り出す(2025.6.26)
const dateFormJp20 = '20yy年MM月dd日(E)H時m分s秒';
const dateFormJp = 'yyyy年MM月dd日(E)H時m分s秒';
// WEBページは日付までしか記載されていないので割愛版
const dateFormWebJp = 'yyyy年MM月dd日';
const dateFormCocolog = 'yyyy/MM/dd';

// 日付のローカライズ
const dateFormLocale = 'ja_JP';

// 判別不能の意味
const dateFormNA = 'N/A';

// 日付は分秒まで表示すると長いので末尾の分秒だけ削除
// その削除のための正規表現を定義 '\d{1,2}分\d{1,2}秒$'
// 12のメタ文字には、\をつける
// メタ文字は、以下の12個: $()*+.?[\^{|
const regexDelSec = "\\d{1,2}分\\d{1,2}秒\$";

// 文字列保存していない日付データを表示する際のフォーマット
const dateFormJpDisp = 'yyyy年MM月dd日(E)';
