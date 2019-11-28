import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icilome_mobile/common/screen_arguments.dart';
import 'package:icilome_mobile/models/Category.dart';
import 'package:icilome_mobile/pages/category_articles.dart';

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
            itemCount: categorySnapshot.data.length,
            itemBuilder: (BuildContext ctxt, int index) {
              Category category = categorySnapshot.data[index];
              if (category.parent == 0) {
                return Card(
                    child: ExpansionTile(
                  initiallyExpanded: false,
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
                      padding: EdgeInsets.all(8),
                      child: Text(
                        category.name + " (" + category.count.toString() + ")",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: ListView.builder(
                          itemCount: categorySnapshot.data.length,
                          shrinkWrap: true,
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
                    )
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
          child: Image.network(
              "https://static-steelkiwi-dev.s3.amazonaws.com/media/filer_public/2b/3b/2b3b2d3a-437b-4e0a-99cc-d837b5177baf/7d707b62-bb0c-4828-8376-59c624b2937b.gif"));
    },
  );
}
