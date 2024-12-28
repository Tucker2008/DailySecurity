// Material Designのフォントサイズを定義（アプリ中の共通とする）

class FontSize {
  // クラス内インスタンス
  static final FontSize _instance = FontSize._();
  // プライベートコンストラクタ
  FontSize._();

  factory FontSize() {
    return _instance;
  }

  final double headLineH4 = 34.0;
  final double headlineH5 = 24.0;
  final double headlineH6 = 20.0;
  final double subTitle1 = 16.0;
  final double subTitle2 = 14.0;
  final double body1 = 16.0;
  final double body2 = 14.0;
  final double button = 14.0;
  final double caption = 12.0;
  final double oberline = 10.0;
  final double menu = 9.5; // NewsPicsベンチマーク値
}
