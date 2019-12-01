import 'package:intl/intl.dart';

class Article {
  final int id;
  final String title;
  final String content;
  final String excerpt;
  final String image;
  final String author;
  final String avatar;
  final String category;
  final String date;

  Article(
      {this.id,
      this.title,
      this.content,
      this.excerpt,
      this.image,
      this.author,
      this.avatar,
      this.category,
      this.date});

  factory Article.fromJson(Map<String, dynamic> json) {
    String content = json['content'] != null ? json['content']['rendered'] : "";

    String image = json['_embedded']["wp:featuredmedia"] != null
        ? json['_embedded']["wp:featuredmedia"][0]["source_url"]
        : "https://images.wallpaperscraft.com/image/surface_dark_background_texture_50754_1920x1080.jpg";

    String author = json['_embedded']["author"][0]["name"];

    String avatar = json["_embedded"]["author"][0] != null
        ? json["_embedded"]["author"][0]["avatar_urls"]["48"]
        : "https://images.wallpaperscraft.com/image/surface_dark_background_texture_50754_1920x1080.jpg";

    String category = json["_embedded"]["wp:term"][0][0] != null
        ? json["_embedded"]["wp:term"][0][0]["name"]
        : "N/A";

    String date = DateFormat('dd MMMM, yyyy', 'en_US')
        .format(DateTime.parse(json["date"]))
        .toString();

    return Article(
        id: json['id'],
        title: json['title']['rendered'],
        content: content,
        excerpt: json['excerpt']['rendered'],
        image: image,
        author: author,
        avatar: avatar,
        category: category,
        date: date);
  }
}
