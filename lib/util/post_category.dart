// ポストされた投稿のカテゴリを判別するテーブル
// ニュースのカテゴリもここで定義
//
import 'package:flutter/material.dart';

//
// ニュースカテゴリ定義
//
const ipaCategory = "ipa";
const jvnCategory = "jvn";
const jcrCategory = "jcr";

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

ImageProvider<Object> postCategotyImageicon(String category) {
  switch (category) {
    case ipaCategory:
      return const AssetImage('images/ipa_logo.png');
    case jvnCategory:
      return const AssetImage('images/jvn_logo.png');
    case jcrCategory:
      return const AssetImage('images/jcr_logo.png');
    default:
      return const AssetImage('images/ipa_logo.png');
  }
}
