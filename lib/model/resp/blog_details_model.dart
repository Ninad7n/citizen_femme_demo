// To parse this JSON data, do
//
//     final blogDetailsModel = blogDetailsModelFromJson(jsonString);

import 'dart:convert';

BlogDetailsModel blogDetailsModelFromJson(String str) =>
    BlogDetailsModel.fromJson(json.decode(str));

String blogDetailsModelToJson(BlogDetailsModel data) =>
    json.encode(data.toJson());

class BlogDetailsModel {
  int? id;
  String? title;
  String? content;
  String? authorName;
  String? createdDate;
  String? featuredImageUrl;

  BlogDetailsModel({
    this.id,
    this.title,
    this.content,
    this.authorName,
    this.createdDate,
    this.featuredImageUrl,
  });

  factory BlogDetailsModel.fromJson(Map<String, dynamic> json) =>
      BlogDetailsModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        authorName: json["author_name"],
        createdDate: json["created_date"],
        featuredImageUrl: json["featured_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "author_name": authorName,
        "created_date": createdDate,
        "featured_image_url": featuredImageUrl,
      };
}
