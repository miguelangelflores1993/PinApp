import 'dart:convert';

import 'package:miguel/features/auth/domain/entities/post_entity.dart';

PostModel postFromJson(String str) =>
    PostModel.fromJson(json.decode(str) as Map<String, dynamic>);

String postToJson(PostModel data) => json.encode(data.toJson());

class PostModel extends Post {
  PostModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    userId: json['userId'] == null ? 0 : json['userId'] as int,
    id: json['id'] == null ? 0 : json['id'] as int,
    title: json['title'] == null ? '' : json['title'] as String,
    body: json['body'] == null ? '' : json['body'] as String,
  );

  PostModel copyWith({int? userId, int? id, String? title, String? body}) =>
      PostModel(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
      );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'body': body,
  };
}
