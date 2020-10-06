import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress_app/common/constants.dart';
import 'package:flutter_wordpress_app/pages/category_articles.dart';

Widget searchBoxes(BuildContext context) {
  return GridView.count(
    padding: EdgeInsets.all(16),
    shrinkWrap: true,
    physics: ScrollPhysics(),
    crossAxisCount: 3,
    children: List.generate(CUSTOM_CATEGORIES.length, (index) {
      var cat = CUSTOM_CATEGORIES[index];
      var name = cat[0];
      var image = cat[1];
      var catId = cat[2];

      return Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryArticles(catId, name),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 45,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://res.cloudinary.com/demo/image/fetch/h_600,q_auto:best/" +
                            image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Spacer(),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }),
  );
}
