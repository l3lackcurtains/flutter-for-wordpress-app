import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icilome_mobile/common/screen_arguments.dart';
import 'package:icilome_mobile/models/Article.dart';
import 'package:icilome_mobile/pages/single_Article.dart';
import 'package:icilome_mobile/widgets/articleBox.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

class CategoryArticles extends StatefulWidget {
  final int id;
  final String name;
  CategoryArticles(this.id, this.name, {Key key}) : super(key: key);
  @override
  _CategoryArticlesState createState() => _CategoryArticlesState();
}

class _CategoryArticlesState extends State<CategoryArticles> {
  List<dynamic> categoryArticles = [];
  Future<List<dynamic>> _futureCategoryArticles;
  ScrollController _controller;
  int page = 1;
  bool _infiniteStop;

  @override
  void initState() {
    super.initState();
    _futureCategoryArticles = fetchCategoryArticles(1);
    _controller =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
    _controller.addListener(_scrollListener);
    _infiniteStop = false;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<List<dynamic>> fetchCategoryArticles(int page) async {
    var response = await http.get(
        "https://demo.icilome.net/wp-json/wp/v2/posts?_embed&categories[]=" +
            widget.id.toString() +
            "&page=$page&per_page=10");

    if (this.mounted) {
      if (response.statusCode == 200) {
        setState(() {
          categoryArticles.addAll(json
              .decode(response.body)
              .map((m) => Article.fromJson(m))
              .toList());
          if (categoryArticles.length % 10 != 0) {
            _infiniteStop = true;
          }
        });

        return categoryArticles;
      }
      setState(() {
        _infiniteStop = true;
      });
    }
    return categoryArticles;
  }

  _scrollListener() {
    var isEnd = _controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange;
    if (isEnd) {
      setState(() {
        page += 1;
        _futureCategoryArticles = fetchCategoryArticles(page);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.name,
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
            controller: _controller,
            scrollDirection: Axis.vertical,
            child: Column(
                children: <Widget>[categoryPosts(_futureCategoryArticles)])),
      ),
    );
  }

  Widget categoryPosts(Future<List<dynamic>> categoryArticles) {
    return FutureBuilder<List<dynamic>>(
      future: categoryArticles,
      builder: (context, articleSnapshot) {
        if (articleSnapshot.hasData) {
          return Column(
            children: <Widget>[
              Column(
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
                  child: articleBox(
                      item.title,
                      item.excerpt,
                      item.image,
                      item.author,
                      item.avatar,
                      item.category,
                      item.date,
                      heroId),
                );
              }).toList()),
              !_infiniteStop
                  ? Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Loading(
                          indicator: BallBeatIndicator(),
                          size: 60.0,
                          color: Colors.redAccent))
                  : Container()
            ],
          );
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
}
