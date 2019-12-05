import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icilome_mobile/models/Article.dart';
import 'package:icilome_mobile/pages/single_Article.dart';
import 'package:icilome_mobile/widgets/articleBox.dart';
import 'package:icilome_mobile/widgets/articleBoxFeatured.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

class Articles extends StatefulWidget {
  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  List<dynamic> latestArticles = [];
  List<dynamic> featuredArticles = [];
  Future<List<dynamic>> _futureLastestArticles;
  Future<List<dynamic>> _futureFeaturedArticles;
  ScrollController _controller;
  int page = 1;
  bool _infiniteStop;

  @override
  void initState() {
    super.initState();
    _futureLastestArticles = fetchLatestArticles(1);
    _futureFeaturedArticles = fetchFeaturedArticles(1);
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

  Future<List<dynamic>> fetchLatestArticles(int page) async {
    try {
      var response = await http.get(
          "https://demo.icilome.net/wp-json/wp/v2/posts/?_embed&page=$page&per_page=10");
      if (this.mounted) {
        if (response.statusCode == 200) {
          setState(() {
            featuredArticles.addAll(json
                .decode(response.body)
                .map((m) => Article.fromJson(m))
                .toList());
            if (featuredArticles.length % 10 != 0) {
              _infiniteStop = true;
            }
          });

          return featuredArticles;
        }
        setState(() {
          _infiniteStop = true;
        });
      }
    } on SocketException {
      throw 'No Internet connection';
    }
    return featuredArticles;
  }

  Future<List<dynamic>> fetchFeaturedArticles(int page) async {
    try {
      var response = await http.get(
          "https://demo.icilome.net/wp-json/wp/v2/posts/?_embed&tags=140&page=$page&per_page=10");

      if (this.mounted) {
        if (response.statusCode == 200) {
          setState(() {
            latestArticles.addAll(json
                .decode(response.body)
                .map((m) => Article.fromJson(m))
                .toList());
          });

          return latestArticles;
        } else {
          setState(() {
            _infiniteStop = true;
          });
        }
      }
    } on SocketException {
      throw 'No Internet connection';
    }
    return latestArticles;
  }

  _scrollListener() {
    var isEnd = _controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange;
    if (isEnd) {
      setState(() {
        page += 1;
        _futureLastestArticles = fetchLatestArticles(page);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Icilome News',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Poppins')),
          elevation: 5,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white70),
          child: SingleChildScrollView(
            controller: _controller,
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                featuredPost(_futureFeaturedArticles),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Latest News",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 22,
                          color: Colors.black,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                latestPosts(_futureLastestArticles)
              ],
            ),
          ),
        ));
  }

  Widget latestPosts(Future<List<dynamic>> latestArticles) {
    return FutureBuilder<List<dynamic>>(
      future: latestArticles,
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
                        builder: (context) => SingleArticle(item, heroId),
                      ),
                    );
                  },
                  child: articleBox(context, item, heroId),
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
            width: 300,
            height: 150,
            child: Loading(
                indicator: BallBeatIndicator(),
                size: 60.0,
                color: Theme.of(context).accentColor));
      },
    );
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
                        builder: (context) => SingleArticle(item, heroId),
                      ),
                    );
                  },
                  child: articleBoxFeatured(context, item, heroId));
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
}
