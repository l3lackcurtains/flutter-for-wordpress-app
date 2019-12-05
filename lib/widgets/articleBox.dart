import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:icilome_mobile/models/Article.dart';

Widget articleBox(BuildContext context, Article article, String heroId) {
  return ConstrainedBox(
    constraints: new BoxConstraints(
      minHeight: 160.0,
      maxHeight: 180.0,
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
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 8),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Html(
                              data: article.title.length > 100
                                  ? "<h1>" +
                                      article.title.substring(0, 50) +
                                      "...</h1>"
                                  : "<h1>" + article.title + "</h1>",
                              customTextStyle:
                                  (dom.Node node, TextStyle baseStyle) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "h1":
                                      return baseStyle.merge(
                                          Theme.of(context).textTheme.title);
                                  }
                                }
                                return baseStyle;
                              }),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.fromLTRB(4, 0, 8, 8),
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
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.person,
                                        color: Colors.black45,
                                        size: 12.0,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        article.author,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber.shade200,
                                    borderRadius: BorderRadius.circular(3)),
                                padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                child: Text(
                                  article.category,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
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
                child: Image.network(
                  article.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            margin: EdgeInsets.all(10),
          ),
        )
      ],
    ),
  );
}
