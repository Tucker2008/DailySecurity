// エラー受け渡し用
class NoteProvider {
  // クラス内インスタンス
  static final NoteProvider _instance = NoteProvider._();
  // プライベートコンストラクタ
  NoteProvider._();

  factory NoteProvider() {
    return _instance;
  }

  String _noteMsg = "";

  String getNote() {
    final retMsg = _noteMsg;
    _noteMsg = "";
    return retMsg;
  }

  void setNote(String notice) {
    _noteMsg = notice;
  }

  bool getStatus() {
    return _noteMsg.isNotEmpty;
  }
}
