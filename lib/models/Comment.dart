class Comment {
  final int id;
  final String author;
  final int parent;
  final String avatar;
  final DateTime date;
  final String content;

  Comment(
      {this.id,
      this.author,
      this.parent,
      this.date,
      this.avatar,
      this.content});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        author: json['author_name'],
        parent: json['parent'],
        date: DateTime.parse(json["date"]),
        avatar: json['author_avatar_urls']["48"],
        content: json["content"]["rendered"]);
  }
}
