import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icilome_mobile/common/screen_arguments.dart';
import 'package:icilome_mobile/models/Article.dart';
import 'package:icilome_mobile/pages/single_article.dart';
import 'package:icilome_mobile/widgets/articleBox.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

Future<List<dynamic>> fetchArticles(String searchText, bool empty) async {
  try {
    if (empty) {
      searchText = "12g2g12vhgv2hg1v2ghv1hg2vhg1v2gh1v2"; // No posts.
    }

    Dio dio = new Dio();
    Response response = await dio.get(
        "http://demo.icilome.net/wp-json/wp/v2/posts?_embed&search=" +
            searchText);

    if (response.statusCode == 200) {
      return response.data.map((m) => Article.fromJson(m)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  } catch (e) {
    throw Exception('Failed to load posts');
  }
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<List<dynamic>> articles;

  @override
  void initState() {
    super.initState();
    articles = fetchArticles("", true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search News',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins')),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  elevation: 6,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                    child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Type some query',
                          suffixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onChanged: (text) {
                          setState(() {
                            articles = fetchArticles(text, text == "");
                          });
                        }),
                  ),
                ),
              ),
              searchPosts(articles)
            ],
          ),
        ),
      ),
    );
  }
}

Widget searchPosts(Future<List<dynamic>> articles) {
  return FutureBuilder<List<dynamic>>(
    future: articles,
    builder: (context, articleSnapshot) {
      if (articleSnapshot.hasData) {
        if (articleSnapshot.data.length == 0) {
          return Container(
              height: 300,
              alignment: Alignment.center,
              child: Text(
                "Type some query to search news.",
                style: TextStyle(fontSize: 18),
              ));
        }
        return Column(
            children: articleSnapshot.data.map((item) {
          final heroId = item.id.toString() + "-searched";
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleArticle(),
                  settings: RouteSettings(
                    arguments: SingleArticleScreenArguments(item, heroId),
                  ),
                ),
              );
            },
            child: articleBox(item.title, item.excerpt, item.image, item.author,
                item.avatar, heroId),
          );
        }).toList());
      } else if (articleSnapshot.hasError) {
        return Container(
            height: 500,
            alignment: Alignment.center,
            child: Text("${articleSnapshot.error}"));
      }
      return Container(
          alignment: Alignment.center,
          width: 300,
          height: 150,
          child: Loading(
              indicator: BallBeatIndicator(),
              size: 60.0,
              color: Colors.redAccent));
    },
  );
}
