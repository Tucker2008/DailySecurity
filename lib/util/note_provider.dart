// エラー受け渡し用
class NoteProvider {
  // クラス内インスタンス
  static final NoteProvider _instance = NoteProvider._();
  // プライベートコンストラクタ
  NoteProvider._();

  factory NoteProvider() {
    return _instance;
  }

  String noteMsg = "";

  String getNote() {
    final retMsg = noteMsg;
    noteMsg = "";
    return retMsg;
  }

  void setNote(String notice) {
    noteMsg = notice;
  }
}
