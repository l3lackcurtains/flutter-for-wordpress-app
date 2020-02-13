import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress_app/common/constants.dart';

Future<bool> postComment(
    int id, String name, String email, String website, String comment) async {
  try {
    Dio dio = new Dio();
    Response response =
        await dio.post("$WORDPRESS_URL/wp-json/wp/v2/comments", data: {
      "author_email": email,
      "author_name": name,
      "author_website": website,
      "content": comment,
      "post": id
    });

    if (response != null) {
      return true;
    }
    return false;
  } catch (e) {
    throw Exception('Failed to load posts');
  }
}

class AddComment extends StatefulWidget {
  final int commentId;

  AddComment(this.commentId, {Key key}) : super(key: key);
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _email = "";
  String _website = "";
  String _comment = "";

  @override
  Widget build(BuildContext context) {
    int commentId = widget.commentId;
    print(commentId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Add Comment',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins')),
        elevation: 5,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.fromLTRB(24, 36, 24, 36),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name *',
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name.';
                          }
                          return null;
                        },
                        onSaved: (String val) {
                          _name = val;
                        }),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email *',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your email.';
                          }
                          return null;
                        },
                        onSaved: (String val) {
                          _email = val;
                        }),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Website',
                        ),
                        onSaved: (String val) {
                          _website = val;
                        }),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Comment *',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Write some comment.';
                          }
                          return null;
                        },
                        onSaved: (String val) {
                          _comment = val;
                        }),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 36.0),
                      height: 120,
                      child: RaisedButton.icon(
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            postComment(commentId, _name, _email, _website,
                                    _comment)
                                .then((back) {
                              if (back) {
                                Navigator.of(context).pop();
                              }
                            });
                          }
                        },
                        label: Text(
                          'Send Comment',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ) // Build this out in the next steps.
                ),
          ),
        ),
      ),
    );
  }
}
