import 'dart:convert';

import 'package:miguel/features/auth/domain/entities/comments_entity.dart';

CommentsModel commentsFromJson(String str) =>
    CommentsModel.fromJson(json.decode(str) as Map<String, dynamic>);

String commentsToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel extends Comments {
  CommentsModel({
    required super.postId,
    required super.id,
    required super.name,
    required super.email,
    required super.body,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    return CommentsModel(
      postId: json['postId'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );
  }

  CommentsModel copyWith({
    int? postId,
    int? id,
    String? name,
    String? email,
    String? body,
  }) => CommentsModel(
    postId: postId ?? this.postId,
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    body: body ?? this.body,
  );

  Map<String, dynamic> toJson() => {
    'postId': postId,
    'id': id,
    'name': name,
    'email': email,
    'body': body,
  };
}
