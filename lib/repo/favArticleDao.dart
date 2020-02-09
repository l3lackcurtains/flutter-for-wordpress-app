import 'dart:async';

import 'package:flutter_wordpress_app/models/Article.dart';

import 'favArticleDb.dart';

class FavArticleDao {
  final dbProvider = FavArticleDatabaseProvider.dbProvider;

  Future<int> createFavArticle(Article article) async {
    final db = await dbProvider.database;

    var result = await db.insert(favArticleTABLE, article.toDatabaseJson());
    return result;
  }

  Future<List<Article>> getFavArticles(
      {List<String> columns, String query, int page}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(
          favArticleTABLE,
          columns: columns,
          where: 'name LIKE ?',
          whereArgs: ["%$query%"],
        );
    } else {
      result = await db.query(favArticleTABLE, columns: columns);
    }

    List<Article> articles = result.isNotEmpty
        ? result.map((item) => Article.fromDatabaseJson(item)).toList()
        : [];
    return articles;
  }

  Future<Article> getFavArticle(int id) async {
    final db = await dbProvider.database;
    List<Map> maps =
        await db.query(favArticleTABLE, where: 'id = ?', whereArgs: [id]);
    Article article =
        maps.length > 0 ? Article.fromDatabaseJson(maps.first) : null;
    return article;
  }

  Future<int> deleteFavArticle(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(favArticleTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
