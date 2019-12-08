import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icilome_mobile/models/Category.dart';
import 'package:icilome_mobile/pages/category_articles.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

Future<List<dynamic>> fetchCategories() async {
  try {
    var response = await http
        .get("https://demo.icilome.net/wp-json/wp/v2/categories?per_page=100");

    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map((m) => Category.fromJson(m))
          .toList();
    } else {
      throw Exception('Failed to load posts');
    }
  } on SocketException {
    throw 'No Internet connection';
  }
}

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<List<dynamic>> categories;

  @override
  void initState() {
    super.initState();
    categories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins')),
        elevation: 5,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: getCategoriesList(categories),
      ),
    );
  }
}

Widget getCategoriesList(Future<List<dynamic>> categories) {
  return FutureBuilder<List<dynamic>>(
    future: categories,
    builder: (context, categorySnapshot) {
      if (categorySnapshot.hasData) {
        if (categorySnapshot.data.length == 0) return Container();
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: categorySnapshot.data.length,
            itemBuilder: (BuildContext ctxt, int index) {
              Category category = categorySnapshot.data[index];
              if (category.parent == 0) {
                return Card(
                    elevation: 1,
                    margin: EdgeInsets.all(8),
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      backgroundColor: Color(0xFFF9F9F9),
                      title: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryArticles(category.id, category.name),
                            ),
                          );
                        },
                        child: Text(
                          category.name,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: categorySnapshot.data.length,
                              itemBuilder: (BuildContext ctxt2, int index2) {
                                Category subCategory =
                                    categorySnapshot.data[index2];
                                if (subCategory.parent == category.id) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryArticles(subCategory.id,
                                                    subCategory.name),
                                          ),
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(subCategory.name),
                                      ));
                                }
                                return Container();
                              }),
                        ),
                      ],
                    ));
              }
              return Container();
            });
      } else if (categorySnapshot.hasError) {
        return Container(
            height: 500,
            alignment: Alignment.center,
            child: Text("${categorySnapshot.error}"));
      }
      return Container(
          alignment: Alignment.center,
          child: Loading(
              indicator: BallBeatIndicator(),
              size: 60.0,
              color: Colors.redAccent));
    },
  );
}
