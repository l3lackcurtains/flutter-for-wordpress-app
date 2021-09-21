import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wordpress_app/common/constants.dart';
import 'package:flutter_wordpress_app/models/Comment.dart';
import 'package:flutter_wordpress_app/widgets/commentBox.dart';
import 'package:http/http.dart' as http;

import 'add_comment.dart';

Future<List<dynamic>> fetchComments(int id) async {
  try {
    var response = await http
        .get(Uri.parse("$WORDPRESS_URL/wp-json/wp/v2/comments?post=" + id.toString()));

    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map((m) => Comment.fromJson(m))
          .toList();
    } else {
      throw "Error loading posts";
    }
  } on SocketException {
    throw 'No Internet connection';
  }
}

class Comments extends StatefulWidget {
  final int commentId;

  Comments(this.commentId, {Key? key}) : super(key: key);
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    int commentId = widget.commentId;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Comments',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins')),
        elevation: 5,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              children: <Widget>[commentSection(fetchComments(commentId))]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddComment(commentId),
                fullscreenDialog: true,
              ));
        },
        child: Icon(Icons.add_comment),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

Widget commentSection(Future<List<dynamic>> comments) {
  return FutureBuilder<List<dynamic>>(
    future: comments,
    builder: (context, commentSnapshot) {
      if (commentSnapshot.hasData) {
        if (commentSnapshot.data!.length == 0)
          return Container(
            height: 500,
            alignment: Alignment.center,
            child: Text(
              "No Comments.\nBe the first to write one.",
              textAlign: TextAlign.center,
            ),
          );
        return Column(
            children: commentSnapshot.data!.map((item) {
          return InkWell(
            onTap: () {},
            child: commentBox(context, item.author, item.avatar, item.content),
          );
        }).toList());
      } else if (commentSnapshot.hasError) {
        return Container(
            height: 500,
            alignment: Alignment.center,
            child: Text("${commentSnapshot.error}"));
      }
      return Container(
        alignment: Alignment.center,
        height: 400,
      );
    },
  );
}
