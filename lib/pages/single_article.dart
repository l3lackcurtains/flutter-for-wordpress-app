import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_wordpress_app/common/constants.dart';
import 'package:flutter_wordpress_app/models/Article.dart';
import 'package:flutter_wordpress_app/pages/comments.dart';
import 'package:flutter_wordpress_app/widgets/articleBox.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

class SingleArticle extends StatefulWidget {
  final dynamic article;
  final String heroId;

  SingleArticle(this.article, this.heroId, {Key? key}) : super(key: key);

  @override
  _SingleArticleState createState() => _SingleArticleState();
}

class _SingleArticleState extends State<SingleArticle> {
  List<dynamic> relatedArticles = [];
  Future<List<dynamic>>? _futureRelatedArticles;

  @override
  void initState() {
    super.initState();

    _futureRelatedArticles = fetchRelatedArticles();
  }

  Future<List<dynamic>> fetchRelatedArticles() async {
    try {
      int postId = widget.article.id;
      int catId = widget.article.catId;
      var response = await http.get(Uri.parse(
          "$WORDPRESS_URL/wp-json/wp/v2/posts?exclude=$postId&categories[]=$catId&per_page=3"));

      if (this.mounted) {
        if (response.statusCode == 200) {
          setState(() {
            relatedArticles = json
                .decode(response.body)
                .map((m) => Article.fromJson(m))
                .toList();
          });

          return relatedArticles;
        }
      }
    } on SocketException {
      throw 'No Internet connection';
    }
    return relatedArticles;
  }

  @override
  void dispose() {
    super.dispose();
    relatedArticles = [];
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    final heroId = widget.heroId;
    final articleVideo = widget.article.video;
    String youtubeUrl = "";
    String dailymotionUrl = "";
    if (articleVideo.contains("youtube")) {
      youtubeUrl = articleVideo.split('?v=')[1];
    }
    if (articleVideo.contains("dailymotion")) {
      dailymotionUrl = articleVideo.split("/video/")[1];
    }

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.white70),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: Hero(
                        tag: heroId,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60.0)),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.overlay),
                            child: articleVideo != ""
                                ? articleVideo.contains("youtube")
                                    ? Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0,
                                            MediaQuery.of(context).padding.top,
                                            0,
                                            0),
                                        decoration:
                                            BoxDecoration(color: Colors.black),
                                        child: HtmlWidget(
                                          """
                                      <iframe src="https://www.youtube.com/embed/$youtubeUrl" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                      """,
                                          webView: true,
                                        ),
                                      )
                                    : articleVideo.contains("dailymotion")
                                        ? Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0,
                                                MediaQuery.of(context)
                                                    .padding
                                                    .top,
                                                0,
                                                0),
                                            decoration: BoxDecoration(
                                                color: Colors.black),
                                            child: HtmlWidget(
                                              """
                                      <iframe frameborder="0"
                                      src="https://www.dailymotion.com/embed/video/$dailymotionUrl?autoplay=1&mute=1"
                                      allowfullscreen allow="autoplay">
                                      </iframe>
                                      """,
                                              webView: true,
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0,
                                                MediaQuery.of(context)
                                                    .padding
                                                    .top,
                                                0,
                                                0),
                                            decoration: BoxDecoration(
                                                color: Colors.black),
                                            child: HtmlWidget(
                                              """
                                      <video autoplay="" playsinline="" controls>
                                      <source type="video/mp4" src="$articleVideo">
                                      </video>
                                      """,
                                              webView: true,
                                            ),
                                          )
                                : Image.network(
                                    article.image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Html(data: "<h2>" + article.title + "</h2>", style: {
                        "h2": Style(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize.em(1.6),
                            padding: EdgeInsets.all(4)),
                      }),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFE3E3E3),
                            borderRadius: BorderRadius.circular(3)),
                        padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                        margin: EdgeInsets.all(16),
                        child: Text(
                          article.category,
                          style: TextStyle(color: Colors.black, fontSize: 11),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(article.avatar),
                          ),
                          title: Text(
                            "By " + article.author,
                            style: TextStyle(fontSize: 12),
                          ),
                          subtitle: Text(
                            article.date,
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 36, 16, 50),
                        child: HtmlWidget(
                          article.content,
                          webView: true,
                          textStyle: Theme.of(context).textTheme.bodyText1 ?? TextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                relatedPosts(_futureRelatedArticles as Future<List<dynamic>>)
              ],
            ),
          )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(color: Colors.white10),
          height: 50,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.comment,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Comments(article.id),
                          fullscreenDialog: true,
                        ));
                  },
                ),
              ),
              Container(
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.share,
                    color: Colors.green,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Share.share('Share the news: ' + article.link);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget relatedPosts(Future<List<dynamic>> latestArticles) {
    return FutureBuilder<List<dynamic>>(
      future: latestArticles,
      builder: (context, articleSnapshot) {
        if (articleSnapshot.hasData) {
          if (articleSnapshot.data!.length == 0) return Container();
          return Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(16),
                child: Text(
                  "Related Posts",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"),
                ),
              ),
              Column(
                children: articleSnapshot.data!.map((item) {
                  final heroId = item.id.toString() + "-related";
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleArticle(item, heroId),
                        ),
                      );
                    },
                    child: articleBox(context, item, heroId),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 24,
              )
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
            width: MediaQuery.of(context).size.width,
            height: 150
            );
      },
    );
  }
}
