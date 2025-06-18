// ポストされた投稿のカテゴリを判別するテーブル
// ニュースのカテゴリもここで定義
//
import 'package:cyber_interigence/constant/url_constant.dart';
import 'package:flutter/material.dart';

//
// ニュースカテゴリ定義
//
const newsCategory = "news";
const columnCategory = "column";

//
// cocolog 投稿カテゴリ 定義
//
enum PostCategory {
  unknownCategoty,
  testCategory,
  infoCategory,
  newsCategory,
  columnCategory,
  contentCategory,
  notAvailable,
}

// カテゴリ番号
final unknownCategoryIndex = PostCategory.unknownCategoty.index;
final testCategoryIndex = PostCategory.testCategory.index;
final infoCategoryIndex = PostCategory.infoCategory.index;
final newsCategoryIndex = PostCategory.newsCategory.index;
final columnCategoryIndex = PostCategory.columnCategory.index;
final contentCategoryIndex = PostCategory.contentCategory.index;
final notAvailableIndex = PostCategory.notAvailable.index;

// カテゴリマップ(カテゴリ名->カテゴリ番号)
final Map<String, int> postCategoryMap = {
  "unknown": unknownCategoryIndex,
  "test": testCategoryIndex,
  "info": infoCategoryIndex,
  newsCategory: newsCategoryIndex,
  columnCategory: columnCategoryIndex,
  "contents": contentCategoryIndex,
  // "N/A": notAvailableIndex,
};

// カテゴリマップ(カテゴリ番号->カテゴリアイコン)
final Map<int, IconData> postCategoryIconMap = {
  unknownCategoryIndex: Icons.device_unknown,
  testCategoryIndex: Icons.filter_list_off,
  infoCategoryIndex: Icons.fact_check,
  newsCategoryIndex: Icons.newspaper,
  columnCategoryIndex: Icons.note_alt_outlined,
  contentCategoryIndex: Icons.content_paste,
  // notAvailableIndex: Icons.web_stories_outlined,
};

// 以下はココログ記事のカテゴリごとのアイコンイメージ処理
// postCategoryMapはココログ記事毎の定義
//
// ニュースカテゴリアイコンがあるか？
IconData postCategoryIcon(String categoryString) {
  if (iconAvalable(categoryString)) {
    final indexNum = postCategoryMap[categoryString];
    if (postCategoryIconMap.containsKey(indexNum)) {
      return postCategoryIconMap[indexNum]!;
    }
  }
  return postCategoryIconMap[unknownCategoryIndex]!;
}

bool iconAvalable(String category) {
  return postCategoryMap.containsKey(category);
}

// 以下はニュースソースのアイコンイメージ処理
// categoryIconMap　はニュースカテゴリ毎の定義
//
// ニュースカテゴリアイコンがあるか？
bool postCategoryIconAvalable(String category) {
  return categoryIconMap.containsKey(category);
}

// ニュースカテゴリアイコンがあれば返すが、ない場合は適当なものを返す
ImageProvider<Object> postCategotyImageicon(String category) {
  const basePath = 'images/logo';

  if (categoryIconMap.containsKey(category)) {
    return AssetImage('$basePath/${categoryIconMap[category]}');
  }
  return const AssetImage('$basePath/non_logo.png');

  // switch (category) {
  //   case ipaCategory:
  //     return const AssetImage('images/ipa_logo.png');
  //   case jvnCategory:
  //     return const AssetImage('images/jvn_logo.png');
  //   case jcrCategory:
  //     return const AssetImage('images/jcr_logo.png');
  //   case cisCategory:
  //     return const AssetImage('images/cis_logo.png');
  //   case ncsCategory:
  //     return const AssetImage('images/ncs_logo.png');
  //   case fisCategory:
  //     return const AssetImage('images/fis_logo.png');
  //   default:
  //     return const AssetImage('images/non_logo.png');
  // }
}
