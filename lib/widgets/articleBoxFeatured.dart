import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_wordpress_app/models/Article.dart';

Widget articleBoxFeatured(
    BuildContext context, Article article, String heroId) {
  return ConstrainedBox(
    constraints: new BoxConstraints(
        minHeight: 280.0, maxHeight: 290.0, minWidth: 360.0, maxWidth: 360.0),
    child: Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 200,
            width: 400,
            child: Card(
              child: Hero(
                tag: heroId,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://res.cloudinary.com/demo/image/fetch/h_600,q_auto:best/" +
                            article.image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  // Image.network(
                  //   "https://res.cloudinary.com/demo/image/fetch/h_600,q_auto:best/" +
                  //       article.image,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 1,
              margin: EdgeInsets.all(10),
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 80,
          right: 20,
          child: Container(
            alignment: Alignment.bottomRight,
            height: 200,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Card(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                                color: Colors.black, fontSize: FontSize.xLarge),
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
                              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
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
                              padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
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
                                    style: Theme.of(context).textTheme.caption,
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
          ),
        ),
        article.video != ""
            ? Positioned(
                left: 18,
                top: 18,
                child: Card(
                  color: Theme.of(context).accentColor,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/play-button.png"),
                  ),
                  elevation: 18.0,
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                ),
              )
            : Container()
      ],
    ),
  );
}
