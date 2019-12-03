import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icilome_mobile/common/screen_arguments.dart';
import 'package:icilome_mobile/models/Article.dart';
import 'package:icilome_mobile/pages/single_Article.dart';
import 'package:icilome_mobile/widgets/articleBox.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

class LocalArticles extends StatefulWidget {
  @override
  _LocalArticlesState createState() => _LocalArticlesState();
}

class _LocalArticlesState extends State<LocalArticles> {
  List<dynamic> articles = [];
  Future<List<dynamic>> _futureArticles;
  ScrollController _controller;
  int page = 1;
  bool _infiniteStop;

  @override
  void initState() {
    super.initState();
    _futureArticles = fetchLocalArticles(1);
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

  Future<List<dynamic>> fetchLocalArticles(int page) async {
    var response = await http.get(
        "https://demo.icilome.net/wp-json/wp/v2/posts?_embed&categories[]=94&page=$page&per_page=10");
    if (this.mounted) {
      if (response.statusCode == 200) {
        setState(() {
          articles.addAll(json
              .decode(response.body)
              .map((m) => Article.fromJson(m))
              .toList());
        });

        return articles;
      } else {
        setState(() {
          _infiniteStop = true;
        });
      }
    }
    return articles;
  }

  _scrollListener() {
    var isEnd = _controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange;
    if (isEnd) {
      setState(() {
        page += 1;
        _futureArticles = fetchLocalArticles(page);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Local News",
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
            controller: _controller,
            child: categoryPosts(_futureArticles)),
      ),
    );
  }

  Widget categoryPosts(Future<List<dynamic>> futureArticles) {
    return FutureBuilder<List<dynamic>>(
      future: futureArticles,
      builder: (context, articleSnapshot) {
        if (articleSnapshot.hasData) {
          return Column(
            children: <Widget>[
              Column(
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
            width: MediaQuery.of(context).size.width - 30,
            child: Loading(
                indicator: BallBeatIndicator(),
                size: 60.0,
                color: Colors.redAccent));
      },
    );
  }
}
