//
// スクリーン番号の受け渡し用
//
// 2025.4.17 メインスクリーンのBookMark廃止、海外ニュース追加

// スクリーン番号定義
enum ScreenNum {
  entranceScreen,
  cocologPage,
  cycleScreen,
  newsMainPage,
  foreignNewsPage,
}

final int entranceScreenNum = ScreenNum.entranceScreen.index;
final int cocologPageNum = ScreenNum.cocologPage.index;
final int cycleScreenNum = ScreenNum.cycleScreen.index;
final int newsMainPageNum = ScreenNum.newsMainPage.index;
final int foreignNewsPageNum = ScreenNum.foreignNewsPage.index;

//
// スクリーン番号の受け渡しクラス
//
class ScreenProvider {
  // クラス内インスタンス
  static final ScreenProvider _instance = ScreenProvider._();
  // プライベートコンストラクタ
  ScreenProvider._();

  factory ScreenProvider() {
    return _instance;
  }

  int _screen = -1;

  int getScreen() {
    return _screen >= 0 ? _screen : 0;
  }

  void setScreen(int sc) {
    _screen = sc;
  }

  void resetScreen() {
    _screen = -1;
  }
}
