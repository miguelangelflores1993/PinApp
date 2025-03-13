import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miguel/core/enums/form_enum.dart';
import 'package:miguel/features/auth/presenter/bloc/post_bloc.dart';
import 'package:miguel/features/auth/presenter/page/widget/post_card.dart';
import 'package:miguel/injection.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PostBloc>()..add(const GetAllPostEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xff1E3E62),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff1E3E62),
          title: const Text(
            'Post',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state.status == FormStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == FormStatus.error) {
              return Center(
                child: Text(
                  'Error: ${state.exception?.message ?? "Unknown error"}',
                ),
              );
            } else if (state.post?.isEmpty ?? true) {
              return const Center(child: Text('No hay posts disponibles'));
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              itemCount: state.post?.length ?? 0,
              itemBuilder: (context, index) {
                final post = state.post?[index];
                return PostCard(post: post, comments: state.comments ?? []);
              },
            );
          },
        ),
      ),
    );
  }
}
