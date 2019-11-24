class Author {
  final int id;
  final String name;
  final String avatar;

  Author({
    this.id,
    this.name,
    this.avatar,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    String avatar = json['avatar_urls'] != null
        ? json["avatar_urls"]["96"] != null
            ? json["avatar_urls"]["96"]
            : "https://images.wallpaperscraft.com/image/surface_dark_background_texture_50754_1920x1080.jpg"
        : "https://images.wallpaperscraft.com/image/surface_dark_background_texture_50754_1920x1080.jpg";
    String name = json["name"] != null ? json["name"] : "Icilome";
    return Author(id: json['id'], name: name, avatar: avatar);
  }
}
