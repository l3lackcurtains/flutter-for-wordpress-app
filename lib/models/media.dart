class Media {
  final int id;
  final String image;

  Media({
    this.id,
    this.image,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
        id: json['id'],
        image: json['source_url'] != null
            ? json["source_url"]
            : "https://images.wallpaperscraft.com/image/surface_dark_background_texture_50754_1920x1080.jpg");
  }
}
