// Notificationメッセージ受け渡し用
class MessageProvider {
  // クラス内インスタンス
  static final MessageProvider _instance = MessageProvider._();
  // プライベートコンストラクタ
  MessageProvider._();

  factory MessageProvider() {
    return _instance;
  }

  String _notificationMsg = "";

  void removeMsg() {
    _notificationMsg = "";
  }

  String getMsg() {
    return _notificationMsg;
  }

  void setMsg(String notice) {
    _notificationMsg = notice;
  }
}
