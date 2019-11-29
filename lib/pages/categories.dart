import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icilome_mobile/common/screen_arguments.dart';
import 'package:icilome_mobile/models/Category.dart';
import 'package:icilome_mobile/pages/category_articles.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

Future<List<dynamic>> fetchCategories() async {
  try {
    Dio dio = new Dio();
    Response response = await dio
        .get("https://demo.icilome.net/wp-json/wp/v2/categories?per_page=100");

    if (response.statusCode == 200) {
      return response.data.map((m) => Category.fromJson(m)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  } catch (e) {
    throw Exception('Failed to load posts' + e.toString());
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
        title: const Text('Categories',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins')),
        elevation: 1,
        backgroundColor: Colors.white,
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
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: categorySnapshot.data.length,
            itemBuilder: (BuildContext ctxt, int index) {
              Category category = categorySnapshot.data[index];
              if (category.parent == 0) {
                return Card(
                    elevation: 0,
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      backgroundColor: Color(0xFFBDBDBDE3E3E3),
                      title: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryArticles(),
                              settings: RouteSettings(
                                arguments: CategoryArticlesScreenArguments(
                                    category.id, category.name),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                          child: Text(
                            category.name +
                                " (" +
                                category.count.toString() +
                                ")",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      children: <Widget>[
                        ListView.builder(
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
                                              CategoryArticles(),
                                          settings: RouteSettings(
                                            arguments:
                                                CategoryArticlesScreenArguments(
                                                    subCategory.id,
                                                    subCategory.name),
                                          ),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      title: Text(subCategory.name +
                                          " (" +
                                          subCategory.count.toString() +
                                          ")"),
                                    ));
                              }
                              return Container();
                            }),
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
