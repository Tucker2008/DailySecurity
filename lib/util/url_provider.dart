// URL受け渡し用
class UrlProvider {
  // クラス内インスタンス
  static final UrlProvider _instance = UrlProvider._();
  // プライベートコンストラクタ
  UrlProvider._();

  factory UrlProvider() {
    return _instance;
  }

  String target = "";

  String getUrl() {
    return target;
  }

  void setUrl(String url) {
    target = url;
  }

  void resetUrl() {
    target = "";
  }
}
