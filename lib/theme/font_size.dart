// Material Designのフォントサイズを定義（アプリ中の共通とする）

class FontSize {
  // クラス内インスタンス
  static final FontSize _instance = FontSize._();
  // プライベートコンストラクタ
  FontSize._();

  factory FontSize() {
    return _instance;
  }
  // initの多重化防止
  static bool _initOnce = false;

  double headLineH4 = 34.0;
  double headlineH5 = 24.0;
  double headlineH6 = 20.0;
  double headlineH7 = 18.0;
  double subTitle1 = 16.0;
  double subTitle2 = 14.0;
  double body1 = 16.0;
  double body2 = 14.0;
  double button = 14.0;
  double caption = 12.0;
  double oberline = 10.0;
  double menu = 9.5; // NewsPicsベンチマーク値

  // iPadなどの画面サイズ差を埋めるためのフォントサイズ設定
  void init(double times) {
    // リロードで再計算するのを防ぐ
    if (_initOnce) {
      return;
    } else {
      _initOnce = !_initOnce;
    }
    if (times > 1.0) {
      headLineH4 *= times;
      headlineH5 *= times;
      headlineH6 *= times;
      headlineH7 *= times;
      subTitle1 *= times;
      subTitle2 *= times;
      body1 *= times;
      body2 *= times;
      button *= times;
      caption *= times;
      oberline *= times;
      menu *= times;
    }
  }
}

  // 元のサイズ定義
  // final double headLineH4 = 34.0;
  // final double headlineH5 = 24.0;
  // final double headlineH6 = 20.0;
  // final double subTitle1 = 16.0;
  // final double subTitle2 = 14.0;
  // final double body1 = 16.0;
  // final double body2 = 14.0;
  // final double button = 14.0;
  // final double caption = 12.0;
  // final double oberline = 10.0;
  // final double menu = 9.5; // NewsPicsベンチマーク値
