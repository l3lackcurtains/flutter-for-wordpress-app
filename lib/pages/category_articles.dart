import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icilome_mobile/common/screen_arguments.dart';
import 'package:icilome_mobile/models/Article.dart';
import 'package:icilome_mobile/pages/single_Article.dart';
import 'package:icilome_mobile/widgets/articleBox.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

Future<List<dynamic>> fetchCategoryArticles(int id) async {
  try {
    Dio dio = new Dio();
    Response response = await dio.get(
        "https://demo.icilome.net/wp-json/wp/v2/posts?_embed&categories[]=" +
            id.toString());

    if (response.statusCode == 200) {
      return response.data.map((m) => Article.fromJson(m)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  } catch (e) {
    throw Exception('Failed to load posts' + e.toString());
  }
}

class CategoryArticles extends StatefulWidget {
  @override
  _CategoryArticlesState createState() => _CategoryArticlesState();
}

class _CategoryArticlesState extends State<CategoryArticles> {
  Future<List<dynamic>> articles;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryArticlesScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(args.name,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins')),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: <Widget>[
              categoryPosts(fetchCategoryArticles(args.id))
            ])),
      ),
    );
  }
}

Widget categoryPosts(Future<List<dynamic>> articles) {
  return FutureBuilder<List<dynamic>>(
    future: articles,
    builder: (context, articleSnapshot) {
      if (articleSnapshot.hasData) {
        return Column(
            children: articleSnapshot.data.map((item) {
          final heroId = item.id.toString() + "-categorypost";
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleArticle(),
                  settings: RouteSettings(
                    arguments: SingleArticleScreenArguments(item, heroId),
                  ),
                ),
              );
            },
            child: articleBox(item.title, item.excerpt, item.image, item.author,
                item.avatar, heroId),
          );
        }).toList());
      } else if (articleSnapshot.hasError) {
        return Container(
            height: 500,
            alignment: Alignment.center,
            child: Text("${articleSnapshot.error}"));
      }
      return Container(
        alignment: Alignment.center,
        height: 400,
        child: Loading(
            indicator: BallBeatIndicator(),
            size: 60.0,
            color: Colors.redAccent),
      );
    },
  );
}
