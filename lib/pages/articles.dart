import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icilome_mobile/common/screen_arguments.dart';
import 'package:icilome_mobile/models/Article.dart';
import 'package:icilome_mobile/pages/single_Article.dart';
import 'package:icilome_mobile/widgets/articleBox.dart';
import 'package:icilome_mobile/widgets/articleBoxFeatured.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

Future<List<dynamic>> fetchArticles() async {
  try {
    Dio dio = new Dio();
    Response response =
        await dio.get("https://demo.icilome.net/wp-json/wp/v2/posts/?_embed");

    if (response.statusCode == 200) {
      return response.data.map((m) => Article.fromJson(m)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  } catch (e) {
    throw Exception('Failed to load posts');
  }
}

Future<List<dynamic>> fetchFeaturedArticles() async {
  try {
    Dio dio = new Dio();
    Response response = await dio
        .get("https://demo.icilome.net/wp-json/wp/v2/posts/?_embed&tags=140");

    if (response.statusCode == 200) {
      return response.data.map((m) => Article.fromJson(m)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  } catch (e) {
    throw Exception('Failed to load posts');
  }
}

class Articles extends StatefulWidget {
  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  Future<List<dynamic>> articles;
  Future<List<dynamic>> featuredArticles;

  @override
  void initState() {
    super.initState();
    articles = fetchArticles();
    featuredArticles = fetchFeaturedArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Icilome News',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Poppins')),
          elevation: 1,
          backgroundColor: Colors.white,
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white70),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                featuredPost(featuredArticles),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Latest News",
                      style: TextStyle(
                          fontFamily: "Bitter",
                          fontSize: 22,
                          color: Colors.black,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                latestPosts(articles)
              ],
            ),
          ),
        ));
  }
}

Widget featuredPost(Future<List<dynamic>> featuredArticles) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: FutureBuilder<List<dynamic>>(
      future: featuredArticles,
      builder: (context, articleSnapshot) {
        if (articleSnapshot.hasData) {
          return Row(
              children: articleSnapshot.data.map((item) {
            final heroId = item.id.toString() + "-featured";
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
                child: articleBoxFeatured(item.title, item.excerpt, item.image,
                    item.author, item.avatar, heroId));
          }).toList());
        } else if (articleSnapshot.hasError) {
          return Container(
              height: 500,
              alignment: Alignment.center,
              child: Text("${articleSnapshot.error}"));
        }
        return Container(
            alignment: Alignment.center,
            width: 300,
            height: 280,
            child: Loading(
                indicator: BallBeatIndicator(),
                size: 60.0,
                color: Colors.redAccent));
      },
    ),
  );
}

Widget latestPosts(Future<List<dynamic>> articles) {
  return FutureBuilder<List<dynamic>>(
    future: articles,
    builder: (context, articleSnapshot) {
      if (articleSnapshot.hasData) {
        return Column(
            children: articleSnapshot.data.map((item) {
          final heroId = item.id.toString() + "-latest";
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
          width: 300,
          height: 150,
          child: Loading(
              indicator: BallBeatIndicator(),
              size: 60.0,
              color: Colors.redAccent));
    },
  );
}
