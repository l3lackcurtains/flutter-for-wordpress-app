class Category {
  final int id;
  final String name;
  final int parent;
  final int count;

  Category({this.id, this.name, this.parent, this.count});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        name: json['name'],
        parent: json['parent'],
        count: json["count"]);
  }
}
