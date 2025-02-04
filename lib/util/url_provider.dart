// URL受け渡し用

class UrlProvider {
  // クラス内インスタンス
  static final UrlProvider _instance = UrlProvider._();
  // プライベートコンストラクタ
  UrlProvider._();

  factory UrlProvider() {
    return _instance;
  }

  String _target = "";
  // RssInformation? _rssinfo;

  String getUrl() {
    return _target;
  }

  void setUrl(String url) {
    _target = url;
  }

  void resetUrl() {
    _target = "";
  }

  // JPCertのURL置き換え共通ロジック
  // 複数箇所で使うのでここに集約
  String jpcertUrl(String original) {
    final origin = Uri.parse(original).origin.trim();
    final inner = Uri.parse(original).path;
    return Uri.parse("$origin/m$inner").toString();
  }

  // URLだけでなくRssInformationも渡せる様にする
  // URLも内部でセットしておく
  // void setUrlRss(RssInformation rss) {
  //   _target = rss.link!;
  //   _rssinfo = rss;
  //   debugPrint("setUrlRss: $_target, ${_rssinfo == null}");
  // }

  // RssInformationを取得、urlはgetUrlを共用
  // RssInformation? getRss() {
  //   final RssInformation? retRss = _rssinfo;
  //   debugPrint("getRss: ${_rssinfo == null}");
  //   // 呼び出されたらクリアしないと他で誤動作
  //   _rssinfo = null;
  //   return retRss;
  // }
}
