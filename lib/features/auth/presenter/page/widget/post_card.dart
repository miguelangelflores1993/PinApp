import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miguel/features/auth/domain/entities/comments_entity.dart';
import 'package:miguel/features/auth/domain/entities/post_entity.dart';
import 'package:miguel/features/auth/presenter/bloc/post_bloc.dart';
import 'package:miguel/features/auth/presenter/page/widget/comment_item.dart';
import 'package:miguel/features/auth/presenter/page/widget/post_action.dart';

class PostCard extends StatefulWidget {
  const PostCard({required this.post, required this.comments, super.key});
  final Post? post;
  final List<Comments> comments;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.post == null) return const SizedBox.shrink();

    // Filtrar comentarios por postId
    final postComments =
        widget.comments
            .where((comment) => comment.postId == widget.post!.id)
            .toList();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: const Color(0xff0B192C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado del post
            Text(
              widget.post!.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            // Contenido del post
            Text(
              widget.post!.body,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 8),

            // Acciones del post
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  icon: Icons.thumb_up_outlined,

                  label: 'Me gusta',
                  onPressed: () {},
                ),
                ActionButton(
                  icon: Icons.comment_outlined,
                  label: 'Ver comentarios',
                  onPressed: () {
                    context.read<PostBloc>().add(
                      GetAllCommentsByPostId(postId: widget.post?.id ?? 0),
                    );
                  },
                ),
                ActionButton(
                  icon: Icons.share_outlined,
                  label: 'Compartir',
                  onPressed: () {},
                ),
              ],
            ),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return Column(
                  children: [
                    if (postComments.isNotEmpty) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              '${postComments.length} comentarios',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Lista de comentarios
                          ...postComments.map(
                            (comment) => CommentItem(comment: comment),
                          ),
                        ],
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
