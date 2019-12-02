import 'package:icilome_mobile/models/Article.dart';

class SingleArticleScreenArguments {
  final Article article;
  final String heroId;

  SingleArticleScreenArguments(this.article, this.heroId);
}

class CategoryArticlesScreenArguments {
  final int id;
  final String name;
  CategoryArticlesScreenArguments(this.id, this.name);
}

class CommentScreenArguments {
  final int id;
  CommentScreenArguments(this.id);
}
