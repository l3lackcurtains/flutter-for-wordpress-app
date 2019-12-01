import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

Widget articleBoxFeatured(
    String title,
    String excerpt,
    String image,
    String authorName,
    String avatar,
    String category,
    String date,
    String heroId) {
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
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 8),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Html(
                                data: title.length > 50
                                    ? "<h1>" +
                                        title.substring(0, 50) +
                                        "...</h1>"
                                    : "<h1>" + title + "</h1>",
                                customTextStyle:
                                    (dom.Node node, TextStyle baseStyle) {
                                  if (node is dom.Element) {
                                    switch (node.localName) {
                                      case "h1":
                                        return baseStyle.merge(TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                            height: 1.3,
                                            fontWeight: FontWeight.w600));
                                    }
                                  }
                                  return baseStyle;
                                }),
                          ),
                          SizedBox(
                            height: 35,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.black),
                                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Text(
                                    date,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 11),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Html(
                                data: excerpt.substring(0, 36) + "...",
                                customTextStyle:
                                    (dom.Node node, TextStyle baseStyle) {
                                  if (node is dom.Element) {
                                    switch (node.localName) {
                                      case "p":
                                        return baseStyle.merge(TextStyle(
                                            fontSize: 13,
                                            height: 0.5,
                                            color: Colors.black54,
                                            fontFamily: "Nunito"));
                                    }
                                  }
                                  return baseStyle;
                                }),
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
      ],
    ),
  );
}
