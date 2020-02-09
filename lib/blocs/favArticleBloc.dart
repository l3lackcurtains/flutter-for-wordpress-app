import 'dart:async';

import 'package:flutter_wordpress_app/models/Article.dart';
import 'package:flutter_wordpress_app/repo/favArticleRepo.dart';

class FavArticleBloc {
  final _articleRepository = FavArticleRepository();

  final _articlesController = StreamController<List<Article>>.broadcast();

  Stream<List<Article>> get articles => _articlesController.stream;

  FavArticleBloc() {
    getFavArticles();
  }

  Future<List<Article>> getFavArticles({String query, int page}) async {
    final List<Article> articles =
        await _articleRepository.getAllFavArticles(query: query, page: page);
    _articlesController.sink.add(articles);
    return articles;
  }

  getFavArticle(int id) async {
    final Article article = await _articleRepository.getFavArticle(id);
    return article;
  }

  addFavArticle(Article article) async {
    await _articleRepository.insertFavArticle(article);
    getFavArticles();
  }

  deleteFavArticleById(int id) async {
    _articleRepository.deleteFavArticleById(id);
    getFavArticles();
  }

  dispose() {
    _articlesController.close();
  }
}
