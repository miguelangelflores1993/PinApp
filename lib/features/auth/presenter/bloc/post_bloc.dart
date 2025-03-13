import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miguel/core/enums/form_enum.dart';
import 'package:miguel/core/usecases/usecase.dart';
import 'package:miguel/features/auth/domain/entities/comments_entity.dart';
import 'package:miguel/features/auth/domain/entities/post_entity.dart';
import 'package:miguel/features/auth/domain/usecases/get_all_comments.dart';
import 'package:miguel/features/auth/domain/usecases/get_all_post.dart';
import 'package:networking_flutter_dio/core/networking/custom_exception.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({
    required this.getAllCommentsByPostIdUseCase,
    required this.getAllPostUseCase,
  }) : super(ConcreteCountryState.initial()) {
    on<GetAllCommentsByPostId>((event, emit) async {
      emit(state.copyWith(status: FormStatus.loadingComments));
      final result = await getAllCommentsByPostIdUseCase(
        ParamsGetAllCommentsWithPostId(postId: event.postId),
      );
      result.fold(
        (error) {
          emit(state.copyWith(exception: () => error));
        },
        (response) {
          emit(
            state.copyWith(
              status: FormStatus.submitSuccess,
              comments: response,
              exception: () => null,
            ),
          );
        },
      );
    });
    on<GetAllPostEvent>((event, emit) async {
      emit(state.copyWith(status: FormStatus.loading));
      final result = await getAllPostUseCase(NoParams());
      result.fold(
        (error) {
          emit(state.copyWith(exception: () => error));
        },
        (response) {
          emit(
            state.copyWith(
              post: response,
              status: FormStatus.submitSuccess,
              exception: () => null,
            ),
          );
        },
      );
    });
  }
  final GetAllCommentsByPostIdUseCase getAllCommentsByPostIdUseCase;
  final GetAllPostUseCase getAllPostUseCase;
}
