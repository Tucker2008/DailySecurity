import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_structure.freezed.dart';
part 'post_structure.g.dart';

@freezed
class PostStructure with _$PostStructure {
  const PostStructure._();

  const factory PostStructure({
    required String category, //記事カテゴリ(content_category)
    required String entoryTitle, //投稿タイトル(entry_header)
    required DateTime dateHeader, //投稿日(date_header)
    @Default([]) List<String> contentAbstract, // 発生事実（content_abstract）
    @Default([]) List<String> contentDetails, // 詳細説明（content_details）
    @Default([]) List<String> contentHref, // Link先説明（content_details）
    @Default([]) List<Uri> contentLinks, // 参照リンク（content_links）
  }) = _PostStructure;

  //※注意
  // 上記Listメンバに直接 add などを行ってはいけない。defaultがnullなので例外が発生する

  // Map形式からの変換（多分使わないｗ）
  factory PostStructure.fromJson(Map<String, dynamic> json) =>
      _$PostStructureFromJson(json);
}
