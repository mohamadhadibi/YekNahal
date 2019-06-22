import 'package:equatable/equatable.dart';

class BlogSearchResponse {
  int status;
  List<BlogOb> data;
  String message;

  BlogSearchResponse({
    this.status,
    this.message,
    this.data,
  });

  factory BlogSearchResponse.fromJson(Map<String, dynamic> json) {
    return BlogSearchResponse(
        status: json['status'],
        message: json['message'],
        data: (json['data'] as List).map((i) => BlogOb.fromJson(i)).toList()
    );
  }
}

class BlogOb extends Equatable {
  int id;
  String image;
  String title;
  String author;
  String category;
  String date_fa;
  int comment_count;
  String tags;
  String status;
  String body;

  BlogOb({
    this.id,
    this.image,
    this.title,
    this.author,
    this.category,
    this.date_fa,
    this.comment_count,
    this.tags,
    this.status,
    this.body,
  });

  factory BlogOb.fromJson(Map<String, dynamic> json) {
    return BlogOb(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      author: json['author'],
      category: json['category'],
      date_fa: json['date_fa'],
      comment_count: json['comment_count'],
      tags: json['tags'],
      status: json['status'],
      body: json['body'],
    );
  }

  @override
  String toString() => 'BlogOb { id: $id }';

}
