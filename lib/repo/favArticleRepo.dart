import 'package:flutter_wordpress_app/models/Article.dart';

import 'favArticleDao.dart';

class FavArticleRepository {
  final favArticleDao = FavArticleDao();

  Future getAllFavArticles({String query, int page}) =>
      favArticleDao.getFavArticles(query: query, page: page);

  Future getFavArticle(int id) => favArticleDao.getFavArticle(id);

  Future insertFavArticle(Article article) =>
      favArticleDao.createFavArticle(article);

  Future deleteFavArticleById(int id) => favArticleDao.deleteFavArticle(id);
}
