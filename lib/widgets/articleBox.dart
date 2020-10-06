import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_wordpress_app/models/Article.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

Widget articleBox(BuildContext context, Article article, String heroId) {
  return ConstrainedBox(
    constraints: new BoxConstraints(
      minHeight: 160.0,
      maxHeight: 175.0,
    ),
    child: Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.fromLTRB(20, 16, 8, 0),
          child: Card(
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.fromLTRB(110, 0, 0, 0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 4, 3),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Html(
                            data: article.title.length > 70
                                ? "<h1>" +
                                    article.title.substring(0, 70) +
                                    "...</h1>"
                                : "<h1>" + article.title + "</h1>",
                            style: {
                              "h1": Style(
                                  color: Colors.black,
                                  fontSize: FontSize.medium),
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFE3E3E3),
                                    borderRadius: BorderRadius.circular(3)),
                                padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: Text(
                                  article.category,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.timer,
                                      color: Colors.black45,
                                      size: 12.0,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      article.date,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.comment_rounded,
                                      color: Colors.black45,
                                      size: 12.0,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      article.commentsNumber.toString(),
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 170,
          width: 145,
          child: Card(
            child: Hero(
              tag: heroId,
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://res.cloudinary.com/demo/image/fetch/h_600,q_auto:best/" +
                          article.image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Loading(
                        indicator: BallBeatIndicator(),
                        size: 60.0,
                        color: Theme.of(context).accentColor),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            margin: EdgeInsets.all(10),
          ),
        ),
        article.video != ""
            ? Positioned(
                left: 12,
                top: 12,
                child: Card(
                  color: Theme.of(context).accentColor,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/play-button.png"),
                  ),
                  elevation: 8,
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                ),
              )
            : Container(),
      ],
    ),
  );
}
