class Comments {
  const Comments({
    required this.postId,
    required this.email,
    required this.id,
    required this.name,
    required this.body,
  });

  final int postId;
  final String name;
  final int id;
  final String email;
  final String body;
}
