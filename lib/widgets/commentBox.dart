import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';

Widget commentBox(BuildContext context, String author, String avatar,
    DateTime date, String content) {
  return Card(
    margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: ListTile(
      isThreeLine: true,
      dense: true,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatar),
      ),
      title: Html(
        data: content,
        style: {
          "p": Style(
              fontFamily: 'serif',
              color: Colors.black,
              fontSize: FontSize.medium),
        },
      ),
      subtitle: Container(
        margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
        padding: EdgeInsets.fromLTRB(4, 8, 0, 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        child: Text(
          author + '\n' + DateFormat('EEEE, d LLLL yyyy').add_jm().format(date),
          style: TextStyle(fontSize: 12),
        ),
      ),
    ),
  );
}
