import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

Widget articleBox(String title, String excerpt, String image, String authorName,
    String avatar) {
  return ConstrainedBox(
    constraints: new BoxConstraints(
      minHeight: 160.0,
      maxHeight: 180.0,
    ),
    child: Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.fromLTRB(20, 16, 8, 10),
          child: Card(
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.fromLTRB(110, 0, 0, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 55,
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(avatar),
                      ),
                      title: Text(
                        "By " + authorName,
                        style: TextStyle(fontSize: 12),
                      ),
                      subtitle: Text(
                        'Janaury 23, 2019',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 8),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Html(
                              data: title.length > 50
                                  ? "<h1>" + title.substring(0, 50) + "...</h1>"
                                  : "<h1>" + title + "</h1>",
                              customTextStyle:
                                  (dom.Node node, TextStyle baseStyle) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "h1":
                                      return baseStyle.merge(TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Poppins",
                                          color: Colors.black,
                                          height: 1.3,
                                          fontWeight: FontWeight.w500));
                                  }
                                }
                                return baseStyle;
                              }),
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
        SizedBox(
          height: 170,
          width: 145,
          child: Card(
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(8.0),
              child: Image.network(
                image,
                fit: BoxFit.cover,
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
