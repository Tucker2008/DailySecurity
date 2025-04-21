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

  bool isEmpty() {
    return _noteMsg.isEmpty;
  }

  String getNote() {
    final retMsg = _noteMsg;
    _noteMsg = "";
    return retMsg;
  }

  void setNote(String notice) {
    _noteMsg = notice;
  }
}
