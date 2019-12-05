import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

Widget commentBox(String author, String avatar, String content) {
  return Card(
    margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: ListTile(
      dense: true,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatar),
      ),
      title: Html(
          data: content,
          customTextStyle: (dom.Node node, TextStyle baseStyle) {
            if (node is dom.Element) {
              switch (node.localName) {
                case "p":
                  return baseStyle.merge(TextStyle(
                      fontSize: 13, color: Colors.black, fontFamily: "Nunito"));
              }
            }
            return baseStyle;
          }),
      subtitle: Container(
        margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
        decoration: BoxDecoration(border: ),
        child: Text(
          "━ " + author,
          style: TextStyle(fontSize: 12),
        ),
      ),
    ),
  );
}
