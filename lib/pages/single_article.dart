import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:icilome_mobile/blocs/favArticleBloc.dart';
import 'package:icilome_mobile/common/screen_arguments.dart';
import 'package:icilome_mobile/pages/comments.dart';
import 'package:share/share.dart';

class SingleArticle extends StatefulWidget {
  final dynamic article;
  final String heroId;

  SingleArticle(this.article, this.heroId, {Key key}) : super(key: key);

  @override
  _SingleArticleState createState() => _SingleArticleState();
}

class _SingleArticleState extends State<SingleArticle> {
  final FavArticleBloc favArticleBloc = FavArticleBloc();

  Future<dynamic> favArticle;

  @override
  void initState() {
    super.initState();
    favArticle = favArticleBloc.getFavArticle(widget.article.id);
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    final heroId = widget.heroId;

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.white70),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: Hero(
                        tag: heroId,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60.0)),
                          child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.overlay),
                              child: Image.network(
                                article.image,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Html(
                          data: "<h1>" + article.title + "</h1>",
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                          customTextStyle:
                              (dom.Node node, TextStyle baseStyle) {
                            if (node is dom.Element) {
                              switch (node.localName) {
                                case "h1":
                                  return baseStyle.merge(TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500));
                              }
                            }
                            return baseStyle;
                          }),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.amber.shade200,
                            borderRadius: BorderRadius.circular(3)),
                        padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                        margin: EdgeInsets.all(16),
                        child: Text(
                          article.category,
                          style: TextStyle(color: Colors.black, fontSize: 11),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(article.avatar),
                          ),
                          title: Text(
                            "By " + article.author,
                            style: TextStyle(fontSize: 12),
                          ),
                          subtitle: Text(
                            article.date,
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                      Html(
                          data: "<div>" + article.content + "</div>",
                          padding: EdgeInsets.fromLTRB(16, 36, 16, 50),
                          customTextStyle:
                              (dom.Node node, TextStyle baseStyle) {
                            if (node is dom.Element) {
                              switch (node.localName) {
                                case "div":
                                  return baseStyle.merge(TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                      fontFamily: "Nunito"));
                              }
                            }
                            return baseStyle;
                          }),
                    ],
                  ),
                )
              ],
            ),
          )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(color: Colors.white10),
          height: 50,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FutureBuilder<dynamic>(
                  future: favArticle,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Container(
                        decoration: BoxDecoration(),
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 24.0,
                          ),
                          onPressed: () {
                            // Favourite post
                            favArticleBloc.deleteFavArticleById(article.id);
                            setState(() {
                              favArticle =
                                  favArticleBloc.getFavArticle(article.id);
                            });
                          },
                        ),
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 24.0,
                        ),
                        onPressed: () {
                          favArticleBloc.addFavArticle(article);
                          setState(() {
                            favArticle =
                                favArticleBloc.getFavArticle(article.id);
                          });
                        },
                      ),
                    );
                  }),
              Container(
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.comment,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Comments(),
                            fullscreenDialog: true,
                            settings: RouteSettings(
                              arguments: CommentScreenArguments(article.id),
                            )));
                  },
                ),
              ),
              Container(
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.share,
                    color: Colors.green,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Share.share('check out my website https://example.com');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
