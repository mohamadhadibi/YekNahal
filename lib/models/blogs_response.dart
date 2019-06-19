class BlogOb {
  String name;
  String imageUrl;

  BlogOb({
    this.name,
    this.imageUrl,
  });

  factory BlogOb.fromJson(Map<String, dynamic> json) {
    return BlogOb(
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
