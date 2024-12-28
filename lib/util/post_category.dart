// ポストされた投稿のカテゴリを判別するテーブル

// カテゴリ
import 'package:flutter/material.dart';

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
  "news": newsCategoryIndex,
  "column": columnCategoryIndex,
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
  if (postCategoryMap.containsKey(categoryString)) {
    final indexNum = postCategoryMap[categoryString];
    if (postCategoryIconMap.containsKey(indexNum)) {
      return postCategoryIconMap[indexNum]!;
    }
  }
  // debugPrint("postCategoryIcon: $categoryString ${categoryString.isNotEmpty}");
  return postCategoryIconMap[unknownCategoryIndex]!;
}
