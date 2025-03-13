part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostEvent extends PostEvent {
  const GetAllPostEvent();

  @override
  List<Object> get props => [];
}

class GetAllCommentsByPostId extends PostEvent {
  const GetAllCommentsByPostId({required this.postId});
  final int postId;

  @override
  List<Object> get props => [];
}
