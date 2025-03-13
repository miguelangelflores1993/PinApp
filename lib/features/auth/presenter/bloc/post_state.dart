part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState({
    required this.post,
    required this.exception,
    required this.status,
    required this.comments,
    required this.showComment,
  });

  PostState.initial()
    : post = [],
      exception = null,
      comments = [],
      showComment = false,
      status = FormStatus.initial;

  final List<Post>? post;
  final CustomException? exception;
  final FormStatus? status;
  final bool? showComment;
  final List<Comments>? comments;

  PostState copyWith({
    FormStatus? status,
    bool? showComment,
    List<Post>? post,
    List<Comments>? comments,
    CustomException? Function()? exception,
  }) => ConcreteCountryState(
    status: status ?? this.status,
    comments: comments ?? this.comments,
    showComment: showComment ?? this.showComment,
    post: post ?? this.post,
    exception: exception != null ? exception() : this.exception,
  );
  @override
  List<Object?> get props => [post, status, exception, comments];
}

class ConcreteCountryState extends PostState {
  const ConcreteCountryState({
    required super.post,
    required super.exception,
    required super.status,
    required super.showComment,
    required super.comments,
  });

  ConcreteCountryState.initial() : super.initial();
}
